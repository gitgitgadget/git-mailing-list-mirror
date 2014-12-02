From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 00/19] Add git-list-files
Date: Tue, 02 Dec 2014 13:40:05 +0100
Message-ID: <547DB325.6030500@drmicha.warpmail.net>
References: <1417337767-4505-1-git-send-email-pclouds@gmail.com> <20141202054226.GA1948@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?B?eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 13:40:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvmkZ-0008AR-KQ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 13:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933081AbaLBMkI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Dec 2014 07:40:08 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56680 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932313AbaLBMkH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2014 07:40:07 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 9524B20D17
	for <git@vger.kernel.org>; Tue,  2 Dec 2014 07:40:06 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 02 Dec 2014 07:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=vv9LYgg+cNZXyBxB+cZ9Zj
	dh37Y=; b=WSRDqaxge430l/7y+/V7YGFX9l1r8E8cWgDg599dn1XbNNaM/9n9u8
	UPJmRF8seCY/+SjPjbqGvBVCJBtk2s8eFR3fmEpka44wbxp6SQSFXLtgkF6Nc/ht
	HacEmRCYcL3yaFHblLuwFCY6kbOzuZ1r0Xab8QlXfKwVRTGnsflfE=
X-Sasl-enc: GvtjbZt+RisUqJBooBP9q+XZX4zcPDE7YnzhUjfvryDk 1417524006
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 08616C00283;
	Tue,  2 Dec 2014 07:40:05 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141202054226.GA1948@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260565>

Jeff King schrieb am 02.12.2014 um 06:42:
> On Sun, Nov 30, 2014 at 03:55:48PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>=20
>> This is something else that's been sitting in my tree for a while no=
w.
>> It adds "git list-files", intended to be aliased as "ls" with your
>> favourite display options.
>=20
> When I read the subject, I thought "why isn't this called git-ls?". T=
hen
> when I read this paragraph, I thought "if the point is for everybody =
to
> make their own ls alias, why do we need list-files at all, instead of
> just adding options to ls-files"?
>=20
> I'll let you decide which (if any) you'd like to answer. :)
>=20
> My guesses:
>=20
>   1. If it were "git-ls", it would stomp on existing aliases people h=
ave
>      constructed.
>=20
>   2. If it is a wrapper around ls-files, then the options may be
>      constrained; ls-files already squats on useful options like "-d"
>      (which, if we are matching traditional ls, is more like our "-t"=
).
>=20
> I somewhat feel like (1) can be mitigated by the fact that your comma=
nd
> is what people were probably trying to approximate with their aliases=
,
> and that as porcelain it should be very configurable (so they should =
be
> able to accomplish the same things as their aliases). But I dunno. I =
do
> not have an "ls" alias, so I am biased. :)
>=20
> As a side note, I wonder if it would be sensible to whitelist some
> commands as porcelain, and allow aliases to override them (either
> entirely, or just to add-in some options).
>=20
> -Peff
>=20

I'd like to second all that ("+1", "like").

User friendly listing of files in the git repo is dearly needed, and
following names and default behaviour of mv/cp/ls is a way to follow th=
e
principle of least surprise.

While "ls" might be an alias for many, I'm sure "stage" was for quite a
few people, too. We should be able to take any new name for new command=
,
regardless of aliases people may be using.

Allowing to alias at least porcelain commands, at least to the extent o=
f
adding default options, is something we've talked about before and whic=
h
would have prevented us from the increasing bloat by the default
changing config knobs. "git -c ..." somehow took us down the other road=
=2E

I'm still dreaming of a git future where either "git foo --bar=3Dbaz" i=
s
equivalent to "git -c foo.bar=3Dbaz foo" (i.e. unify the naming), or we
are simply able to alias "foo" to "foo --bar=3Dbaz" if that is what we
like as default (i.e. get rid of many of the special config knobs).

Right now, we have two "sets of options" with often differing names.

Also, we could ship a few commonly used aliases (such as co=3Dcheckout,
ci=3Dcommit, st=3Dstatus) which could be overriden easily.

Michael
