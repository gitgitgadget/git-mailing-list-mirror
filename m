Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528F6C54FD2
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 18:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36B5B206F6
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 18:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="e+KqGoh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgDTSDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:03:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54850 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgDTSC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 14:02:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A59358684;
        Mon, 20 Apr 2020 14:02:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=5
        /t2mZ2OggptjGQAf2Ltk7M1B2Q=; b=e+KqGoh7XLDhKCXPlvNEnKDhiHuAP1t1t
        ZruXeOvXVzSJGCDCPhWr/SCYcLkk4xNywcbgM8lTWNE53BNoJOBGG9eS6f8S9B5u
        J5mIcLuPeXuFmbSzDrRbKcS5+Wn+NLECGZoAzAx3n6IwXrwaVUIHL5XFdl3TMNUq
        0aHLMQYafc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; q=dns; s=
        sasl; b=bUMkgWtWh6f+TVF8AcTXLpRL5EWVRlBCjAcyn9mKN8xa8AexPJxQUi9i
        R9x1Ff9jJxmYCac/PVgSexkF+p/0DMyNXgDuF3FNfZoEIgL3HBL54iT4+A3I8htl
        WbP7HUV4TTgHVegc+2zEsyiiAD+wTy6tYLyivMUQgn56BQDGd44=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2299058683;
        Mon, 20 Apr 2020 14:02:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A6C0F58682;
        Mon, 20 Apr 2020 14:02:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [Announce] Git v2.26.2 and others
Date:   Mon, 20 Apr 2020 11:02:55 -0700
Message-ID: <xmqq4kterq5s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29411F08-8331-11EA-AA50-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Today, the Git project is releasing the following Git versions:

    v2.26.2, v2.25.4, v2.24.3, v2.23.3, v2.22.4, v2.21.3, v2.20.4,
    v2.19.5, v2.18.4, and v2.17.5.

These releases address the security issue CVE-2020-11008, which is
similar to the recently addressed CVE-2020-5260.

Users of the affected maintenance tracks are urged to upgrade.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.26.2'
and other tags:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

Attached below is the release notes for 2.17.5; all the newer
maintenance tracks listed at the beginning of this message are
updated with the same fix, so I won't repeat them here.

Thanks.

--------------------------------------------------
Git v2.17.5 Release Notes
=========================

This release is to address a security issue: CVE-2020-11008

Fixes since v2.17.4
-------------------

 * With a crafted URL that contains a newline or empty host, or lacks
   a scheme, the credential helper machinery can be fooled into
   providing credential information that is not appropriate for the
   protocol in use and host being contacted.

   Unlike the vulnerability CVE-2020-5260 fixed in v2.17.4, the
   credentials are not for a host of the attacker's choosing; instead,
   they are for some unspecified host (based on how the configured
   credential helper handles an absent "host" parameter).

   The attack has been made impossible by refusing to work with
   under-specified credential patterns.

Credit for finding the vulnerability goes to Carlo Arenas.
