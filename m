Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10D2C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C695460FC0
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241973AbhJ0Mqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:46:32 -0400
Received: from mout.gmx.net ([212.227.15.15]:39459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241968AbhJ0Mqb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 08:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635338642;
        bh=iGXjZeV0Rg9AmD4jGyDBcCeAxcOgsFdRVBqIAiiPgoY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aN2kR89eGAiy+D6LM7Wc+DAvYY5WMhawMqtEroLyB7hnWUSiEQSH0oKtYLFX9qH3r
         Dy7Kvn/5NRXdjrXqZBh/B21cor7+yvyeM/i/0JJM4NrMVJ+S7pfU2jot9VIVqI+9xs
         fjnhvRa+w59oEiqqMsfqBa21iBNUQQoFu5wv9Xb4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([213.196.213.185]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McH5a-1nDwZq0CYW-00cjqZ; Wed, 27
 Oct 2021 14:44:02 +0200
Date:   Wed, 27 Oct 2021 14:44:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH 0/2] tmp-objdir: fix regressions in
 core.fsyncobjectfiles=batch
In-Reply-To: <pull.1067.git.1635287730.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2110271439120.56@tvgsbejvaqbjf.bet>
References: <pull.1067.git.1635287730.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ujrgp0trvhss9DhdsGlJRzNgMRlE46wAcWAoCPcKoYRsFWJosD+
 3u1tlL8mfzcPFW1vYsij61ilsWqGtwsvk8lC4kU6Aj6X7umXL4x7eli0xx9+K+oREic0nk5
 3ia+mUMdjekeSWl+7zTbkB65BJwKMMD2ejkTI3506lDeLJexI9wiwtSdLqEqOSh7YFizIlF
 ifQhEkyzYJGCMc7sPfvNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PP+31qlAdSE=:Vf2wZZ6QNxRbD5MKGJnydc
 N8FEi/cX7oEjCSiCYQ0uq/z6oNw4iG2QptuO9ZrsVCADok6WeEZBwU54l+p9/2MiErjfHLPxh
 vX9zrc/xTT6FWxO0RDfYZC5a+nMyIjyD6phXfL3O9EoWy0NBVeZuJCny38ccTgG+SA8xIYOZ9
 Jjxd3VOj6ucnt18danXBjc6D+p81yRoDaCZcCBy+JUbuZAzIpKmiwXFRPWiqoVx6gPLwpx+G5
 z6DcIIV/zajaJWnGYtYOHkz5dvr1UVmaNqkmCO6fI92u5QJrsuDnntQNh/nzL4qUmMHl4zecu
 /oFVAkIQGM4+YEvQTJ3oPWv6/E/GWXOYZyOfwn2OMtvAblGOlyjNT2HptH0KVF3ChPhznBGfD
 eFsv0NKwH8MKv2XG1URPvpue406hpNq8ld5ugPwlV6VnBkDgOE1VH05W8BD/DQ9s0p0iO2qF9
 5/X8e5MaV1lTbmoE4WflJj5YzfANzVX9Ytiaz/yqtUpamtyDOpi4ULp0QcwZCk8meV6R6qykg
 zXAfN4Xhy+EZE5VtSVCcNjHmwbgz1Z6k+wOVuqD9OkTW9ICu7dRLud/rKTv8ijTXGjbH8yRLY
 gtlsxGNqWwWLWRf06oDkS3IrfsFJKPQgK9Ykhw2WM+/YDL5k3nZCzFzdu+a0NAn2ToWFQ5UIU
 bWMrUzWUF72H5Ae8sWgKYEh7AD2gAMZGb5Ei4Chqzjn2qwA/l6op6CfweCiBsKTTFwT/9HDUK
 j0haOvqjwnrK0KkCdJBYuIDhvmq/JhTfwYGXMeykjFcDyYMdXv8JxgN0r2Rv4hS5jWQXz7lLc
 Fr3TkyAjFUlkyJrWbQIjfPC5x9C9Qe38F4vTJjAJK1lWFwMD8LVv2r22GOfyMLWXgSdHuwfGw
 H0fEk46tXu/YMJdNXbSw05B8RfB6RrkweaV+y0gvhQWuA9UUF8kPw8HO7ioyZld2GWzNC+gp1
 RIaZ4I5zeCp0+WywJco7EWDFNcr0TCfQ1r3VLW9SKuKAdTN02iB4aCaUhqHGJUFId0dI6hrvD
 kScwN3Axef05FAdXIZYakazR7g1gZs3ZeafV86ApeNYxdJFUWzPGDLbpQSO4ykU5/6TwqkAQs
 uySPm3bZKc54oo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Neeraj,

On Tue, 26 Oct 2021, Neeraj K. Singh via GitGitGadget wrote:

>  * Fix prune code to be able to work against multiple cruft directories.=
 I
>    noticed this in self-review.
>
>  * When dscho enabled core.fsyncobjectfiles=3Dbatch in git-for-windows w=
e saw
>    some test-failures in update-index tests. The root cause is that
>    setup_work_tree does a chdir_notify, which erases the tmp-objdir stat=
e. I
>    now unapply and reapply the tmp-objdir around setup_git_env.
>
> This branch autosquashes cleanly and it needs to be merged with
> ns/batched-fsync, where it currently merges cleanly.
>
> Neeraj Singh (2):
>   fixup! tmp-objdir: new API for creating temporary writable databases
>   fixup! tmp-objdir: new API for creating temporary writable databases

Thank you for the fast work on the fixes!

I applied both patches to the PR branch and pushed; Let's see how the CI
over at https://github.com/git-for-windows/git/pull/3492 pans out.

Please note the original patch made it into `next` already (and is hence
subject to follow-up patches rather than being rewritten).

Therefore, you may need to reword the commit messages so that they stand
on their own, as follow-up commits.

And alternative would be to ask Junio to kick the topic out of `next` and
back to `seen`, in which case you will probably be asked to submit a new
iteration of the original patch.

Thank you again!
Dscho

>
>  builtin/prune.c |  1 +
>  environment.c   |  5 +++++
>  tmp-objdir.c    | 25 +++++++++++++++++++++++++
>  tmp-objdir.h    | 15 +++++++++++++++
>  4 files changed, 46 insertions(+)
>
>
> base-commit: 50741b157f2f90df76a60418e2781b2c1e6e3c78
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1067%2=
Fneerajsi-msft%2Fns%2Ftmp-objdir-fixes-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1067/neer=
ajsi-msft/ns/tmp-objdir-fixes-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1067
> --
> gitgitgadget
>
>
