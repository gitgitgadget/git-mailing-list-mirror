Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DD7C0044D
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 02:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50292071C
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 02:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgCOCMW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:12:22 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:34202 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgCOCMW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Mar 2020 22:12:22 -0400
Received: from relay11.mail.gandi.net (unknown [217.70.178.231])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 6CEFC3A7B7B
        for <git@vger.kernel.org>; Sat, 14 Mar 2020 17:26:31 +0000 (UTC)
Received: from localhost (unknown [103.227.98.14])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 5A52D100005;
        Sat, 14 Mar 2020 17:26:03 +0000 (UTC)
Date:   Sat, 14 Mar 2020 22:56:00 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Bonanomi <lbonanomi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-gui--askpass: coerce answers to UTF-8 on Windows
Message-ID: <20200314172600.a6nrm7h3pdzshdv2@yadavpratyush.com>
References: <pull.578.git.1583954676691.gitgitgadget@gmail.com>
 <pull.578.v2.git.1584048710895.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.578.v2.git.1584048710895.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/03/20 09:31PM, Johannes Schindelin via GitGitGadget wrote:
> From: Luke Bonanomi <lbonanomi@gmail.com>
> 
> This addresses the issue where Git for Windows asks the user for a
> password, no credential helper is available, and then Git fails to pick
> up non-ASCII characters from the Git GUI helper.
> 
> This can be verified e.g. via
> 
> 	echo host=http://abc.com |
> 	git -c credential.helper= credential fill
> 
> and then pasting some umlauts.
> 
> The underlying reason is that Git for Windows tries to communicate using
> the UTF-8 encoding no matter what the actual current code page is. So
> let's indulge Git for Windows and do use that encoding.
> 
> This fixes https://github.com/git-for-windows/git/issues/2215
> 
> Signed-off-by: Luke Bonanomi <lbonanomi@gmail.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Merged. Thanks all.

-- 
Regards,
Pratyush Yadav
