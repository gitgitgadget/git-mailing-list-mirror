Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BDB33F399
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770722058; cv=none; b=Thn4c/ukwaJyDwms5KzxStITLVbbBUtXQjtsaesD4nQnaUIHfgegXimZiixQm5OXFMl25QBWJh/YzCcXtqTN7Dj4GSlgZFVSb21AbWySKwOKeWiLHNls39DA/rIK3F9IolIDnqLuECcOU/6bY4huPTCuKo1+ySFQw1BnhIk2iPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770722058; c=relaxed/simple;
	bh=hgIew3DRG7NiDEpMxK4LQWwkVvdVNUIWB0D8UH4qJhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDerCWlXGzgrry+xuzBmmjXLMxzqjpQ6hieQUozkssDgXUKnNB80zNcmbzrR0RhZKnND/ugXoaAL1EK//JwISD1+jo8G/MpnfT0hNytFA8+auSXyubjZ6zOm0Tw3SzvrnXXkyTPllzo6of5KnrjFmTRs15DwhF5Nz67MYa4VPXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=keTD5ugH; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="keTD5ugH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770722042; x=1771326842; i=tboegi@web.de;
	bh=+tvAKIiL/sOUQgnuJRthDazo4uBpZTMRZR2iM+g2dzE=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=keTD5ugHIlz+aCSJIsC8GwlbTlWv0ZMLt82VazH/HJEDC/PGe+jvQpyzNr7EP6WU
	 LVh2OUZn8j7h77AHUPHWxdVhiswwJE7j41iqjXOSbtuonJ47WpSYgENVx4u+COxJe
	 h0WM4ZasonObHR9Yzq9j14CYhVwdhyUGCpRYA4D0Wg3FG7mOrJ4WZeoFeuD0RhiiF
	 CvK93l9abgqAT2i3IzZZPCxqb48SBsplETyKAtu6z+njM/EgeDS7AjNEBSPwviSwP
	 OKA72XiVC6i50vsPg7rNmA6l5rJ77x9WKiAPEka0Ny+iU2DCfC0UaZ2b0hxsWWXeT
	 6eU0kEX4Eqga77ODPw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.224.105.209]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1JB0-1vn1bH3tYA-00AiVc; Tue, 10
 Feb 2026 12:14:01 +0100
Date: Tue, 10 Feb 2026 12:14:01 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/4] t4xxx: don't use iconv(1) without ICONV prereq
Message-ID: <20260210111401.GA27953@tb-raspi4>
References: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
 <20260209-b4-pks-ci-msvc-iconv-fixes-v1-1-1e3167cd8828@pks.im>
 <xmqq4inp6bup.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4inp6bup.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:j4flSyJ8Kx/paKOtWbgED1owbgjambs9bhvUOVXWsXddG762wsd
 N5qiVXirD4sAF5ZgeVe+9edLl1fA6dgXakYwem+ijsxOBzSZn/CGqVSA7R1HZfMNvy6KtPq
 dvBgC99CxzSgL1MA/FRHuAtQtcTgS1knX6gfId4tyNbTVgibGHWXUiE5m8W7V4qFiy9hR0o
 +Xo29OyztNWuC+g9KPfAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9sackt3JevQ=;PvE4QoXfebgNf5mt/XMSaRKo0eZ
 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
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 09, 2026 at 09:55:10AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > We've got a couple of tests that all use the iconv(1) executable to
> > convert the encoding of a commit message. All of these tests are
> > prepared to handle a missing ICONV prereq, in which case they will
> > simply use UTF-8 encoding.
> >
> > But even if the ICONV prerequisite has failed we try to use the iconv(=
1)
> > executable. But it's not a safe to assume that the executable exists i=
n
> > that case. And besides that, it's also unnecessary to use iconv(1) in
> > the first place, as we would only use it to convert from UTF-8 to UTF-=
8,
> > which should be equivalent to a no-op.
> >
> > Fix the issue and skip the call to iconv(1) in case the prerequisite i=
s
> > not set. This makes tests work on systems that don't have iconv at all=
.
> >
> > Note that arguably, it's even unsafe to assume that the iconv(1)
> > executable exists only because Git has been built with support for it.
> > A more wholistic approach would thus be to split up the ICONV prereq
> > into two prereqs: one that tells us whether Git has been built with
> > ICONV support, and one that tells us whether the iconv(1) executable
> > exists. But that would lead to a bunch of changes throughout our tests=
,
> > and for arguably negligible benefit.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  t/t4041-diff-submodule-option.sh             | 8 ++++++--
> >  t/t4059-diff-submodule-not-initialized.sh    | 8 ++++++--
> >  t/t4060-diff-submodule-option-diff-format.sh | 8 ++++++--
> >  3 files changed, 18 insertions(+), 6 deletions(-)
>=20
> The repetition across three files look a bit disturbing X-<.
>=20
> > diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule=
-option.sh
> > index 4d4aa1650f..4dd4954260 100755
> > --- a/t/t4041-diff-submodule-option.sh
> > +++ b/t/t4041-diff-submodule-option.sh
> > @@ -37,8 +37,12 @@ add_file () {
> >  			test_tick &&
> >  			# "git commit -m" would break MinGW, as Windows refuse to pass
> >  			# $test_encoding encoded parameter to git.
> > -			echo "Add $name ($added $name)" | iconv -f utf-8 -t $test_encoding=
 |
> > -			git -c "i18n.commitEncoding=3D$test_encoding" commit -F -
> > +			message=3D"Add $name ($added $name)" &&
> > +			if test_have_prereq ICONV
> > +			then
> > +				message=3D$(echo "$message" | iconv -f utf-8 -t $test_encoding)
> > +			fi &&
> > +			echo "$message" | git -c "i18n.commitEncoding=3D$test_encoding" co=
mmit -F -
>=20
> This was a bit unexpected.  Do we give any guarantee to builds that
> lack iconv support that "git -c i18n.commitEncoding=3D... commit" will
> pass the payload verbatim?  I would have expected ICONV prerequisite
> is used on the whole test_expect_success to exclude the tests that
> are affected, not at such a low level.
>=20

To my understanding there are 2 different things:
- Does the platform have libiconv (which is linked into Git,
   and handles the commit encoding)
- Does the platform ship the iconv binary ?
  It seems as if mingw has stopped to ship the iconv binary.
  And as a result, Git for Windows is missing it, too.

(And if someone asks me: it probably makes sense to bring it back)

https://github.com/git-for-windows/git/issues/6083

