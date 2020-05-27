Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DDFC433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 15:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 577F1208DB
	for <git@archiver.kernel.org>; Wed, 27 May 2020 15:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="dDx95Qub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgE0PUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 11:20:34 -0400
Received: from mail-40130.protonmail.ch ([185.70.40.130]:43407 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgE0PUe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 11:20:34 -0400
Date:   Wed, 27 May 2020 15:01:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=protonmail; t=1590591685;
        bh=n3z8G4E/sZiNinfibSyIWIzSCu/bMhbf7CGBUPjJsvo=;
        h=Date:To:From:Reply-To:Subject:From;
        b=dDx95Qub55bm3Os1jwwmAxKUqZBlNUWJMr4DLvpXRMq4ErVtkF39//VKMuIyeNioT
         w64zDXB6l0mHBMEWZjAqdWkBpY+IroYBpCURI/zRMQf8vNXOtA6Vrsz5nBAAEkav8F
         4QVNikjCFz13UXUyAJmIAaPBoNfJGLPlaQTbK2r4=
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Laura Smith <n5d9xq3ti233xiyif2vp@protonmail.ch>
Reply-To: Laura Smith <n5d9xq3ti233xiyif2vp@protonmail.ch>
Subject: git submodule question
Message-ID: <Wri_F6OxTiG7HZNvyVdFwGp7qrTWqC7Oipu214kLQ8gGMhna7SU6AXdm_m8tkDaPlMKtXGXc84TSACkN0tigR9satiLkrXn23bfM331g09U=@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm using git submodule to pull some third-party config templates into my g=
it tree, using the following:

git fetch  foobar-github master
git subtree pull --prefix software/files/perimiter_mail/foobar-github fooba=
r-github master --squash

Now, the question is, when the upstream makes a new commit can I force pull=
 that commit and make git overwrite any changes I've made in the subtree.

At the moment I get bitter complaints from git, e.g. :
CONFLICT (content): Merge conflict in....
Automatic merge failed; fix conflicts and then commit the result.

Basically, I want to make myslef an update script that force-pulls the late=
st upstream repo and then the script will take care of making the necessary=
 modifications (the upstream puts placeholders in their repo, so my script =
would take care of replacing the placeholders with the real values so that =
everything works again)

Thanks !
