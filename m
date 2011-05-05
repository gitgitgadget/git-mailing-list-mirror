From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: [PATCH] builtin/checkout.c: show usage with options on missing
 argument 'branch'
Date: Thu, 5 May 2011 21:02:47 +0200
Message-ID: <BANLkTikMu3fjbALTAwaaknskBw0H7LbZ-g@mail.gmail.com>
References: <1304614690-12493-1-git-send-email-ralf.thielow@googlemail.com>
	<7vsjst6l5o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 21:02:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI3p8-0005Cr-Dq
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 21:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248Ab1EETCt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 15:02:49 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:43984 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab1EETCs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 15:02:48 -0400
Received: by yia27 with SMTP id 27so878838yia.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 12:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=j1WI1eHYdXKBL+sOIQ6Xodmqn3dUliWtYUGRh4Zs7c8=;
        b=r8THRL505dTwwmChOSIe+5cL9Oa4jnyQG/4rEbmAqbRMQhR5f1FiwlpscFVQz1EzvV
         ePUQpPCRisjepoPDhtI5vcW5yA67M9PLlTUfVaH/mZwpoxsn6J0qjbIz8CKiQfy9HFJ1
         UQJ8HA1d1BAoayt1NYgAZ7i6ht469N87HLr8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Y01xH/Xsu+EwoRqdsIWzsDe5jq4UYP3hRtyeAp5/KP1TWYXrqNvsmmOHBeJ7RbmMry
         qd0iqcqOhmiCTbXOnmQrJg3qiEGLosGOP52ysgF2cqH+rnITmZupvWOrWBi1h/XfD+ji
         EOSRBLlRiXSObB9If00BPbX6H/JWSEr9Igkwo=
Received: by 10.236.109.18 with SMTP id r18mr3341068yhg.189.1304622167457;
 Thu, 05 May 2011 12:02:47 -0700 (PDT)
Received: by 10.147.39.7 with HTTP; Thu, 5 May 2011 12:02:47 -0700 (PDT)
In-Reply-To: <7vsjst6l5o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172881>

Simple "git checkout" or "git checkout " don't tell me that i've done a=
 mistake
on usage. It does nothing. This can be different when using parameters,=
 but in
the end i think it should tell me the usage in this case.

2011/5/5 Junio C Hamano <gitster@pobox.com>:
> Ralf Thielow <ralf.thielow@googlemail.com> writes:
>
>> Show the usage with options for 'checkout' command on missing argume=
nt 'branch'.
>
> Please describe what exact command line you typed, what output and si=
de
> effect you got from the command, what you _think_ should have happene=
d
> instead, and what the differences between two are.
>
> In other words, what problem you are trying to solve?
>
>> Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
>> ---
>> =C2=A0builtin/checkout.c | =C2=A0 =C2=A05 +++++
>> =C2=A01 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> index 38632fc..4aa613a 100644
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -1086,5 +1086,10 @@ int cmd_checkout(int argc, const char **argv,=
 const char *prefix)
>> =C2=A0 =C2=A0 =C2=A0 if (opts.writeout_stage)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die(_("--ours/--the=
irs is incompatible with switching branches."));
>>
>> + =C2=A0 =C2=A0 if (new.name =3D=3D NULL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usage_with_options(check=
out_usage, options);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 return switch_branches(&opts, &new);
>> =C2=A0}
>
> What value are you returning from a function whose return type is int=
?
>
> If you read the function switch_branches(), you would notice that it =
is
> prepared to handle the case where new.name is NULL (by the way, check
> against NULL is typically spelled as "if (!new.name)" as you can see
> there), and then would realize that your change by itself cannot be a
> correct fix for whatever problem you are trying to solve.
>
> Have you run "make test" at all?
>
> If you are changing this command:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git checkout -b frotz
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Switched to a new branch 'junk'
>
> to error out with a message, then that is a regression.
>
