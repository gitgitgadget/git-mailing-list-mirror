Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DCDC433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 14:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04EB3214F1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 14:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Q4cAWxj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgHZOgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:36:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:34769 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbgHZOgt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 10:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598452606;
        bh=3bErYy9JCzmQg9ZiGamniFMO8Mv/Zr2hP6TSsuwtu3w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Q4cAWxj26uhGyR7T15LCk9yar33H5DeXSWOQJLPljR66G9PilVE8twk/ybzWxq57N
         gJrJ5nefSaUwYARfNoS4eiHmh4afsTT2i0pHVDdqjU05EpRBUVqLUBt5J0jCdU41iJ
         wF0zU8T6zinMERPPi7hLnB3Ivnl80krtS7bBVd5g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([89.1.212.143]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPXdC-1jx6c825De-00MfLK; Wed, 26
 Aug 2020 16:36:46 +0200
Date:   Wed, 26 Aug 2020 09:36:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-gui: accommodate for intent-to-add files
In-Reply-To: <20200826113030.xnutfxxfmdhgoq5o@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.2008260936010.56@tvgsbejvaqbjf.bet>
References: <pull.699.git.1597244777943.gitgitgadget@gmail.com> <20200826113030.xnutfxxfmdhgoq5o@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dnbfmG58pAhg+8DkHYb/EkFGrGZjzyEkyuKWflFVxOvtq31M32m
 5Z9jFNYpkBjhH3kfXXpPNpd7wjurU2KBMpULjpT6gimeDwl0QH+dZF2SR6TD1ywJ6tmRT/r
 3sOqRsm1oaEMCDoK6/aGcHTRq4JIX9skpL7nefvGX1+BmOpnmjDVFROczpuInyk9BTcDYeb
 EHB1BueMHxwJGpOggNkTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f0FqXX+Wj3w=:/b7OnruyIKWwWVUYYAFeN1
 Yz7Eeif7JjFEaOt0D45hNTbIl6WJz6pVFSTzitBHOfjTb7fV+HTvge4YDCgo+IPblCRFXJw2M
 PPHzkVkptG19WnRYD9h9JQddLI8FqaDHUc2ZZNLfU51aUQnwYIkA8DcHhxsnHCFvFmVXbOBDN
 iEjnitETaydr53h/z+fjOlEjq8X9I5pX+Qsr0m4K50plt0nrORkkgRld4QYw4fC1WcD3tenyr
 CBQsdZTctILrKX9wL23xQs+6DafZCfYabi6gN/EeqNcxWB/Dooh6aOHa/WRhrGsW48NSp6Mzu
 aU/DM/3hDiUdfMBh/bRXdrWh8EF9D+myY4RrIOql/cWpwQQQrfC9ITCpHgYANoO4s/KzLxAbd
 Eznk2P/y3eO9iKgy7rO6az/FENXuSM2KbumzNqwwH6TTTT9jt1/BY+dcBnxxJjYTlm64jgbsT
 GjxTt1buXyo3OHvEAiidmQly2xou8xRLjdHLl7hdtgoib8jGoI0hfqy2FtbSwllgUtcQMJClY
 TlPelg/Z2X6lmVJPMbTFBvk6hueBU3SkETCejV8ksp38VKBXmx2S44rT4YCjtLsN5XebIfYxx
 GZovf3uPCAq/ocsUqEzyXzY5g5SU1pvG3INHOJnIJlcYMDw5yN4K0nHSGtamJDGJ3QSIlvGCe
 0AIyZ6izK7GizXuqoPfEXcoTM5oJi3rA9nMDW/LIrPtuoFm6HJn1dfxpiinOXEXPg3OWD226+
 ZTbq1m1+SsQn83C5y42RgHCbmqE7zQzqcXgcXQQwruDw5GKmcAMUxNkVkYeKcwHpXAqShjgen
 6E9f5SFQF6Io70AGgdphm+IVcvBWQ/gZm0OaaCZQDn5F4H0akJtua30l+G7UYstJGDur7ScQv
 XzdJhMd8cgKsX161AQDKSS6FiIu6XTrRbuEEHoY5ZrLGrDREjzkHl/qBqou25hy3SNABJqrzG
 NC3+IP93FvIT9vO61EuphWAt8JC3CUkuPcDgfcro8QPp1JL6Xc24XbOGXPTQO31TjdNMeUUBN
 Hx+Uq1SDhwvhlHZuLJgpZTIWN8HErwgGbwbwhX/lN3oANGOQJtQNukJsdKN8lXAF+Uyf2Y7Uj
 KiySwoRadVCkzTCQCZ9BGN8vch/kMc1AvX/0dfQQOsPm92VnBRZ7VOKVMrWtpgQnm4tOsmjQG
 9HkHWyS3S2cY7J7tc+Sg8Z30JPs2Qlfkaal9jbMUTIiacsHL/l1t3XEviSj2hAGsKrzfPcXwA
 E99sMm/qVHiWBXt5GXG3s8N7DkInDtiQw1Hn9Rg==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Wed, 26 Aug 2020, Pratyush Yadav wrote:

> On 12/08/20 03:06PM, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > As of Git v2.28.0, the diff for files staged via `git add -N` marks th=
em
> > as new files. Git GUI was ill-prepared for that, and this patch teache=
s
> > Git GUI about them.
> >
> > Please note that this will not even fix things with v2.28.0, as the
> > `rp/apply-cached-with-i-t-a` patches are required on Git's side, too.
> >
> > This fixes https://github.com/git-for-windows/git/issues/2779
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     git-gui: accommodate for intent-to-add files
> >
> >     This fixes the intent-to-add bug reported in
> >     https://github.com/git-for-windows/git/issues/2779: after a file w=
as
> >     staged with git add -N, staging hunks/lines would fail silently.
> >
> >     On its own, this patch is not enough, as it requires the patches
> >     provided in rp/apply-cached-with-i-t-a to be applied on Git's side=
.
> >
> >     Please note that this patch might need a bit more help, as I do no=
t
> >     really know whether showing "new file mode 100644" in the diff vie=
w is
> >     desirable, or whether we should somehow try to retain the
> >     "intent-to-add" state so that unstaging all hunks would return the=
 file
> >     to "intent-to-add" state.
>
> I built latest Git master (e9b77c84a0) which has
> `rp/apply-cached-with-i-t-a` and tested this patch. It works... for the
> most part.
>
> I can select a line set of lines and they get staged/unstaged, which is
> good. The part that is not good though is that a lot of common
> operations still don't work as they should:
>
> - I can't click on the icon in the "Unstaged Changes" pane to stage the
>   whole file. Nothing happens when I do that.
>
> - The file that is marked as intent-to-add shows up in both the "Staged
>   Changes" and "Unstaged Changes" panes, with the "Staged Changes" part
>   being empty. Ideally it should only show up in the "Unstaged Changes"
>   pane.
>
> - Selecting the whole file and choosing "Stage Lines for Commit" works
>   well. But choosing "Stage Hunk for Commit" does not. While the changes
>   do get staged, the UI is not properly updated and the file is still
>   listed in the "Unstaged Changes" pane.
>
>   I think the difference here is because for
>   `apply_or_revert_range_or_line`, we call `do_rescan` after it to
>   update the UI, but for `apply_or_revert_hunk` we update the UI
>   "manually" in the function after we are done applying or reverting the
>   changes. So the logic to update the UI needs to be updated to account
>   for this change. Or we can get rid of all that logic and just run a
>   rescan.
>
> And also, like you mentioned, we don't retain the i-t-a state when
> unstaging. But with some quick testing, I see that Git command line
> doesn't either (I tried a plain `git restore --staged`). So IMO we
> should mimic what the command line UI does and not retain the i-t-a
> state when unstaging.

To be quite honest, I had hoped that this might be a good patch to start
from... for somebody else (you?)

:-)

Ciao,
Dscho
