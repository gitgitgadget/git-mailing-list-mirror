Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F36AC32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 09:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348158AbiHSJ0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347758AbiHSJ0f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 05:26:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80F6F43AC
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 02:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660901189;
        bh=18XY0BtsolcWPbBgriXbZTM37t79RZxe7lhra4knhS4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=C81SjM9MnEnqYg46qo8dCPo/PTPPVFOMUBTQCvcfWiDuuMEN2sO3EF6nd5Sni0LcW
         UugcFqRD4caxTjtYv2COd7My/InTYvdizUSXYBNErAuVqq4PIpSk9RtUQQ9ljNbWp9
         1SM4VWuvS101tTCNoIZiUotYM9REAqAg+orIVfaI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.212.11]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sHy-1oK0CF0Bak-004z3a; Fri, 19
 Aug 2022 11:26:29 +0200
Date:   Fri, 19 Aug 2022 11:26:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 2/4] sequencer: do not translate parameters to
 error_resolve_conflict()
In-Reply-To: <220818.86v8qp8uid.gmgdl@evledraar.gmail.com>
Message-ID: <06s6r3s7-27nn-1o9s-1n7p-5413284r8740@tzk.qr>
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr> <cover.1660828108.git.git@grubix.eu> <4684d54aeb3e00c96ba581c824a04e47b7236db7.1660828108.git.git@grubix.eu> <220818.86v8qp8uid.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-373191695-1660901197=:241"
X-Provags-ID: V03:K1:8ynxar4uZGvCUg+lFTYQyTrnL0b9kNDjgH1LLuhvguuCiML+1zf
 khuDnLfy+z9+ahG3KYHDToiIu9Xii4aKfd6WRf18Ai1md/ACCnTIr58UV7vXLMgaz5gMX9z
 SpJLNcQhcdJY7+PfvyKshb5/S68r2Cq0Y7YjR+VfOK98eeUW8uDultnubpJSMSS/cn3eWjo
 ClLYiVw2bSnVe4I7YGKVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sOlvOi+mdr4=:c1Ea2ZYE8iFiWfuoG7oY81
 FxJzQpXOOuf07PhKlOCnMJruf6nFdKP9lOwfWUiR6BVRrXrT8ArmAOoVcxOHvzOsmZw+1jFOG
 aOwAaMACpRZzoqC47mjg3jJJEkTNk+twwIHcLe8gaahiUNUikNhJoK/euRc4tHuVCSd9Of3O1
 leQtjBGPKmsX1afNBHDM+gzx23H4/gXP+iJh6eHi4XwNbZCR7uUTrIv2Hw8FUOPGcODi+nc5X
 xfxab0c554REfr10SSn0TvES8sVCfht3cbuwklN2USy3qD9Ii973xNUsMu8lzPb5iCWLNI0zf
 d9iHX+g7yBxNAnoN9BVQttDx2mzYxTJdEHjOwtP4vJckhDbWgdjMsfW3ub8t4rk8vYOPQIJj6
 bDvv/kIT1TLoiRETs6+Q1v5YbaEGCl2Kn+1hy2xvWu5y4OjftBN4NhaGjHXOaY+ZiOjoETJUC
 CmQFK26K9VZ5vIYQvyNKMM+Zf5sF6E+LFilBYfE0PLTYMO/k390zc9e0Od3fEi8G+TTlMFY9A
 HBhK9KtuOkHP/ZLSkASLM7BBrU9jeiKYBW1E0UZEoTc0PM8kJ6guxGhVZtuNDWBPdjCqAi02K
 1AWgcD+pxoPS4eVBmXDqSfCMYlNJxC5vl31KFYIZyCl0OCvddtGYIP6Rkn5yE4mfjPUqQvnLB
 beAZyg5XMAfHR85TBb1MZ3VRd8GgZEzbwHiuLBFn8K03QPCaOdYtkcjeUDibeAbYc5qRhhl4+
 8QE4jZKlxvBBnMno/Ui4N2HB1bW1/P4opixvqs9nbA+YeqGSHcfK7zcMtUuT84bqxPk/iGju5
 DltPyKD3WmRXF8tPb9jN2AXWN5nDPV7wTj5wHsZFM+j2lqt49GdU1VNVXy4L/GasjmuGcumXC
 FFcjUigV2jzfDq9AeejGtuzVbtafKWwO94dwLmLOMgsTSUlrLyb5haGwCVYQLiJ+wvlkj5rpR
 wiqt4pknlEbmHf29zBlntoInmu9h9xgTLdqmzF5IN0VQ4GKOQgTPHeAzDxjef3PLTkTcXPvhW
 4VdZY5xB5YHHQSPiSUq2O0Sa9M5NtUAbAGUJnbNoSh15N3fLTl3fDnQvOcFoAIY73ZNKw/tu+
 Z00J14PqsmqTptMDMRbdfI9nLnKP0QSwZfZiQnK8guiMo0SFDN45kMd4A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-373191695-1660901197=:241
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 18 Aug 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Aug 18 2022, Michael J Gruber wrote:
>
> > `error_resolve_conflict()` checks the untranslated action_name
> > parameter, so pass it as is.
> >
> > Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Signed-off-by: Michael J Gruber <git@grubix.eu>
> > ---
> >  sequencer.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index 51d75dfbe1..8b32b239b9 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -537,7 +537,7 @@ static struct tree *empty_tree(struct repository *=
r)
> >  static int error_dirty_index(struct repository *repo, struct replay_o=
pts *opts)
> >  {
> >  	if (repo_read_index_unmerged(repo))
> > -		return error_resolve_conflict(_(action_name(opts)));
> > +		return error_resolve_conflict(action_name(opts));
> >
> >  	error(_("your local changes would be overwritten by %s."),
> >  		_(action_name(opts)));
> > @@ -3753,7 +3753,7 @@ static int do_reset(struct repository *r,
> >  	init_checkout_metadata(&unpack_tree_opts.meta, name, &oid, NULL);
> >
> >  	if (repo_read_index_unmerged(r)) {
> > -		ret =3D error_resolve_conflict(_(action_name(opts)));
> > +		ret =3D error_resolve_conflict(action_name(opts));
> >  		goto cleanup;
> >  	}
>
> Perhaps we should have the error_resolve_conflict() function take a
> "enum replay_action" instead?

We could do that. We could also just delete the sequencer code. It's just
that both are a bad idea.

Ciao,
Johannes

--8323328-373191695-1660901197=:241--
