From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 1/7] Documentation/git-push.txt: Document when --signed
 may fail
Date: Mon, 17 Aug 2015 14:11:44 -0400
Message-ID: <CAD0k6qS4A0zWWr1oNLaaps0qD08pkGTcj7yGo_tkPGKMxKWGhQ@mail.gmail.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
 <1439492451-11233-2-git-send-email-dborowitz@google.com> <xmqqr3n5fovm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 20:12:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZROtI-0002JZ-0B
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 20:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbbHQSMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 14:12:06 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34490 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbbHQSMF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 14:12:05 -0400
Received: by igui7 with SMTP id i7so63711747igu.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 11:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DQmqQbN7CF6L4ROKpdJ7LxaB2E4LoD0240zA6wT6vJc=;
        b=G4s3TLZ2P1tkcDTZzfdaqQZ1W/9K7dCdd4967ZC2e1uqxnkUxVcuVOkPmDdWQXTJKG
         8srOMg3ZSd1doyPuFedaLjqklwQLKFHG3bzlnLxhDSNEDStA0QsTQ7AGd+By4wHAA2Oe
         HSUHmAvrbAGpiwcaA834OWMAlU6Wz+vVP2nb/lQFuEaHdTCu48Rq7XeMLeGLItcCtTNo
         Q6br4rGc45c7BnjI18uUtJBcvkWW4elLJ/tCBHSG9n95wxpll2UpIC7/N2037G0fkASw
         nmNsAObctH07fRtBzHqgP0oCUdzYmdcnW3nArfZWu0q8OIlRvzYDMfFOSyViT3kRBXLT
         oPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=DQmqQbN7CF6L4ROKpdJ7LxaB2E4LoD0240zA6wT6vJc=;
        b=lTWQc3aaMCkJNKL15b318aUhbQ/SR58b5yi2P1Nm9IF7TvnG4MT/YdmT1Bnv1CwCLj
         Nw7lowiFxanJ4+6jUWLjhjSlZ+mQhVjaofNUnHonxqUhIlmMqrfndEDDQCCaM2D+adeC
         WA3lOmJZj+KjHttlonY98FbXLUQnMqsSqbEeTSYf4024FOZNEcHCUgF2PCJ9TcZOfy3I
         pymHPM39An+FA7revWrox7rY9GmKpXVbK+UngCnfxoX0xC3qXxwgJ6T1biRFlsQC6SEB
         t2WrxVoLxdlDfPHgxTS1WeYcMGYc130m5m6TfN73IqVjYryNTfPH3H/iNxZx2CyVti6o
         y1gQ==
X-Gm-Message-State: ALoCoQlAHklhNDsw6MZtQFp1YAdDkBy8MuLICY2zaHxPNmNeKuR2RZ/Zm4QF2V9rA1f7gXts/+S3
X-Received: by 10.50.20.8 with SMTP id j8mr16728818ige.36.1439835124000; Mon,
 17 Aug 2015 11:12:04 -0700 (PDT)
Received: by 10.107.4.201 with HTTP; Mon, 17 Aug 2015 11:11:44 -0700 (PDT)
In-Reply-To: <xmqqr3n5fovm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276064>

On Fri, Aug 14, 2015 at 7:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dave Borowitz <dborowitz@google.com> writes:
>
>> Like --atomic, --signed will fail if the server does not advertise the
>> necessary capability. In addition, it requires gpg on the client side.
>>
>> Signed-off-by: Dave Borowitz <dborowitz@google.com>
>> ---
>>  Documentation/git-push.txt | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
>> index 135d810..f8b8b8b 100644
>> --- a/Documentation/git-push.txt
>> +++ b/Documentation/git-push.txt
>> @@ -137,7 +137,9 @@ already exists on the remote side.
>>       GPG-sign the push request to update refs on the receiving
>>       side, to allow it to be checked by the hooks and/or be
>>       logged.  See linkgit:git-receive-pack[1] for the details
>> -     on the receiving end.
>> +     on the receiving end.  If the `gpg` executable is not available,
>> +     or if the server does not support signed pushes, the push will
>> +     fail.
>
> Looks good.
>
> I am wondering if another mode of failure is worth mentioning: `gpg`
> available, you have _some_ keys, but signingkey configured does not
> match any of the keys.
>
> Note that I said "am wondering", which is very different from "I
> think we should also describe".

I think we don't need to go down the path of enumerating all possible
ways the operation can fail. There is probably a reasonably concise
way to include more possibilities. How about:

"If the attempt to sign with `gpg` fails, or if the server does not
support signed pushes, the push will fail."

This should cover gpg not being found, gpg being fatally
misconfigured, crazy unexpected pipe closures, etc.

> Thanks.
