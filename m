Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32163C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 17:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E38C321556
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 17:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgKCRYy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 12:24:54 -0500
Received: from psionic.psi5.com ([212.83.56.200]:46836 "EHLO psionic.psi5.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728833AbgKCRYk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 12:24:40 -0500
X-Greylist: delayed 499 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Nov 2020 12:24:39 EST
Received: by psionic.psi5.com (Postfix, from userid 1002)
        id 7273FE029B; Tue,  3 Nov 2020 18:16:18 +0100 (CET)
Date:   Tue, 3 Nov 2020 18:16:18 +0100
From:   Simon Richter <Simon.Richter@hogyros.de>
To:     git@vger.kernel.org
Subject: Regression: cannot edit after intent-to-add
Message-ID: <20201103171618.GA28810@psi5.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I often create intermediate commits using hunk editing, which used to work
in older versions even for new files, e.g.

    cat >file <<EOF
    foo
    bar
    EOF

    git add -N file

    git add -p file

git-add -p now shows me both lines as added, but does not allow me to edit.
If I want to create an intermediate commit adding just one of the lines, I
have to edit the actual file.

This used to work in older versions, as I remember using this technique for
a while and recommending it to others.

Before I do a deep-dive into a codebase I haven't looked at in years: can
this be re-added easily?

   Simon
