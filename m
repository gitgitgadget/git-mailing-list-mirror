From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] git.spec: fix changelog dates
Date: Tue, 5 Apr 2016 15:41:24 +0200
Message-ID: <5703C084.1040405@drmicha.warpmail.net>
References: <6ef7d9d87f0c14147267c44e8b382f988936875b.1459858117.git.git@drmicha.warpmail.net>
 <833355852.2977267.1459859316816.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 05 15:41:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anREl-0001Ye-Iz
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 15:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758943AbcDENl2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2016 09:41:28 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42893 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752818AbcDENl0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2016 09:41:26 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id A67002081F
	for <git@vger.kernel.org>; Tue,  5 Apr 2016 09:41:25 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 05 Apr 2016 09:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=P4zHP2jjr2HQVpATy3cdhQv3Dus=; b=MhLEc/
	MNkQpygKkA8qF/HmvnXwVZJTQBoRi9DofitaXQv2POFdCavirSH6bGY+xhUuPowM
	6R0fgslBVpR/rD8fF0v7jP0ufAlAhYufThS2cWFZcpx++1uKzrbzXCl81+yuCqZ3
	KFu1fNL3FeNtAm8D/xPQgDpBo1JMpGFbTHWGA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=P4zHP2jjr2HQVpA
	Ty3cdhQv3Dus=; b=jj43zSiyrkcz7j9GObQHX9ug34CDY99QjsxLLXJdGMc1DrX
	LargwDQbYdd+b5eevX+k0xDN+46lfQUvdGymJpzbMZEoVbZPwgZ6Zgm8qysieI1R
	IrAwv7nhnNtJSBizP823L2c1aJKOGBbra1AQE7Apf33HV+G2UCS2LGRrNvo0=
X-Sasl-enc: bZ1We/aIwu1Sn0XYDrNbJn06oMix3c/mvvEsSn7D4veO 1459863685
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1536D6800C9;
	Tue,  5 Apr 2016 09:41:24 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
In-Reply-To: <833355852.2977267.1459859316816.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290780>

Remi Galan Alfonso venit, vidit, dixit 05.04.2016 14:28:
> Michael J Gruber <git@drmicha.warpmail.net> wrote:
>> A few changelog entries have inconsistent dates, which rpmlint repor=
ts
>> as errors.
>>
>> Fix them based on these assumptions:
>> - It's easier to mistype a number than a weekday abbreviation.
>> - changelog date must be before git commit date
>> - The mistyped date is just a few days off.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> I dunno if this is worthwhile, but rpmlint is the first thing we tel=
l
>> packagers and reviewers to check.
>>
>>  git.spec.in | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/git.spec.in b/git.spec.in
>> index bfd1cfb..eb581a3 100644
>> --- a/git.spec.in
>> +++ b/git.spec.in
>> @@ -229,7 +229,7 @@ rm -rf $RPM_BUILD_ROOT
>>  * Sat Jan 30 2010 Junio C Hamano <gitster@pobox.com>
>>  - We don't ship Python bits until a real foreign scm interface come=
s.
>> =20
>> -* Mon Feb 04 2009 David J. Mellor <dmellor@whistlingcat.com>
>> +* Mon Feb 02 2009 David J. Mellor <dmellor@whistlingcat.com>
>>  - fixed broken git help -w after renaming the git-core package to g=
it.
>> =20
>>  * Fri Sep 12 2008 Quy Tonthat <qtonthat@gmail.com>
>> @@ -262,7 +262,7 @@ rm -rf $RPM_BUILD_ROOT
>>  * Thu Jun 21 2007 Shawn O. Pearce <spearce@spearce.org>
>>  - Added documentation files for git-gui
>> =20
>> -* Tue May 13 2007 Quy Tonthat <qtonthat@gmail.com>
>> +* Sun May 13 2007 Quy Tonthat <qtonthat@gmail.com>
>=20
> It is inconsistent with what you said in the commit message ("It's
> easier to mistype a number than a weekday abbreviation.").
>=20
> Following that logic, it should be:
> 	* Tue May 15 2007 Quy Tonthat <qtonthat@gmail.com>
>=20
> (or 08, I didn't check the condition "changelog date must be before
> git commit date")

I did.

The thing is that you can't always fulfill all of these 3 conditions.
"Easier" doesn't mean that the other case is impossible, just less like=
ly.

> Thanks,
> R=C3=A9mi
>=20
