Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9460AC61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 18:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjBNSx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 13:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjBNSx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 13:53:57 -0500
X-Greylist: delayed 626 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Feb 2023 10:53:42 PST
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F1EAD06;
        Tue, 14 Feb 2023 10:53:42 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 31EIgeDb2023818
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 18:42:41 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>,
        <oss-security@lists.openwall.com>, <git-security@googlegroups.com>
References: <xmqqr0us5dio.fsf@gitster.g>
In-Reply-To: <xmqqr0us5dio.fsf@gitster.g>
Subject: RE: [Announce] Git 2.39.2 and friends
Date:   Tue, 14 Feb 2023 13:42:52 -0500
Organization: Nexbridge Inc.
Message-ID: <004a01d940a4$289e56a0$79db03e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGU4w09QxSlSb1LTh2rkB44/hmSy69XgIqw
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 14, 2023 1:05 PM, Junio C Hamano wrote:
>A maintenance release Git v2.39.2, together with releases for older
maintenance
>tracks v2.38.4, v2.37.6, v2.36.5, v2.35.7, v2.34.7, v2.33.7, v2.32.6,
v2.31.7, and
>v2.30.8, are now available at the usual places.
>
>These maintenance releases are to address two security issues identified as
CVE-
>2023-22490 and CVE-2023-23946.  They both affect ranges of existing
versions and
>users are strongly encouraged to upgrade.
>
>The tarballs are found at:
>
>    https://www.kernel.org/pub/software/scm/git/
>
>The following public repositories all have a copy of the 'v2.39.2'
>tag, as well as the tags for older maintenance tracks listed above.
>
>  url = https://git.kernel.org/pub/scm/git/git
>  url = https://kernel.googlesource.com/pub/scm/git/git
>  url = git://repo.or.cz/alt-git.git
>  url = https://github.com/gitster/git
>
>The addressed issues are:
>
> * CVE-2023-22490:
>
>   Using a specially-crafted repository, Git can be tricked into using
>   its local clone optimization even when using a non-local transport.
>   Though Git will abort local clones whose source $GIT_DIR/objects
>   directory contains symbolic links (c.f., CVE-2022-39253), the objects
>   directory itself may still be a symbolic link.
>
>   These two may be combined to include arbitrary files based on known
>   paths on the victim's filesystem within the malicious repository's
>   working copy, allowing for data exfiltration in a similar manner as
>   CVE-2022-39253.
>
> * CVE-2023-23946:
>
>   By feeding a crafted input to "git apply", a path outside the
>   working tree can be overwritten as the user who is running "git
>   apply".
>
>Credit for finding CVE-2023-22490 goes to yvvdwf, and the fix was developed
by
>Taylor Blau, with additional help from others on the Git security mailing
list.
>
>Credit for finding CVE-2023-23946 goes to Joern Schneeweisz, and the fix
was
>developed by Patrick Steinhardt.
>
>Johannes Schindelin helped greatly in packaging the whole thing and
proofreading
>the result.

NonStop build/test/package cycle has started for 2.39.2. If anyone needs one
of the friends built for this platform, please let me know.
--Randall

