From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] t3700: note a .gitignore matching fault
Date: Wed, 4 May 2011 13:22:41 +0700
Message-ID: <BANLkTik1w65vms3GFfjnaJJx3y6v8FT5UQ@mail.gmail.com>
References: <1304340464-14829-1-git-send-email-pclouds@gmail.com>
 <1304340923-15927-1-git-send-email-pclouds@gmail.com> <4DBEC766.8020008@viscovery.net>
 <BANLkTik=GYXUOeo3hA5yyXfOuBydT40koA@mail.gmail.com> <7voc3jis61.fsf@alter.siamese.dyndns.org>
 <BANLkTi=ZL5aPnPMXai==gyjYRT_LHovisA@mail.gmail.com> <7vd3jzgww8.fsf@alter.siamese.dyndns.org>
 <BANLkTinSx=MAkF5mt8gReNd1qEaeFTEBpA@mail.gmail.com> <BANLkTi=TNjUaD4EP8sYXDqJ-tmBEzz4t4w@mail.gmail.com>
 <4DC0ECED.2020409@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 04 08:23:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHVUT-0002f7-W4
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 08:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584Ab1EDGXN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2011 02:23:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37473 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195Ab1EDGXM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2011 02:23:12 -0400
Received: by bwz15 with SMTP id 15so707994bwz.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 23:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=7NrhEph3l8qsPeWgzwNu5W63FfFwA+5SgIbY1QTupz0=;
        b=uv+idriVK5kSqvMWYCTs5A5rTMp3uh2ykMeQn8X9NFIon5Vag+UMwTKeUDrQKg1+j6
         mGbQfKVegZwjD2P19KAoqdnZbxEWQEaQ3pHCr9TTZgcAw2kw1yA8vTpK3LZY5rkxG8lu
         4wvvRkADf9tQVcXF2387ZFh/xjak0gFY0WYhs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ApwFsWGP51IhCOa3YAoZEaQ7t9SIVbPnNAJAex5+p/0v+NCrrR86TCAT2McQLHrdyS
         6nz+NXxDdtrnUfKCv/f3fAoapuuuqoqI2xpcV8M06XYM63HiZlNCTkc32gz09cqUcKey
         mtiuZCXCO1ZfIc40s8dPmVJ2Xkun2Re7+NNLQ=
Received: by 10.204.20.142 with SMTP id f14mr676227bkb.155.1304490191583; Tue,
 03 May 2011 23:23:11 -0700 (PDT)
Received: by 10.204.53.13 with HTTP; Tue, 3 May 2011 23:22:41 -0700 (PDT)
In-Reply-To: <4DC0ECED.2020409@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172719>

On Wed, May 4, 2011 at 1:06 PM, Johannes Sixt <j.sixt@viscovery.net> wr=
ote:
> Am 5/4/2011 3:05, schrieb Nguyen Thai Ngoc Duy:
>> Maybe something like this instead of a implemantation fix?
>
> Yes, but...
>
>> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.t=
xt
>> index 8416f34..81e9d43 100644
>> --- a/Documentation/gitignore.txt
>> +++ b/Documentation/gitignore.txt
>> @@ -71,6 +71,8 @@ PATTERN FORMAT
>> =C2=A0 =C2=A0 matching file excluded by a previous pattern will beco=
me
>> =C2=A0 =C2=A0 included again. =C2=A0If a negated pattern matches, th=
is will
>> =C2=A0 =C2=A0 override lower precedence patterns sources.
>> + =C2=A0 If a directory is excluded by earlier patterns, negated
>> + =C2=A0 patterns that touch files inside the directory will be igno=
red.
>>
>> =C2=A0 - If the pattern ends with a slash, it is removed for the
>> =C2=A0 =C2=A0 purpose of the following description, but it would onl=
y find
>>
>
> ... as I already said here:
>
> http://thread.gmane.org/gmane.comp.version-control.git/170907/focus=3D=
170916
>
> I think that this is not quite the right place to mention this
> restriction. See my proposal in the same post.

Thanks. I missed that post. NOTES is fine although I prefer BUGS (or
LIMITATIONS). We may decide not to look for more .gitignore inside,
but we should respect all patterns we have got. Can you please submit
your changes in a patch?
--=20
Duy
