From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Name make_*_path functions more accurately
Date: Fri, 18 Mar 2011 09:06:37 +0100
Message-ID: <4D83128D.6020206@drmicha.warpmail.net>
References: <1300361206-6982-1-git-send-email-cmn@elego.de> <7vipvgyjnl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>,
	git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 09:10:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0UlE-0004qk-OQ
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 09:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268Ab1CRIKL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 04:10:11 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53228 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750946Ab1CRIKI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 04:10:08 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 069F72097F;
	Fri, 18 Mar 2011 04:10:07 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 18 Mar 2011 04:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=lI8qi7qBDdPyAn2tHnnoj7kp9nI=; b=E7lqgAGVAP9yxo/z7c5jT4nT84VU2nZYq6GI0RFGzSD/dwvVqIAcbh/55tBaLlIbbu32lC1UjTaNoBFQXLVSBsZBmzGI9Yl7FFP4X6Uceq7joiuLkfOklExytiUMRKwsnemr1zjJJN7UL0oQE1dhmOUsuluVicRgEoFSCjvjZf4=
X-Sasl-enc: K6FXMYuGgeeybrtjMMQJFIQPtbuGgphR2VvMKwhJ+oFb 1300435806
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D0198401C5A;
	Fri, 18 Mar 2011 04:10:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7vipvgyjnl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169300>

Junio C Hamano venit, vidit, dixit 18.03.2011 08:25:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
>> Rename the make_*_path functions so it's clearer what they do, in
>> particlar make clear what the differnce between make_absolute_path a=
nd
>> make_nonrelative_path is by renaming them real_path and absolute_pat=
h
>> respectively. make_relative_path has an understandable name and is
>> renamed to relative_path to maintain the name convention.
>=20
> The approach taken by this patch is a sound one, and I like it.  The
> change does not reuse any existing name for different purpose, which =
means
> there is little chance of this change interacting other topics that m=
ay be
> in flight that introduce new call sites to these renamed functions in=
 a
> funny way.  A (semantic) mismerge or misapplication of the patch will=
 be
> found by the compiler.
>=20
> For example, the version of setup.c this patch is based on the versio=
n
> before 05f08e4 (Merge branch 'cb/setup', 2011-02-09) was merged, and =
the
> merge introduced a new call site to make_absolute_path().  A few call=
sites
> to make_nonrelative_path() in wrapper.c were introduced at 70ec868 (M=
erge
> branch 'ae/better-template-failure-report', 2011-02-09), and this pat=
ch
> does not touch them.
>=20
> As the result, the patch cleanly applies textually, but the resulting=
 code
> does not compile, and it is a good thing ;-).

=2E..because the "diff --color-words" for this version of the patch mak=
es
it clear you only have to rerun

sed -e 's/make_absolute_path/real_path/g'

etc. on the affected files to resolve this "merge-compile conflict".

Just pointing it out for those who wonder why I pestered Carlos to brin=
g
the patch into this form, and why Junio started to like failed builds.
Also, I need to make-up for making Junio explain my recent RFD :)

Cheers,
Michael
