From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH] Makefile: default to -lcurl when no CURL_CONFIG or CURLDIR
Date: Mon, 28 Apr 2014 13:46:58 -0700
Message-ID: <CAD0k6qR766hrgUtyiGzZ9KM5woknfsyUm3Mf1-Pm3M-LrL2Zhg@mail.gmail.com>
References: <1398714653-1050-1-git-send-email-dborowitz@google.com> <20140428200550.GO9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 22:47:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WesSS-0006p7-ET
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 22:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210AbaD1UrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 16:47:21 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55281 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374AbaD1UrU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 16:47:20 -0400
Received: by mail-lb0-f174.google.com with SMTP id c11so2535488lbj.19
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 13:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=L2zw+o6m4JM74Rgynk0w6jIshCPYaAp/MxtxowTwPOM=;
        b=n/D27SQx1e0qzZIoxpyLx78M3pAd4eJOpuW3YcfaBfjCdidt5X/OLYPzJ8Zzpwq9X/
         VXzMqLDCqu1OIKkt9PzHVEGqDregBGmCxOv0E+BvmIZoenulVzYTocsne2ngxk/P0KjX
         QObJMEdYm1IUaKK9G8A8MUYGZVYgS++72k1sI0NWhU1JZ0cNKjqzCWVBHAkfe/BezSI9
         70Zy4ZGjggiy3YUsKwgIb0LGPddn8ssgLDnoAGsP3LGhM28dRMb60+fIrxOQEWRj34zB
         pJ7V3fuVdUsD37iRkfK4KAORCikto7pC6t0lHJOeXOcEUO6oNF2tZSREL+d96Kw8VLVa
         SjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=L2zw+o6m4JM74Rgynk0w6jIshCPYaAp/MxtxowTwPOM=;
        b=VDIUu/2KMuDtHQ9PFYuvuiCknOMWvgXr+tbRB6fi+N3uj0i3iVeBuHbnUn4OG2b4LK
         hCv8YcJz1Ig9/FhjUXWu+nhH1MzHzDdQPH97f0fbNluMFcxhUlh55+Xc/5NMmR415myV
         CIVvM4IOUEgNDLLYwD8EH7j9tn8dw8Y9wMPQ8fpvekb4LygzP/vpUDEK46+8OMZ1kdma
         jUb0HLiYcxT6jm8+HICe4VozhNCfmGLgS/kdUbKApClDuUQSVy2PuK3gCWzYbSOXUKzo
         NEZZOEvgAuLa97H5CxYXTBuUJGGA09kr6zDBdJR/33MpR6zTTsSh+6ALBdGBI4pUO9TW
         QeUw==
X-Gm-Message-State: ALoCoQmnCg/uW6KOiqtSftRljGkWmGWdef5z+BmMImhh90HBEy3gpUKuUYfFxkHufNcuI2liHGC2jnL3RCjchIASZbHKGdDCaintpqgqf3ycU9GiUCRjlqozABDYsuyzNpIkmMyNXYnFvzFffi6Y14c5CZDtbxpwS26Fc4ciik41vg83Uffr0XrT5ZtX2tlKR+ScWnZW9sKw
X-Received: by 10.152.234.130 with SMTP id ue2mr20732216lac.0.1398718038251;
 Mon, 28 Apr 2014 13:47:18 -0700 (PDT)
Received: by 10.112.184.227 with HTTP; Mon, 28 Apr 2014 13:46:58 -0700 (PDT)
In-Reply-To: <20140428200550.GO9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247444>

On Mon, Apr 28, 2014 at 1:05 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Dave Borowitz wrote:
>
>> Instead, if CURL_CONFIG is empty or returns an empty result (e.g. due
>> to curl-config being missing), use the old behavior of falling back to
>> -lcurl.
>> ---
>>  Makefile | 36 +++++++++++++++++++++++++-----------
>>  1 file changed, 25 insertions(+), 11 deletions(-)
>
> Sign-off?

Oops.

> [...]
>> +++ b/Makefile
>> @@ -35,7 +35,9 @@ all::
>>  # transports (neither smart nor dumb).
>>  #
>>  # Define CURL_CONFIG to the path to a curl-config binary other than the
>> -# default 'curl-config'.
>> +# default 'curl-config'. If CURL_CONFIG is unset or points to a binary that
>> +# is not found, defaults to the CURLDIR behavior, or if CURLDIR is not set,
>> +# uses -lcurl with no additional library detection.
>
> I'm having a little trouble parsing this but don't have any better
> suggestion.

How about:
"If CURL_CONFIG is unset or points to a binary that is not found,
defaults to the CURLDIR behavior. If CURLDIR is not set, this means
using -lcurl with no additional library detection (other than
NEEDS_*_WITH_CURL).

[...]

>> -                             $(error libcurl not detected; try setting CURLDIR)
>> +                                $(error libcurl not detected or not compiled with static support)
>
> Whitespace damage.

Yes, but intentional, because Makefile parsing is weird.

$ echo -e 'ifndef FOO\n\t$(error bad things)\nendif\n\nfoo:\n\ttouch
foo' > mk1 && make -f mk1 foo
mk1:2: *** commands commence before first target.  Stop.
$ echo -e 'ifndef FOO\n  $(error bad things)\nendif\n\nfoo:\n\ttouch
foo' > mk2 && make -f mk2 foo
mk2:2: *** bad things.  Stop.

See also:
http://stackoverflow.com/questions/4713663/gnu-make-yields-commands-commence-before-first-target-error

> Except for the whitespace issues,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks.
