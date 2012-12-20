From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v6 0/7] make test output coloring more intuitive
Date: Thu, 20 Dec 2012 15:44:53 +0000
Message-ID: <CAOkDyE9y6JvNKTCBoJqu47Hn-3axfjZPUdBhf4bOEfSP-9Q84A@mail.gmail.com>
References: <1355682495-22382-1-git-send-email-git@adamspiers.org>
	<7v8v8xrfnp.fsf@alter.siamese.dyndns.org>
	<CAOkDyE9B_HfUZmqNqO35mtjTvdihBTiW=uOV2oEQgLUw1xyf=A@mail.gmail.com>
	<20121220153411.GA1497@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 20 16:45:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TliJ6-00089e-TT
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 16:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285Ab2LTPoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 10:44:55 -0500
Received: from mail-wg0-f43.google.com ([74.125.82.43]:39102 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab2LTPoy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 10:44:54 -0500
Received: by mail-wg0-f43.google.com with SMTP id e12so1620590wge.22
        for <git@vger.kernel.org>; Thu, 20 Dec 2012 07:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=xM78/XMW+9ZW5muuvaRhVIMmA/BJM703RHPvyp5jLJ0=;
        b=dzar2RGO4FdpUfWc6kZSWhC/VZffKxvNsvq6giL7cN/IHA/pwrQAo2EObk3ho9FT+t
         iIukoFbNjZ0l30NMVuazVdYGCZSfDWUuvynwKESsAIGi/ZGfOfd+e5r+8QkkZafwADnh
         MQkcNj2gZW6hLHoe8FYHTLMpjNbBZQmS7IaQ27XVB8dI4QJRc0CQUgjhZKmAG/CbI7uo
         sLWVLe9oqriTQutCoilr4jc+dBXWG45S9oWnjwgIWUYHfCDxYo2lAydlTt2z7V3U618a
         3RadJuJccLpWA+1XNqNUEkd1xOvKbfmwwhmIeObKKOXjqI/sLs3BFRrj9zDEMJJENg65
         JtdA==
Received: by 10.180.82.69 with SMTP id g5mr18360495wiy.21.1356018293074; Thu,
 20 Dec 2012 07:44:53 -0800 (PST)
Received: by 10.194.56.232 with HTTP; Thu, 20 Dec 2012 07:44:53 -0800 (PST)
In-Reply-To: <20121220153411.GA1497@sigill.intra.peff.net>
X-Google-Sender-Auth: 9fj1lOIO1M49QHPcu2H1utiuZak
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211898>

On Thu, Dec 20, 2012 at 3:34 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Dec 16, 2012 at 07:01:56PM +0000, Adam Spiers wrote:
>> On Sun, Dec 16, 2012 at 6:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > Adam Spiers <git@adamspiers.org> writes:
>> >> This series of commits attempts to make test output coloring
>> >> more intuitive,...
>> >
>> > Thanks; I understand that this is to replace the previous one
>> > b465316 (tests: paint unexpectedly fixed known breakages in bold
>> > red, 2012-09-19)---am I correct?
>>
>> Correct.  AFAICS I have incorporated all feedback raised in previous
>> reviews.
>>
>> > Will take a look; thanks.
>>
>> Thanks.  Sorry again for the delay.  I'm now (finally) resuming work
>> on as/check-ignore.
>
> I eyeballed the test output of "pu". I do think this resolves all of the
> issues brought up before, and I really hate to bikeshed on the colors at
> this point, but I find that bold cyan a bit hard on the eyes when
> running with "-v" (where most of the output is in that color, as it
> dumps the shell for each test).  Is there any reason not to tone it down
> a bit like:
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 256f1c6..31f59af 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -227,7 +227,7 @@ then
>                 pass)
>                         tput setaf 2;;            # green
>                 info)
> -                       tput bold; tput setaf 6;; # bold cyan
> +                       tput setaf 6;; # cyan
>                 *)
>                         test -n "$quiet" && return;;
>                 esac
>
> -Peff

Good point, I forgot to check what it looked like with -v.  Since this
series is already on v6, is there a more lightweight way of addressing
this tiny tweak than sending v7?
