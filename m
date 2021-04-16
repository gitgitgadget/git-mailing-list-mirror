Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04C5C433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 11:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78496610F7
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 11:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240412AbhDPLVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 07:21:55 -0400
Received: from mout.gmx.net ([212.227.17.21]:57473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235011AbhDPLVy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 07:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618572064;
        bh=NxuldHi7vBqfRIVOz7rUmKP8GZKEPfFXLfg4iatz6Ng=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dXa0D+AQRBFcxHtTZjDTiCBKfkHd0HZFP+jRt8D30tDWJ+3ziLBua7X4gob8izRB/
         o92ATVu+zV9gwgZsOsUOMHSLuPf5MGaCn1Mtw11OfBdrFT3S8oYAjzuWizKseNuyCC
         VwNksQ0PaN0Pi3Ue6OURS+XZm4wgDBVH6kJsDflw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.167.141] ([89.1.215.94]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8hZJ-1lSfZ03qUL-004iaV; Fri, 16
 Apr 2021 13:21:04 +0200
Date:   Fri, 16 Apr 2021 13:21:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2021, #04; Thu, 15)
In-Reply-To: <YHj9mUzs+jlgNuVE@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2104161320250.52@tvgsbejvaqbjf.bet>
References: <xmqqa6pznlgq.fsf@gitster.g> <YHj9mUzs+jlgNuVE@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rVX2AubT7GurAyiesmcb7yxUxukob0Oqn7n0MSvwBLBcHSsWnZm
 YhDwg5lFpG+gwK4yU4QrWP7peqviWio1tJFi1m85J8L16DtD37kZyef3egzflUOXTdgeU95
 VYwOj5EP04AJtIUEclOh8ssb11WpxXGCJbjNRxnR8YfhAarzqlbd3k2Mmjb8/7lsE5bq+X4
 Ug0pN4IWzNjnx9VrhyV/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:odDLAzfh/s4=:vWiFgf3LuWAZYeQ2/awW+e
 qFSsAFI8JsHIvXwMP9vfEATeBsYLiRbIQ+jCa/4dpr2Nf39BshqLywFwguTcptbAX/PLfiPzW
 F3T7sA9fotl6AjmylZO6qZRzAKCrk0CzbQTYZzMOsqkrLHk+FVNvpfvGQBzaMYkjdCRCRecBR
 8kUph3pJiVg53Tei8snYuxr73LEJs0g5B759FDoMR/S69lqe0xR7t1IU6rQKLqyXyuU+nxmtj
 PoDkuNQ1pY89pRzciILAPy+S3LWnTNh8f/dNnBN8n8XR63vgzcS7Q1ITtHvxkQXkMyrzP8up7
 Teuw42psJaWBmLcovoGgblalfDLzS7+m5Ek00tib9kVzh+P/QH2PaBk/KTVtqvC+R2hQA6mVa
 38E3pQJMB2wdJ8ObcIM2XggwidKVPd/2q9t3ZbwEaSiCV1E+UEveNOREzv3YhOsRNvH9FTjfV
 IdjYtAt/RA/BzY5c9uhml58t2ft1aAAuVJx0A6nvah0mvOWYwMOPOCNg4VNc4arA7GMU2XqM6
 WuU4L9fzXakTSko+RpYCHUYQb8wfBJ0tYxylCtz8woZUaHj9FXouKPIi1vYhc/XPBQELQrAUH
 yPQn/cV8L4L9KPkolTFSXbrA+q8H7mKWzJR1tsteoLPo7Ne9AW08sVn1BaBx/mUAr88oRDFrk
 p5jjInHNlWqnNRZucvdzLAj/ZO0WQhRtpJo9H6RNRsQoVAJeOtG2j3Qu3MKOuqAtJY5Y3MmXi
 T2UU0IVr35dR9nkOF3WioFa9tMqXdmzXZwUvu1o2SZ/m4I1p763uyjv5VHtOtd/MjiUxwY+Tl
 Uz7JOAofRqjesVYh/AbXu6mbfWNX+5VD+movZfkoon9PbUnc0x7Ghow2tMBhpPvGk0e+1+dks
 Db5avcgp/NvXAhJbAD2TeqIGpuQeCn1T7uhyFWeeYcs9f3g4MHEE/8Nud8TW4FyiFTpcgGQwH
 cM5JSDYY0Sfymapkxf/qLkHmhKBgGAKsNehVEJpUuqEdF5kk753IRT1jAgNCoHC34o91mJ4PL
 3PvS4SmOcpwCmY6DpkD1TWrNLHk78CYGbkhsw0nElQVumwYv7tYdhOTYyrf2x2igN+PMS/NIu
 r1QJBpZl3fqJGCf1Xb7QXEul6oFE8rZd72ths4dlULUuLwxgi+KDhW8JnNGa6j/tsZuNJu6zH
 ZLzCetmJwGClCQWB3jCGy/PmR0yHXKWEEklJBTpMjfeaI9YKug2vHuAURZai4hQP5OTYfLeyV
 4aDxuZg2j9fOM+GHX
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 15 Apr 2021, Jeff King wrote:

> On Thu, Apr 15, 2021 at 05:04:37PM -0700, Junio C Hamano wrote:
>
> > * ps/config-global-override (2021-04-13) 3 commits
> >   (merged to 'next' on 2021-04-15 at 60a58d74ab)
> >  + config: allow overriding of global and system configuration
> >  + config: unify code paths to get global config paths
> >  + config: rename `git_etc_config()`
> >
> >  Replace GIT_CONFIG_NOSYSTEM mechanism to decline from reading the
> >  system-wide configuration file with GIT_CONFIG_SYSTEM that lets
> >  users specify from which file to read the system-wide configuration
> >  (setting it to an empty file would essentially be the same as
> >  setting NOSYSTEM), and introduce GIT_CONFIG_GLOBAL to override the
> >  per-user configuration in $HOME/.gitconfig.
> >
> >  Will merge to 'master'.
>
> Looks like this fails CI on the Windows VS build. I get:
>
>   ++ env GIT_CONFIG_GLOBAL=3Ddoes-not-exist GIT_CONFIG_SYSTEM=3D/dev/nul=
l git config --global --list
>   fatal: unable to access 'nul': Invalid argument
>
> from t1300.181. I thought we had some magic to make /dev/null work there
> (or maybe this _is_ the magic kicking in, since it is looking for the
> Windows-ish nul, but it is not working for some reason).

Seems that this fixes it for me:

=2D- snipsnap --
=46rom 754593d6bda3754ab4afaa98b814351e922a1fe3 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Fri, 16 Apr 2021 13:11:05 +0200
Subject: [PATCH] msvc: avoid calling `access("NUL", flags)`

Apparently this is not supported with Microsoft's Universal C Runtime.
So let's not actually do that.

Instead, just return success because we _know_ that we expect the `NUL`
device to be present.

Side note: it is possible to turn off the "Null device driver" and
thereby disable `NUL`. Too many things are broken if this driver is
disabled, therefore it is not worth bothering to try to detect its
presence when `access()` is called.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 compat/mingw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index a43599841c6c..aa647b367b0f 100644
=2D-- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -685,6 +685,8 @@ ssize_t mingw_write(int fd, const void *buf, size_t le=
n)
 int mingw_access(const char *filename, int mode)
 {
 	wchar_t wfilename[MAX_PATH];
+	if (!strcmp("nul", filename) || !strcmp("/dev/null", filename))
+		return 0;
 	if (xutftowcs_path(wfilename, filename) < 0)
 		return -1;
 	/* X_OK is not supported by the MSVCRT version */
=2D-
2.31.1.windows.1

