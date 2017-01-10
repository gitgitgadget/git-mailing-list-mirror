Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFBCE20756
	for <e@80x24.org>; Tue, 10 Jan 2017 17:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762338AbdAJRBd (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 12:01:33 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:37079 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755326AbdAJRBc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 12:01:32 -0500
Received: by mail-it0-f41.google.com with SMTP id r185so52700404ita.0
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 09:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LReJ0GXAao1UlMkIhitzqSIw7sUJT93qkxgYngl6Sd4=;
        b=Aoj7bzhebzi89uJYJic3qcNchfuBXUMDabRcNy2XVZkvcW4aezlkSLi9jtLSJoWaId
         1WPRGt0d+3qpto5rr/AhPJHDzYtM0cOkCleHO4RgmIwqi3icPJdA4vqWnc/flEqhfidM
         eN2hL/dDae2oFCya1/R6rpEGLXg8UOaw2f9UeEZmC5aHgsGjzjnFofg9ZdYyJDVbYSn7
         9yf3li1+etqARWmgsbPJ54AKftZ6L0na7vNNxfz4krMBEy1hzRahkeT9XIuxjLb4+WJe
         6XnQbk2slfs5qdPp7SfgJ78FZnHdrI5KinYFOVZ6S0OosvNEctoBRGpNAybBccGPjvvS
         hWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LReJ0GXAao1UlMkIhitzqSIw7sUJT93qkxgYngl6Sd4=;
        b=uc1uzs3fmeFg4FOORuCFPd9DaUeoPCawZYYBZACNU1Ol71HI7e8RflNV1E/g5DdjH4
         NBRJNp6EbSZGepUBI8P25LdrWzmPNLKeOrTaB6lywbt1Np51rE1tmlcRGLk7huKMKCOW
         wI0HfDpb7n2LQpnX70zHuz7N4NuA8zcIpsDRrUR+W8s0cpPPNPjr4WUC5eugPGa/BpVi
         8jPcQ9VPvAtF4fvDaHbctI5I0SM8gCEgirjmbewYYJkDlZvVmeWmNn92Ccau51ez3WsX
         rcl/YoZzAeI5MCLZUPy36NzU8UxYiOF1bHJVnuuvSOKePdUtoh8aRl0/bEaZakXA5rYy
         Vu3g==
X-Gm-Message-State: AIkVDXJtfPrAC5MqGVK+42ZmkQ+SR6ARkoR26DN/e/LE2sY4NkyDQMe+EfZsW7LOwY752LCxK45RvezHGARQFPMm
X-Received: by 10.36.88.143 with SMTP id f137mr3861293itb.116.1484067691135;
 Tue, 10 Jan 2017 09:01:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Tue, 10 Jan 2017 09:01:30 -0800 (PST)
In-Reply-To: <20170110112524.12870-1-pclouds@gmail.com>
References: <20170110112524.12870-1-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 10 Jan 2017 09:01:30 -0800
Message-ID: <CAGZ79ka+zkr83tSkg_kJWoN1u3fgu1O3u1-7USEoSM1tj-53vA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Per-worktree config file support
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Max Kirillov <max@max630.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 10, 2017 at 3:25 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Let's get this rolling again. To refresh your memory because it's half
> a year since v4 [1], this is about letting each worktree in multi
> worktree setup has their own config settings. The most prominent ones
> are core.worktree, used by submodules, and core.sparseCheckout.

Thanks for getting this rolling again.

>
> This time I'm not touching submodules at all. I'm leaving it in the
> good hands of "submodule people". All I'm providing is mechanism. How
> you use it is up to you. So the series benefits sparse checkout users
> only.

As one of the "submodule people", I have no complaints here.

>
> Not much has changed from v4, except that the migration to new config
> layout is done automatically _update_ a config variable with "git
> config --worktree".
>
> I think this one is more or less ready. I have an RFC follow-up patch
> about core.bare, but that could be handled separately.

I have read through the series and think the design is sound for worktrees
(though I have little knowledge about them).

---
Now even further:

So to build on top of this series, I'd like to make submodules usable
with worktrees (i.e. shared object store, only clone/fetch once and
all worktrees
benefit from it), the big question is how to get the underlying data
model right.

Would a submodule go into the superprojects

    .git/worktrees/<worktree-name>/modules/<submodule-name>/

or rather

    .git/modules<submodule-name>/worktrees/<worktree-name>

Or both (one of them being a gitlink file pointing at the other?)

I have not made up my mind, as I haven't laid out all cases that are
relevant here.

Thanks,
Stefan


>
> [1] http://public-inbox.org/git/20160720172419.25473-1-pclouds@gmail.com/
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
>   config: read per-worktree config files
>   config: --worktree for manipulating per-worktree config file
>   config: automatically migrate to new config layout when --worktree is u=
sed
>   t2029: add tests for per-worktree config
>
>  Documentation/config.txt               | 11 ++++-
>  Documentation/git-config.txt           | 26 ++++++++---
>  Documentation/git-worktree.txt         | 37 +++++++++++++++
>  Documentation/gitrepository-layout.txt |  8 ++++
>  builtin/config.c                       | 16 ++++++-
>  cache.h                                |  2 +
>  config.c                               |  7 +++
>  environment.c                          |  1 +
>  setup.c                                |  5 ++-
>  t/t2029-worktree-config.sh (new +x)    | 82 ++++++++++++++++++++++++++++=
++++++
>  worktree.c                             | 40 +++++++++++++++++
>  worktree.h                             |  6 +++
>  12 files changed, 230 insertions(+), 11 deletions(-)
>  create mode 100755 t/t2029-worktree-config.sh
>
> --
> 2.8.2.524.g6ff3d78
>
