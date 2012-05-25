From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] completion: split __git_ps1 into a separate script
Date: Fri, 25 May 2012 12:01:25 +0200
Message-ID: <CAMP44s185ZyFQRNkbKq840zEMopup4EPSUSKFzF5ZaZbP0Te7w@mail.gmail.com>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
	<1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
	<4FBC0019.6030702@in.waw.pl>
	<7v4nr72bim.fsf@alter.siamese.dyndns.org>
	<CAMP44s0aKi+8WHPXYLQ+iSMkj9iV88JGTabrpBRNBWb7upAMiQ@mail.gmail.com>
	<CAOnadRF8XyZKi+d=y1fFy2Xvs-3ETVyCbJBj83mK3Q8yuK7oQw@mail.gmail.com>
	<CAMP44s3uW75O_jt2F7POxTAhX+qPyRSjOX9-DuEkg7a7WtnLsA@mail.gmail.com>
	<4FBD5CC1.3060701@tedpavlic.com>
	<20120524203549.GA2052@goldbirke>
	<CAOnadRFbrhrFz7Ya3Vhgsju9G723Qu0OdJnM31xFmBqQNgj6gA@mail.gmail.com>
	<20120525073506.GD2052@goldbirke>
	<87ehq8its8.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Ted Pavlic <ted@tedpavlic.com>,
	=?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Kerrick Staley <mail@kerrickstaley.com>,
	Dan McGee <dan@archlinux.org>,
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, Marius Storm-Olsen <mstormo@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 25 12:01:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXrKw-0001iN-8w
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 12:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544Ab2EYKB2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 May 2012 06:01:28 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39619 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750996Ab2EYKB1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 06:01:27 -0400
Received: by lahd3 with SMTP id d3so517068lah.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 03:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=hxgsyQt5che9a4oeWRAsvqmjBmkDl621a30rpIGUfKo=;
        b=GuBHGhzkodSwJsD9hWBNmB7JdoYmLca4lcwB0H5aixA4ncM3gMuT2xlUVsTgtuG1TO
         tGsLZsQ7Coy+/VE0XGzf4EMBoicR7up6hVhTrTS2xVmkPlGKXDQyI6zXajTAq2g5MHGF
         As0Uk0TZkl7nUNl+F/pozY2xsbyIQ8GB6XwX57SKRb7h+zHpv8D4Xdr2bclTmu204C9h
         4nKngkzVV/IcByU6HSl1dSauXhfwAUBnSXImyTeLDn8SyySXuC6caZZb3o9S3W/0vQdf
         KM7Kk2vjKSIFhDi5l3XZl746IM91TAul11LjwnIjZ7zy592sIiLb6mNIIpLpZgkoMp/z
         OFXw==
Received: by 10.152.112.138 with SMTP id iq10mr2940800lab.13.1337940085923;
 Fri, 25 May 2012 03:01:25 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Fri, 25 May 2012 03:01:25 -0700 (PDT)
In-Reply-To: <87ehq8its8.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198472>

On Fri, May 25, 2012 at 9:50 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>
>> On Thu, May 24, 2012 at 11:36:45PM -0400, Ted Pavlic wrote:
>>> > You mean a real git command, which does the same as __gitdir()? =C2=
=A0I
>>> > don't like that, because it will always require 2 fork()s and an
>>> > exec() and would be slow on Windows.
>>>
>>> Interesting. I guess I didn't realize bash completion was an issue =
for most
>>> Windows users. Is it?
>>
>> It is. =C2=A0Emulating fork() and exec() is very expensive, so every
>> subshell, external command, or especially git command in a command
>> substitution costs dearly. =C2=A0And the completion script uses many=
 git
>> commands and even more subshells.
>>
>> Case in point is __git_ps1() and __gitdir(). =C2=A0There are scenari=
os
>> where displaying the git-specific bash prompt takes more than 400ms =
on
>> Windows, while displaying the same prompt takes only about 26ms on
>> Linux on the same hardware.
>>
>> =C2=A0 http://thread.gmane.org/gmane.comp.version-control.git/197432
>
> Why not make a git builtin command that figures out everything that
> __git_ps1 does? =C2=A0Perhaps in a format that can be eval'd and proc=
essed to
> the user's taste.

That is what I was thinking.

--=20
=46elipe Contreras
