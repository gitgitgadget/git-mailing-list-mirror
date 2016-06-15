From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] verify-tag: allow to verify signed blob objects
Date: Wed, 15 Jun 2016 14:41:48 -0700
Message-ID: <CA+P7+xqV8t1cJeAtNQeWaFbKC5DrhpPoUJ9GWAuPrO=GZpKaiQ@mail.gmail.com>
References: <a6557333316c6f7996fa54eebc75abdf988ed9f9.1465991212.git.git@drmicha.warpmail.net>
 <xmqq8ty670v2.fsf@gitster.mtv.corp.google.com> <9b700254-23b1-286c-70e6-68d484e9c4e8@drmicha.warpmail.net>
 <xmqqziqm5k7j.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 23:42:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDIZh-0006tj-Fw
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 23:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbcFOVmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 17:42:10 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:35760 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbcFOVmI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 17:42:08 -0400
Received: by mail-yw0-f170.google.com with SMTP id z186so26219865ywd.2
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 14:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BHOKFNrAQRBqWfyCucsB5mAGvDZfHc79J//441wveqs=;
        b=muGgPJvausWQlGDOggsROPjetHWtA+v0N4KLIYMsBPEZg9oSmvwaByUE66azG1pCsn
         cgYIHEMMMCvpPVPVV0KBoh8/J00e5AAjORBjHe853iC0h0OgUSbOE407wcX+bJB8NGqZ
         dls6G0ihjyWl938YmoS2hYtQsTLc+hLnJlri1xNnq+s8g7ol50FuJzpEbdItf4g+31zf
         pENJI96oNpUhfsH6LcRkikQIt823EWy8UWKHwp8wFaTPCzMizwFHZh6OacVecPAjKD1t
         Me3z3VfnDXZxZW+qKJv2ABGexi9T7PFZa5muJTKqm65q3udV5bNv1A0EbUMwMj/riLZR
         1lFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BHOKFNrAQRBqWfyCucsB5mAGvDZfHc79J//441wveqs=;
        b=ca5gd3KhJU7knsAVWNjAH5iwwQqh0NFb08VoZuN5GKVDa/lBL3+s3jwCuerBswRKGj
         iZeRgdAlXU8r1mX8fve9n6v6U0vIjJ557oeQaVWk7DHPQb+hAqqVNpxiXRlK4W5GE5cj
         iHQIuzTwQv9g+u17k45w4L4jKVBP0qPm9qcA+P34uNZU0qYaFKmuuRw5IoWauEj9Oo5S
         pXm9YQ5pZwkOzUxLNc6AgWJeUwY1dY4w6Qy2xdfq40E+jrtlf0pGUmPsqvety5PdNRwE
         /ABTCaJ6TnrOX4g92Y5Scij5g/Sj3Q446vH1t93p18OxdNzojyHfgq/S+g6uN5sVaMSM
         4Ymw==
X-Gm-Message-State: ALyK8tIxvu1qfgS8dHvrB41LZxaRzlxEmEvskM+PhPnDMicwc7MHysdddlU+VQzMfof04PzkvTkxmqtmawK/Bw==
X-Received: by 10.13.218.131 with SMTP id c125mr649778ywe.310.1466026927505;
 Wed, 15 Jun 2016 14:42:07 -0700 (PDT)
Received: by 10.37.34.133 with HTTP; Wed, 15 Jun 2016 14:41:48 -0700 (PDT)
In-Reply-To: <xmqqziqm5k7j.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297403>

On Wed, Jun 15, 2016 at 12:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>>> Or even
>>>
>>>      if ((flags & GPG_VERIFY_BLOB) && (type != OBJ_BLOB))
>>>                      "you told me to check blob but didn't give me one";
>>>      } else if (type != OBJ_TAG)
>>>              "you didn't give me a tag";
>>>
>>
>> I just tried to stay as close to the original as possible, but I don't
>> care either way. Your latter version is more strict and would require a
>> slight documentation change, but would be fine, too.
>
> Actually, the message you reused is not reusable for this new mode.
> I guess starting from more strict (which makes sense, as you do not
> want to silently say "Yeah, the blob verifies OK" when the user
> tells you "I want you to verify this blob, and here it is" and hands
> you a tag.  If that were an acceptable behaviour, you do not even
> need VERIFY_BLOB as an option, do you?
>
> So I do not care too strongly about this feature, if it were to be
> added, I think you would need to separate error messages and type
> verification should not be lax, I would think.
>

I agree that Junio's suggestion is (a) both easier to read and (b)
more clear to the end user, and thus preferable.

Thanks,
Jake
