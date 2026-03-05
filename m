Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DB7248176
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714274; cv=none; b=bwV1EEEUtElf/PnWF1sTq29IJchQqcuoNXBDJpVs+AwkWSLCRaqHmx7Y2ac31urhIKv2ucdUfL2Gpy8r1TN/D8fmlFKSxJCZhAb9G6VBvrO6pKFHBjerYFyw6QgNM3AA5b3AYk4mkNlDRpGV4CPGTpHDmfLh47FwY3cjr77dG2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714274; c=relaxed/simple;
	bh=bygN1+MATaVnc1QMKgjUVb+74wCx6X/swzCxpVX2Ga0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzE+T8uAXOyGqkIcmE2fwgmtuUop7besU5yWt4bbmm4ULMsA+mMzcTYT3UCUpF6QzYGjeWcXb+6/dHBOoJmC5UO4tqF8LybqQ2K+XXUQfvGUh2hZP2PTQSAJnrXpvxzSxaJqDh5PAES4C8S+Bjw/1yW0Xw60MC5RPaWhCeHet/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=GmfznWLk; arc=none smtp.client-ip=185.70.43.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="GmfznWLk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1772714269; x=1772973469;
	bh=Zt7oLU9AbAdFIgUvWHmp3rgBFDR7YCoBr7j4ZJOIbRY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GmfznWLkLpItyIRHwQNNOpMluMKKFWBgZvVlwPX0xCLetxWiPkaLtW6BTOvodU9mY
	 Up8IN2Ceyp7FwqJ7WjjYWAslWQi2ZuKnyEhErlPjcTZaUIyyq5leO7e9bExPRhSSLP
	 hYMb5Tu8bp2AaLllM9T0PdZamFbHz1Fnp9ygxOYU0cLE69y3kGaFqQuAEpPf/LiYjV
	 77lMyJZhUvPhiq/QBgGrBRB2qGhy1p4ZeikWAuQeId/FvwafR8zrom1RfaMAuwXUDq
	 sNtzOqGnWcMBJ8I1VGExbWscBM504CvmORCWgsWdrCjv36548xYAVQQ0So4eFikVnb
	 oryzCEshnMhrw==
Date: Thu, 05 Mar 2026 12:37:45 +0000
To: Adrian Ratiu <adrian.ratiu@collabora.com>
From: Chandra <Chandrakr@pm.me>
Cc: git@vger.kernel.org, Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v4] add: support pre-add hook
Message-ID: <TqpXjikveTe2dR39_ZEgb0bz0KLLFtaHN_Exd-wwOUAR2RkfcuWBnPUY7wvsTDLaISn_a-cfzssvflKTr_5lSIisfLG6OvGmdEg9gNTIbng=@pm.me>
In-Reply-To: <87seaexz33.fsf@gentoo.mail-host-address-is-not-set>
References: <pull.2045.v3.git.1772171692465.gitgitgadget@gmail.com> <pull.2045.v4.git.1772710566599.gitgitgadget@gmail.com> <87seaexz33.fsf@gentoo.mail-host-address-is-not-set>
Feedback-ID: 10057713:user:proton
X-Pm-Message-ID: a15917cc7f55bcc5b68b86c4ad0ce26f73aaa493
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,=20

Thanks for the review, Adrian. v5 addresses both points you brought up. Als=
o, I fixed a failing test on windows CI with proper path formatting.

Chandra Kethi-Reddy
@archonphronesis:matrix.org

Sent with Proton Mail secure email.

On Thursday, March 5th, 2026 at 5:44 PM, Adrian Ratiu <adrian.ratiu@collabo=
ra.com> wrote:

> Hi Chandra,
>=20
> On Thu, 05 Mar 2026, "Chandra Kethi-Reddy via GitGitGadget" <gitgitgadget=
@gmail.com> wrote:
> > @@ -576,6 +582,11 @@ int cmd_add(int argc,
> >  =09=09string_list_clear(&only_match_skip_worktree, 0);
> >  =09}
> >
> > +=09if (!show_only && !no_verify && find_hook(repo, "pre-add")) {
> > +=09=09run_pre_add =3D 1;
> > +=09=09orig_index_path =3D absolute_pathdup(repo_get_index_file(repo));
> > +=09}
> > +
>=20
> Please use hook_exists() instead of find_hook() because that works with
> hooks defined via config files. Otherwise your hooks API usage is great.
>=20
> Maybe add a test or two which define the pre-add hook via configs to
> verify it works?
>=20
> (regarding find_hook(), we sholud mark it as deprecated or convert all
> its remaining uses and remove it, however that's outside the scope of
> your series, no worries)
>=20
> 
