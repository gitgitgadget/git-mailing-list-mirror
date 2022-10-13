Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC182C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 21:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJMViY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 17:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJMViW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 17:38:22 -0400
Received: from sender4-of-o53.zoho.com (sender4-of-o53.zoho.com [136.143.188.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229BB4056A
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 14:38:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1665696192; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=V+evIHs7kUdj9J5MlSPM3LyOJGLLw7jOZ+Th3L8nvG4HypFMO2W/kcHfhwVqxajlTcZrGRsP8D16l+fmX9bd1xp0Lahg5VGtsTMTP/ue4nn3V4T67vsQr1LajzVNVDaiMI6GlCILNwLMJ7xYVMYn/ormJxU5VSb4ny7p3pY/zHw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1665696192; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=BWPUAOGLv8rZTGwe9LXI/g9sEfqq2pHFoKlkoLugedg=; 
        b=T+9cU1r8vIGGIzKA3omWjjO4qX/+fRdF0XhlpbHXlCkSxrV4+jgw/zdX+fFmaHpjVoHUtLPYtYXvXt9qrnPrjifisiwTgLu5+RlpHIkbUGKLaEqJde/5okiiZ1r5NygkbPwdPFIkD7WGkJQYQ1oXWhHgKOn5x2vFJblzo773RW8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=alphaservcomputing.solutions;
        spf=pass  smtp.mailfrom=alpha@alphaservcomputing.solutions;
        dmarc=pass header.from=<alpha@alphaservcomputing.solutions>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665696192;
        s=zoho; d=alphaservcomputing.solutions;
        i=alpha@alphaservcomputing.solutions;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=BWPUAOGLv8rZTGwe9LXI/g9sEfqq2pHFoKlkoLugedg=;
        b=kKEt+4nHoSWi93tbR1Dwoesk1aO67rH3HhBLNuz/CbClFOJZfJKiuxmTTqDatcwZ
        XxRlFkS5sxRURzqHHY+8MRVnRBUjNSslob9xfNr/XcXvBd05sXH4ezIg5aaJF64iOaJ
        fUee86ABDA+Wp1qw+qBXfMWzZElnAfo3ER/ybw48=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 166569619172244.7447816986122; Thu, 13 Oct 2022 14:23:11 -0700 (PDT)
Date:   Thu, 13 Oct 2022 14:23:11 -0700
From:   Heather Lapointe <alpha@alphaservcomputing.solutions>
To:     =?UTF-8?Q?=22Ren=C3=A9_Scharfe=22?= <l.s.r@web.de>
Cc:     "heather lapointe via gitgitgadget" <gitgitgadget@gmail.com>,
        "git" <git@vger.kernel.org>
Message-ID: <183d33ad4dc.b3e5b5ca123845.2982022328880074553@alphaservcomputing.solutions>
In-Reply-To: <97a82675-22bb-b996-deac-3f13a91f3df4@web.de>
References: <pull.1359.git.git.1665597148042.gitgitgadget@gmail.com>
 <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com> <97a82675-22bb-b996-deac-3f13a91f3df4@web.de>
Subject: Re: [PATCH v2 0/2] archive: Add --recurse-submodules to git-archive
 command
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---- On Thu, 13 Oct 2022 10:53:44 -0700 Ren=C3=A9 Scharfe  wrote ---

 > > I am open to feedback since this is all quite new to me :)=20
 > >=20
 > > TODO:=20
 > =20
 > This list confuses me:=20

I apologize. I'm new to this repo and workflow.
I had been using checkboxes in github, which look like `- [x]` for ones tha=
t I have completed.
They all got converted into items that look like they needed doing via GitG=
itGadget.

The only remaining one was to update documentation.

 > =20
 > >=20
 > > Alphadelta14 (2):=20
 > >   archive: add --recurse-submodules to git-archive command=20
 > >   archive: fix a case of submodule in submodule traversal=20
 > =20
 > We prefer to keep known bugs out of the repo.  It helps when bisecting,=
=20
 > for example.  So it would be better to squash the fix into the patch=20
 > that adds the feature.  But...=20

Absolutely can do.

 > =20
 > >  archive-tar.c                 | 14 +++--=20
 > >  archive-zip.c                 | 14 ++---=20
 > >  archive.c                     | 99 ++++++++++++++++++++++++----------=
-=20
 > >  archive.h                     |  8 +--=20
 > >  builtin/checkout.c            |  2 +-=20
 > >  builtin/log.c                 |  2 +-=20
 > >  builtin/ls-files.c            | 10 ++--=20
 > >  builtin/ls-tree.c             | 16 +++---=20
 > >  list-objects.c                |  2 +-=20
 > >  merge-recursive.c             |  2 +-=20
 > >  revision.c                    |  4 +-=20
 > >  sparse-index.c                |  2 +-=20
 > >  t/t5005-archive-submodules.sh | 84 +++++++++++++++++++++++++++++=20
 > >  tree.c                        | 93 ++++++++++++++++++++++----------=
=20
 > >  tree.h                        | 11 ++--=20
 > >  wt-status.c                   |  2 +-=20
 > >  16 files changed, 269 insertions(+), 96 deletions(-)=20
 > >  create mode 100755 t/t5005-archive-submodules.sh=20
 > =20
 > ... this is all a bit much for a single patch, I feel.  Giving=20
 > parse_tree_gently() a repo parameter, adding repo_parse_tree(), using=20
 > it in read_tree_at(), adding a repo parameter to read_tree_fn_t,=20
 > letting read_tree_at() recurse into submodules and adding the new=20
 > option to git archive all seem like topics worth their own patch and=20
 > rationale.=20
 > You probably have all of that in your head right now, but at least my=20
 > attention span and working memory capacity requires smaller morsels.=20
=20
Does this mean I should create multiple PRs?
Or should they just be split up into individual commits.
I will work off assuming the latter.

I am comfortable rewriting history as long as I understand the direction to=
 go in.

Should each individual patch be completely standalone?
(To the point where each set, with the previous patches should produce a wo=
rking application?
Or is having the patch broken up by groups of changes, with some level of e=
xpecting the final
functionality good?)

But thanks so far. I will get working on this (and review your next set of =
messages).

