Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E013DC433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 17:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACB7061090
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 17:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238754AbhD0Riz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 13:38:55 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:57781 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238799AbhD0Riw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 13:38:52 -0400
Date:   Tue, 27 Apr 2021 17:37:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1619545087; bh=bxD6Xl+ozG9hOAlN7pH1ag8XD8xPvtJyLr3ORioDIyU=;
        h=Date:To:From:Reply-To:Subject:From;
        b=hXIlGlmFzrvYvBFQ0PsgsgXgBFoICXzEYcDP7XZbMjOOL/WDXB+JfTtiCjMhFOSUf
         IPi4qk2ilyBmTYGuPMb4Bqzirb6Atn7h42PewUl0A60AmGCOGy9KUm9d5ZKW1PbOZI
         aD1EoeDyCzovLpYuH87oAdU0d1+5R1RJmnT9xFSPdnsx0ANpmE+CJq2XdLfW7qWL0D
         hR5OMJOc8+BKErKJ271d7VRLMzv4Yo81Ecg/DsX3QeAGiUpgbOMrrqpiALXKf1sJ0k
         NfgKgXr3mMYqGajDjaqdLADnokDMBcE6fLuIWBtLGzRXaz40QlwOPAs7j7SZfslujD
         0045eKmb5wGWw==
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Robin Moussu <moussu.robin@pm.me>
Reply-To: Robin Moussu <moussu.robin@pm.me>
Subject: =?utf-8?Q?Request:_`git_restore_$commit_$file`_shouldn=E2=80=99t_override_uncommited_changes?=
Message-ID: <pYZzGPZTHnJjYBKrUAVGcso74I_xJgfzNpSwDN94fhYcDoOamp62-IFvxVrU056uw0txy3MTHYSwny_II0XY4trSY5_E25q7EXwhNHjy3VY=@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
That=E2=80=99s the first time I=E2=80=99m interacting with the git communit=
y, I=E2=80=99m not very familiar with the process. I hope I=E2=80=99m at th=
e right place for a feature request.

Currently, I don=E2=80=99t think that it=E2=80=99s possible to get an error=
 when copying the content of a file from another revision into your working=
 tree if said file has uncommitted changes.

I recently discovered that `git restore` was introduced to make file manipu=
lation less confusing than with `git checkout`. I know it was introduced a =
few years ago, I=E2=80=99m late to the party! I would have expected that th=
e semantic of `git restore` or `git restore $file` would discard all uncomm=
itted changes (you are restoring the file after all), while `git restore $c=
ommit $file` would copy the content of said file from another revision only=
 if your don=E2=80=99t have uncommitted changes or to get an error. If it w=
as really what I wanted to do, I would have expected to either do `git rest=
ore $file && git restore $commit $file`, directly `git restore --force $com=
mit $file` or something similar.

Is my expectation wrong? Would it be worth considering adding an option in =
`.gitconfig` to have such behavior?

Sincerely,
Robin.

