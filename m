Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DD3C433FE
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 19:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbhKWTkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 14:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbhKWTkU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 14:40:20 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B078FC061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 11:37:11 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id r11so96739152edd.9
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 11:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/Rp2PXl8RLyWrP75H3ofSssXzEKtqwl/3+ANf+glwqU=;
        b=nrnBp2HLoPKMONvlPrZ2vABP/2yXBQo9r7rFMguukeivi7bvdHQeI2dhXk/1vVQLJa
         4p3wzu0CxL/pjmV++sNNpwtsqXo80jTEo3vgXtsqzj/Fje6Zlov5ym68nUFWkHHyTmsJ
         a7wiotJ194B/SBPjInJCpaDcNv6T3lbZQrQnbyOvPw2uScE6+TNqMaFyx4lw7rod3vzL
         sCGeiK7iQk3tILevJm9WLqkCGiE+1kV46ZKlxpFmBXQBIUIf+4R9o+f52o/dWQ2mj4yd
         Db/47Ym8GyzgL7GjBEAAtdNx9M9ica9sf6YBTfvaECNFv4h97qG5qyFuT9fqJPuOLPAo
         Vphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/Rp2PXl8RLyWrP75H3ofSssXzEKtqwl/3+ANf+glwqU=;
        b=EwpjFT3qHi8D5Vte4S9hNEJwVFwN6/SyN3IBkqHcyM6PUHx/g8D/Bp+yeRZJnjrTlF
         oEGGvoiu3Zd6BEB4VvCYqIQAFB9fX0xMYoZzikPVCY0Ahs1aZBUMeweK1d9DmBn7uM5H
         0+Wghyd7GPjqvCVn8IPMfA+VgcR31UQc83OfZkN1rkINDhaFN1qUMUeOHK277549+h4a
         TAGzLGHwbK7s5izk2ECQJw2AA4ESFTUVkH1313zOMPYfzbv4r9IKgGL0bVluTxXFqeN6
         xUriez/hIvP5rADIboia7/MwH1zx6u4cQQM3JIIBesZbicHGeiGj2ec5GqwqtOl38zVd
         yNcA==
X-Gm-Message-State: AOAM533+5bxYHlATlgkJclle6nIN/DM0HhcwyfztDHRyB2Rx5kuifHNy
        meicoVL2qvxKgZA0k3e7QXkaXhm+Zj61am1WLDTr8MIOm+A=
X-Google-Smtp-Source: ABdhPJy/98Vt6DIKIwJXxTeI8MUBxJJxh1+8q3M+NZUxrroP7vYYxNqMiJRVgslMkyuKB9vOa5Fq0pMm0qO9finHszI=
X-Received: by 2002:a17:906:4c9:: with SMTP id g9mr10890536eja.172.1637696230287;
 Tue, 23 Nov 2021 11:37:10 -0800 (PST)
MIME-Version: 1.0
References: <5D6F04AA-1CE6-423D-B097-58C0F429C9CA@yeplaa.net>
In-Reply-To: <5D6F04AA-1CE6-423D-B097-58C0F429C9CA@yeplaa.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Nov 2021 11:36:59 -0800
Message-ID: <CABPp-BF8_E+=8+5UnztM4wYML__E4uC=z5nPVAd+AYVH59Bvqg@mail.gmail.com>
Subject: Re: Git subtree command sustainability
To:     Loic Fouray <loic@yeplaa.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 23, 2021 at 11:13 AM Loic Fouray <loic@yeplaa.net> wrote:
>
> Hi,
>
> I want use the git subtree split command on a new repo for splitting, ext=
racting only a directory with its commits related from an upstream repo. It=
 works !
> But I would like to know if the subtree split command is sustainable or i=
f you advise to use other tools (as git-filter-repo for exemple)?
>
> Thanks for your help
> Lo=C3=AFc

Extracting a directory and its commits is a fairly simple kind of
rewrite.  If that's all you need, both tools can do it.  If
git-subtree works for you, that's great, and you don't need to switch
to a different tool.

If you're trying to do something a bit more complex, here are reasons
you might want to use one tool or the other:

- When rewriting history, commit IDs change.  git filter-repo will
rewrite commit messages to update references to (possibly abbreviated)
commit IDs to use the new commit IDs.  As far as I know, it's the only
history rewriting tool that does that; so if that's important to you,
using filter-repo may be beneficial.  But not all projects are
concerned with this; some repositories just don't have commit messages
that reference other commits.

- git-filter-repo allows much more complex rewrites (e.g. replacing
text in files while you are at it, stripping large blobs, using
mailmap to permanently change names, generic path manipulation,
inserting a commit, etc.), so if you also need to make other changes,
filter-repo is the tool you want.  git-subtree offers no other kind of
rewrite.

- git-filter-repo makes no effort to allow simultaneously working with
both the original and rewritten histories.  That kind of thing does
not mesh well with a generic history rewriting tool; you have to have
very specific types of rewrites to allow history to be reversible so
you can take information back to the original repo (in addition to
needing to track extra metadata).  However, git-subtree was written
precisely with a limited history rewrite in mind where this is
possible and provides tooling to assist you in working with both
histories and porting changes between the two.  If that's something
you want to do, git-subtree is the better tool for you.

- If you run into a scale where git-subtree doesn't work, but you do
want the simultaneous working with old-and-new histories abilities,
you may want to look into https://github.com/josh-project/josh.


Hope that helps,
Elijah
