Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF0EC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 19:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345172AbiHITHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 15:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiHITFj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 15:05:39 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD62D27CFA
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 11:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1660070651;
        bh=W066bnbar3QgotPbKbkhcCv+xeooq2E+9MeCM6iErZQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=bSf8Eg0zHdLGn3PvaBKcjoWpbJ2eBJo/uCNtfjZe2pYd7EWAg/ZUwUES7G3e5AoDn
         5ZRpHzrXfg05/FoR7YPXpULaLYHUD0lSsoQKkaZfzhn5L/d8CJko+3af05SoTq7qcc
         NUZDCTcOklJDVRPFfBQFMt8kwLqjqFRWguW0jzBg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKdLM-1o7Fe2475Q-00LQY3; Tue, 09
 Aug 2022 20:44:11 +0200
Date:   Tue, 9 Aug 2022 20:44:09 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/4] doc add: renormalize is not idempotent for CRCRLF
Message-ID: <20220809184409.wypm5gqct6iwq5zo@tb-raspi4>
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
 <d3b8ed97a105ea1d7e656c964b7eee378e11ede6.1657385781.git.gitgitgadget@gmail.com>
 <20220710074848.ku2zobuck6vyim5d@tb-raspi4>
 <1b90edd0-3d9d-a741-8865-3968826da315@iee.email>
 <xmqq5yj6z5rx.fsf@gitster.g>
 <e454bf85-046d-6205-57e7-4c00b9faa589@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e454bf85-046d-6205-57e7-4c00b9faa589@iee.email>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:cvVGw9EC7WI0ePUNqAUvdNv4rbdYpeCcOVTQjBP3nwJxzPEaGz8
 MmHxDVNOCfR2N+09Dql7a1UXun7wqIh86ZJDpG77n4rw9XheW2q7mkpn1hMndgQTT3oVy4v
 P4L5aC/ohrXzOu6O4O+mwU0ZuFWzNDd1NCaBL+JVq6fFKWPGOWiv8gjsYnbhz0h73agdujV
 3ayfXU5kSKGDXoLYoQOzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:blkxVeovXc0=:z969AWA1LTOQhgxzCws+ha
 FZqJ2tZtf/tbq/0Ps1OBbj2lQSVqxNVC1dZjjQJmk3cw8FIEJjV2g3DMwStI2DwL2pjoeXj1r
 imQL2FdKap1CNtO7Nx62j4Nxvp2p3ym/Bj6ScOfoXccqB87jeKhVex61zkqzVD4mMOxQ6dTO/
 4qQBmGuAEQyLPqrpHHTjOP/z4xNOAsXo0NPTCfNsUZREwFBD4FQrSKK6qyjY1CF7xeyCTwV6y
 CjiWMitY92Uuej7sBH9rEYCNEdqhqOF3xgIqnkSvdFo4paUYMl5CNa7uuMhJDH2xY3/5muhRI
 0FlAC4ke6M2z2/4eArFMlkPGp4sqyzI9amPEmnHtknW0bn7a5tVN0Gc+/ilvDeVFSKJ2bVR6K
 rMQKcqdyIrTtVaw+/CurvM6KZJxOeIkSNLuK0jI3NP96viDhsGubHK4UfbiB92/HgVYxDdAYx
 BDmBhGvLr2bKlr5ycJVteEt9UjYISTQGHZgRQhQFURufyE1OxdHsK6W12a58UQnH9R0vrJ9eP
 6SNt4Sh2n2a7UuTUXpnNI2Ajwfc8KE2xFOa7u4HD/u+FHG/1fVjDAe30zSl0fV0lEXJU/eBrQ
 UqCkT4N69c5Jgxjcb00meLi6IUQp7nz00lSQ9tAJhVs98CiX9jq+qqrQ08NbOo/mIxKqMqXAa
 LAkk8p7606Tkh+9st1wk2QKY7Std6mo2K9pz71Sjg3C5mGnyvPR25TGflt8F7/9psL788w0GV
 WivYD4Azl+ppa8/slR357X0Rje2DrG1cIZUFA9j0pfCYSZYCmGcI7RESMK4LTuXgkNIM5YZhA
 gZ3t+CShfLcrQddv6APfixSQe2WnW5PJ8QjrqiukryDO2gc2tqKV+oigmCy9XtSMw4UyN7UcJ
 EcxCncwC1vExcf42Yzf8UoOc/l7xQjQRG3uQ85MDeBq+R2vSb0Q2iEZdsC2l47JwXXbP/N74i
 q07xvCARWZYyqYgqWotOyKJ/0Pyp4//RmdeCGZrlKZxi7FUmBLzmaYKIQXmHCDbxpkQD1IHA+
 uWac+NMx/ir1uh43MSwz72j8pQiYdJk7e+SoSM2S3ACO+orR5qUH4kf+RyBdkxrnL+dXSdi8e
 dhMABlIiiMgqYtzZvfmwSCUJ53c0SPlYAs5XMB9E3LjVqZAezG9oIIjFA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 08, 2022 at 03:32:35PM +0100, Philip Oakley wrote:
> I've unfortunately had some family issue which prevented me doing any wo=
rk.

That is sad to here. I hope that things are getting better in one way or a=
nother.

>
> If I haven't managed anything by the end of the week. I'd be happy if
> others took it forward.

I can certainly have a look, after the weekend, and continue your work.

