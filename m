Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2394C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 12:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbiGLMe7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 08:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbiGLMe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 08:34:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF7C2C100
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 05:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657629280;
        bh=2pw1fLFRxBGcFTK31mto9KeDKXexxnl0jxK/m7MfQ5Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SfyY4SQx9l3EPsfhrdzMWEJryFjLtDtK9RQ0jLhT5clVTWEvrdoD8PsWVGPBGW8ac
         RWx1px/wzCf6ohB2Yzv27ihzCqXogNwBGblUZgmAGYIANpcYYDFAjzbCXMvnFfiKeM
         GweRQeHNdxINhGsHeQ5P4f9OaaSgxPOeODzqwoVo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.180.6] ([213.196.212.225]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMGNC-1nt1ir3huY-00JJjL; Tue, 12
 Jul 2022 14:34:39 +0200
Date:   Tue, 12 Jul 2022 14:34:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        git@vger.kernel.org, phillip.wood123@gmail.com,
        congdanhqx@gmail.com, christian.couder@gmail.com, avarab@gmail.com,
        johncai86@gmail.com
Subject: Re: [PATCH v3 0/4] Add support for mailmap in cat-file
In-Reply-To: <xmqqv8s5sf8x.fsf@gitster.g>
Message-ID: <50s3714q-8p5n-2379-65r4-17304426rp93@tzk.qr>
References: <20220707161554.6900-1-siddharthasthana31@gmail.com> <20220709154149.165524-1-siddharthasthana31@gmail.com> <xmqqv8s5sf8x.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8SJHzfQtsoqv9rU1dQDZbA8/gJki+XKUzvKXrUV/t8pAoi3RPhe
 MRSsjJSeqAUhlQ+X9VWR/hWgVfE1yTkxSzEthgdGYBqygOyzpwyXk1cRv8Fzn75gBGH/dIb
 VRa0dPu9Qbtki3is8pxdNl6JgwxXoIMADyObdgaI1RdFIwD+BzeVL2opWDn9Rigdv2Op17E
 rzhTuVHlf28hhMXn9vFkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ztYEbDKII90=:mlOgyqkHf0U/6V9/ePJVLS
 g6r6WrvU9iQMa8W5/iBgoR3sWG6dJiGzDYDdcojiCOYLbloDRcxq8mCeHSan1NI/OOrgIqcEQ
 /GysKgttuFO7WV9jtoMbAG11uSF2KTUhTJrA8IJbPMeyHXyNVF3iOjX03jPYarfwSN3NyAxFC
 +qduAlg4jLE5SA/MwLFFewTslygvEEwuLDjK4eNwTgamF3vT7PlKwyOY6hfExxwXr/tMkyYjo
 Ibf21g5CgAyZGeX/WfsDJSRhZ+UGPrpKWma/A+shTLu/TTwRkNpfHprMFRVV3IdB4wHc1sjfi
 kF+LDjA5+CqOq7ppPJu94W2MROfnje7z43wVPZPk5s6egsqg6+pJjQ9IvhKwZSeKFEiT3vjtq
 XY/jRIkX/QQHeqqWritWL1ZevyYvtzLuAE5URwRImcs04D4HYQRtE9tuYGqm0avZx/i27dGqT
 U6EJBByWaXGCgEIiK3f2/AOTkSSs9u09T784IZ/rJ+TEr4HiIweJBm4CPv2KSd93Y0F/XIS2q
 IMVQry/+J02xKXgWzGlZgsbgCArVar+rO5cNvJjzQvRqrbO2kFAV97ESPcOoJrsLsbg9/7Mn5
 GFXwnIuDBjdfdEd4yfqHeQIQlLVLcg5X1yrikSDEZ7SZ3sWL0MTpDTg9WnFxega3NshL/wNo+
 4EM6wZ7ClZAKrUUfC+ytlvu9hFyszWSzuMQNipfXfqGFNjsSoA/4gn4IG8hXCNPpuEBSs+JYz
 CI7OqZtyVI0kOytikdHsNqoz1cN4L2OcOtikvOrT/kiWrKUyQi/MIkD2Aw6GamQ0PA2m6/1aj
 mqJcqyCFN3oxB+3XmVpH7xBnNqeKPCy3rVnM3UUF45HjXbpMhQjKdDJLHSCvcOGPb+mKhfJqc
 27eOkkY7wDumwEqJtR5BiMpUOoCeVBYNV1qyXka5X17ffmI/bm5wm+3bytm4BIHecvdfqFNdD
 mO5VPUdYa6Et5cIlpZryzXtpB2BA9hzwmJQp5aiaHZTsNFp9G17V3pU1uIPKPUs/vCg7j+HXY
 3ROohIBSbryidWavgG9I7JqLbs/tTqpemPgNeJvdBgPOPigEfB80kJpdqSoKkgFiJEMq29Voz
 v2WWpJPUbUGZ8CuaShZsuGXbjeVp06rrRq4sF/6Tefc20HBu1Iafh/KzA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Siddarth,

On Sat, 9 Jul 2022, Junio C Hamano wrote:

> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
>
> > =3D Patch Organization
> >
> > - The first patch improves the commit_rewrite_person() by restricting =
it
> >   to traverse only through the header part of the commit object buffer=
.
> >   It also adds an argument called headers which the callers can pass.
> >   The function will replace idents only on these  passed headers.
> >   Thus, the caller won't have to make repeated calls to the function.
> > - The second patch moves commit_rewrite_person() to ident.c to expose =
it
> >   as a public function so that it can be used to replace idents in the
> >   headers of desired objects.
> > - The third patch renames commit_rewrite_person() to a name which
> >   describes its functionality clearly. It is renamed to
> >   apply_mailmap_to_header().
> > - The last patch adds mailmap support to the git cat-file command. It
> >   adds the required documentation and tests as well.
> >
> > Changes in v3:
> > - The decl-after-statement warnings have been fixed in all the patches=
.
> > - In commit_rewrite_person(), the data type of linelen and i variables
> >   have been changed from int to size_t.
> > - The return type of replace_idents_using_mailmap() function, size_t,
> >   has been explicitly typecasted to unsigned long using the
> >   cast_size_t_to_ulong() helper method.
>
> https://github.com/git/git/actions/runs/2642867380 seems to tell us
> that tests added by this series are broken on Windows.  I am not
> sure what exactly in this series depends on being LF-only system,
> but the symptom makes me suspect that is the cause of the problem.

It has nothing to do with LF-only, but everything to do with symlinks (I
suspected that when I saw the skipped test cases at
https://github.com/git/git/runs/7292710632?check_suite_focus=3Dtrue#step:5=
:195,
and could validate that suspicion via disabling the test cases by
inverting the prereq: this caused the very same symptoms even in a Linux
setup):

=2D- snipsnap --
=46rom 5bc6d52c95401f60e67312823ed406bd5a3c1026 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Tue, 12 Jul 2022 14:28:05 +0200
Subject: [PATCH] fixup??? cat-file: add mailmap support

This patch introduced new test cases that rely on the side effects of
the earlier test case `set up symlink tests`. However, that test case is
guarded behind the `SYMLINKS` prereq, therefore it is not run e.g. on
Windows.

Let's fix that by removing the prereq from the `set up` test case, and
adjusting its title to reflect its broadened responsibility.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 t/t4203-mailmap.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index c60a90615cc..94afd4717a2 100755
=2D-- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -932,7 +932,7 @@ test_expect_success 'find top-level mailmap from subdi=
r' '
 	test_cmp expect actual
 '

-test_expect_success SYMLINKS 'set up symlink tests' '
+test_expect_success 'set up symlink/--use-mailmap tests' '
 	git commit --allow-empty -m foo --author=3D"Orig <orig@example.com>" &&
 	echo "New <new@example.com> <orig@example.com>" >map &&
 	rm -f .mailmap
=2D-
2.37.0.rc2.windows.1.7.g45a475aeb84

