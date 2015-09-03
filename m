From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] graph.c: visual difference on subsequent series
Date: Thu, 3 Sep 2015 10:04:03 +0200
Message-ID: <55E7FEF3.2020400@drmicha.warpmail.net>
References: <1415626412-573-1-git-send-email-anarcat@koumbit.org>
 <87twspe6ix.fsf@marcos.anarc.at>
 <xmqqegjticd7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Antoine_Beaupr=c3=a9?= <anarcat@koumbit.org>
X-From: git-owner@vger.kernel.org Thu Sep 03 10:04:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXPVI-0003ok-0e
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 10:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbbICIEK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2015 04:04:10 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37948 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751151AbbICIEG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Sep 2015 04:04:06 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 3154E20435
	for <git@vger.kernel.org>; Thu,  3 Sep 2015 04:04:05 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 03 Sep 2015 04:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=WIJkBhfZmdJKWDH87xZimmyUD4g=; b=YhuvX1
	o9dmQ60Wt8Nehyj4uw5Ao3ZdKjZlkLE5yQ/i4X+2zlGU/lWXC2I21X2yN1BzZ1cb
	NNtrofLsMe1QWMdMHKzAql9HTZkAocEDf1koqoKH7zzEsPuKKrt9FNLVKC+wgS08
	Dr1R7rgqSlvskuuUFgHTa8usl72aatnPIL/WI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=WIJkBhfZmdJKWDH
	87xZimmyUD4g=; b=aGIF/+2NT0mA2535WaPgrkA5r8fU5gDGS65uFvnjsTzk3vy
	PB2aeFAMunZJe5/CKXhoRTRf3i6sxYPie+zPLpFpGOAf9lZs8R+MDfZ0oZrmbgGo
	EZNrDo5pvremyklJ9D6jMr4I8/LCq2jFhk7LY0JkbwIIZ+gzHavhwerTVuyM=
X-Sasl-enc: 80pYr9/1EPuemfd2YiRgvvKx/pUogmkGkIXejU8jwZyD 1441267444
Received: from localhost.localdomain (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 76A316800E2;
	Thu,  3 Sep 2015 04:04:04 -0400 (EDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <xmqqegjticd7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277183>

Junio C Hamano venit, vidit, dixit 27.07.2015 22:17:
> Antoine Beaupr=C3=A9 <anarcat@koumbit.org> writes:
>=20
>> Any reason why this patch wasn't included / reviewed?
>> ...
>>> This patch is similar than the one provided by Milton Soares Filho =
in
>>> 1382734287.31768.1.git.send.email.milton.soares.filho@gmail.com but=
 was
>>> implemented independently and uses the 'o' character instead of 'x'=
=2E
>=20
> The reason why Milton's patch was not taken after discussion [*1*]
> was not because its implementation was poor, but its design was not
> good.  By overriding '*' '<' or '>' with x, it made it impossible to
> distinguish a root on the left side branch and a root on the right
> side branch.
>=20
> Is the design of your independent implementation the same except
> that 'o' is used instead of 'x'?  Independent implementation does
> not make the same design magically better, if that is the case ;-)

Interestingly, the patch to the tests lists * to o changes only, no < o=
r
> to o.

The reason is simply that the patch doesn't change anything for left no=
r
right commits. I would say that is the best compromise since it does no=
t
change the overall layout, provides more information by default and doe=
s
not override information that is requested specifically.

If we want to put more information into log --graph simultaneously we
should really go beyond ASCII and look at how tig does it, e.g. using
unicode characters.

> If the design is different, please explain how your patch solves the
> issue with Milton's design in your log message.
>=20
> For example, you could use the column arrangement to solve it, e.g.
>=20
> History sequence A: a1 -- a2 -- a3 (root-commit)
> History sequence B: b1 -- b2 -- b3 (root-commit)
>=20
>     $ git log --graph --oneline A B
>     * a1
>     * a2
>     * a3
>       * b1
>       * b2
>       * b3
>=20
>     $ git log --graph --oneline --left-right A...B
>     < a1
>     < a2
>     < a3
>       > b1
>       > b2
>       > b3
>=20
> I am not saying that the above would be the only way to do so; there
> may be other ways to solve the issue.
>=20
> [Reference]
>=20
> *1* http://thread.gmane.org/gmane.comp.version-control.git/236708/foc=
us=3D236843
>=20
