From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [PATCH] Hint at "checkout -p" in the "reset --patch <type>" error message
Date: Tue, 23 Nov 2010 16:23:18 +0100
Message-ID: <87ipzo83o9.fsf@gmail.com>
References: <AANLkTimc=Dt9YSu=J=7C-f1hZ9UODU7VHu6oD8dmFX3N@mail.gmail.com>
	<AANLkTimP9zr=wQDYeBxtvYCE1mZ1aHXQ_nLOxGFfR9YD@mail.gmail.com>
	<AANLkTimQ644C-dEoJTj8bNd9y+YzpMez7D1KLZFNEe7c@mail.gmail.com>
	<AANLkTindHnjeXEGbKWiQkWgoUBwqZbdx71sQwNr_gFp0@mail.gmail.com>
	<AANLkTi=5w3YpYu0_WbmHud0BUkO2BqYNVezWDMkCaSj2@mail.gmail.com>
	<AANLkTimEOULR8_PAs5iPu7z+n4DQPSyDKYg8RghZxosz@mail.gmail.com>
	<87mxp086k5.fsf_-_@gmail.com>
	<20101123145921.GB3145@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeenu V <jeenuv@gmail.com>, knittl <knittl89@googlemail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 23 16:25:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKuk8-0002VY-Ok
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 16:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755339Ab0KWPZF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 10:25:05 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49952 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755328Ab0KWPZE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 10:25:04 -0500
Received: by fxm13 with SMTP id 13so3965577fxm.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 07:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=o6ICyAPA9DqQ7Jzto7MShM55hjk3wtnAHrr+F/QXV4I=;
        b=sM9FLAd3gCD5dwBUIuAGM8ikjvEU9lNvqfSm1ZQwoTIW856a39MLav3TsNpsGeh1nf
         acFiqwyLa+ufpwkQ2dr/EhwDkM5KcDiPBrWBkRsA2HtX8sb2A1d6pUzeaHzYq5pOOtfU
         yWPsfElOZ5iMSRAvsyP3BWiQDpuSG5cP/q5RM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=NBPYz+SVz7G4LVJ8hGuPgMV/g7AKN6vrGEr2zYuMHWmdeLV5u1PWEdukmHBNmJT8OI
         dvpiEVbQ9kY1YXOwaem/1tra/ouGiBYid73v9RFhA7E5xTVJQOz9wC2pB3G437pMaQUv
         O+QBF989TCYv/BKrJHeQU4D9JBb+u6KoZi15w=
Received: by 10.223.85.197 with SMTP id p5mr5655371fal.65.1290525902559;
        Tue, 23 Nov 2010 07:25:02 -0800 (PST)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id n6sm1455366faa.28.2010.11.23.07.25.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 07:25:01 -0800 (PST)
In-Reply-To: <20101123145921.GB3145@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 23 Nov 2010 09:59:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161971>

Jeff King <peff@peff.net> writes:

> On Tue, Nov 23, 2010 at 03:20:58PM +0100, =C5=A0t=C4=9Bp=C3=A1n N=C4=9B=
mec wrote:
>
>> diff --git a/builtin/reset.c b/builtin/reset.c
>> index 0037be4..fc530d2 100644
>> --- a/builtin/reset.c
>> +++ b/builtin/reset.c
>> @@ -309,7 +309,8 @@ int cmd_reset(int argc, const char **argv, const=
 char *prefix)
>> =20
>>  	if (patch_mode) {
>>  		if (reset_type !=3D NONE)
>> -			die("--patch is incompatible with --{hard,mixed,soft}");
>> +			die("--patch is incompatible with --{hard,mixed,soft}\n"
>> +			    "(use \"git checkout -p\" to selectively discard changes in =
working directory)");
>>  		return interactive_reset(rev, argv + i, prefix);
>>  	}
>
> Should this actually print something different for --hard versus --mi=
xed
> versus --soft?
>
> For --soft, "-p" simply makes no sense as you are not changing the in=
dex
> or the working directory.
>
> For --mixed, shouldn't we support "-p" already, as that is the defaul=
t
> mode?
>
> For --hard, suggesting "checkout -p" does make sense.
>
> Also, what about "--merge" and "--keep" modes?

All good questions, most of which occured to me, too. What I was going
to do based on the outcome of (the discussion of) this patch was at
least fix the currently out-of-date "--{hard,mixed,soft}", as the
error is signalled with the newer options (--keep and --merge) as well.
I'm not sure I could cope with anything much more complicated than that=
,
esp. if it involved adding some new reset functionality. :-)

What about this instead:

diff --git a/builtin/reset.c b/builtin/reset.c
index 0037be4..7779302 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -308,8 +308,11 @@ int cmd_reset(int argc, const char **argv, const c=
har *prefix)
 	hashcpy(sha1, commit->object.sha1);
=20
 	if (patch_mode) {
-		if (reset_type !=3D NONE)
-			die("--patch is incompatible with --{hard,mixed,soft}");
+		if (reset_type =3D=3D HARD)
+			die("--patch is incompatible with --hard\n"
+			    "(use \"git checkout -p\" to selectively discard changes in wor=
king directory)");
+		if (reset_type !=3D MIXED)
+			die("--patch is incompatible with --{hard,soft,keep,merge}");
 		return interactive_reset(rev, argv + i, prefix);
 	}
=20

Thanks,

  =C5=A0t=C4=9Bp=C3=A1n
