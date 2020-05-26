Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167B0C433E0
	for <git@archiver.kernel.org>; Tue, 26 May 2020 09:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8615205CB
	for <git@archiver.kernel.org>; Tue, 26 May 2020 09:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbgEZJh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 05:37:29 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:10794 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728785AbgEZJh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 05:37:28 -0400
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
        by smtp6-g21.free.fr (Postfix) with ESMTP id A64BE780383
        for <git@vger.kernel.org>; Tue, 26 May 2020 11:36:57 +0200 (CEST)
Date:   Tue, 26 May 2020 11:36:57 +0200 (CEST)
From:   ydirson@free.fr
To:     git <git@vger.kernel.org>
Message-ID: <540830445.1034524732.1590485817611.JavaMail.root@zimbra39-e7>
In-Reply-To: <408624876.1034463388.1590484997966.JavaMail.root@zimbra39-e7>
Subject: [BUG] diff algorithm selection issue
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [91.170.159.152]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

When the config has diff.algorithm=patience set, "git diff --minimal" seems to
be ignored, and does not give the same output as "git diff --diff-algorithm=minimal",
but really the same as "git diff --diff-algorithm=patience".

See top commit on https://gitlab.com/ydirson/omaha/-/commits/bug/git-diff-minimal
where patience diff manages to show a quite braindead diff.

Also, I found it curious that in the manpage the long (--diff-algorithm=minimal) and
short (--minimal) forms are described with a copy-paste of the text, and no mention
of them being equivalent (or not, for that matter ;).
