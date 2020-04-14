Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5601FC2BA19
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 18:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23A1F20767
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 18:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DvVAupG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407736AbgDNSDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:03:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60655 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407731AbgDNSD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 14:03:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A8E25A0DE;
        Tue, 14 Apr 2020 14:03:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=M
        Ehh3rQ1H+IaE7grkmiFzXItoEA=; b=DvVAupG8KG4zF06rRlOzy25UFcc4fmLwR
        n9LfjnVD/oFHj/xFBdleA384Kwb6Uuv/xHNQKBga4YJpLc1KD5YimPC3uBgP1a/B
        d7wpmcYTv5rqf0ecxwLixipDvoBkBjUbDDi42G/5rQORfTwvdPqbvkhfsxAUmUit
        5MgxI4uIAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; q=dns; s=
        sasl; b=u4vW3YPEJbAAecXYGwa4it1h20mEgQi0a90ZT10snuVb/5WTRVBi5uTH
        TaJHWUzsRgii1xM7GjgtE9oZoyPzmowi8n7KrbytEcpIP4oweKaU5IstkSV1+j4B
        4Kh4sXAKFH3mmUysnRH8V18YgJT1uSSIBFOxSjcdZUR+ERnwhGU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 524895A0DD;
        Tue, 14 Apr 2020 14:03:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C33A45A0DC;
        Tue, 14 Apr 2020 14:03:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [Announce] Git v2.26.1 and others
Date:   Tue, 14 Apr 2020 11:03:23 -0700
Message-ID: <xmqqy2qy7xn8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B894D5E-7E7A-11EA-AF0D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Today, the Git project is releasing the following Git versions:

    v2.26.1, v2.25.3, v2.24.2, v2.23.2, v2.22.3, v2.21.2, v2.20.3,
    v2.19.4, v2.18.3, and v2.17.4

These releases address the security issue CVE-2020-5260, which
allowed a crafted URL to trick a Git client to send credential
information for a wrong host to the attacker's site.  Credit for
finding the vulnerability goes to Felix Wilhelm of Google Project
Zero, and credit for fixing it goes to Jeff King of GitHub.

Users of the affected maintenance tracks are urged to upgrade.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.26.1'
and other tags:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

Attached below is the release notes for 2.17.4; all the newer
maintenance tracks listed at the beginning of this message are
updated with the same fix, so I won't repeat them here.

Thanks.

--------------------------------------------------
Git v2.17.4 Release Notes
=========================

This release is to address the security issue: CVE-2020-5260

Fixes since v2.17.3
-------------------

 * With a crafted URL that contains a newline in it, the credential
   helper machinery can be fooled to give credential information for
   a wrong host.  The attack has been made impossible by forbidding
   a newline character in any value passed via the credential
   protocol.

Credit for finding the vulnerability goes to Felix Wilhelm of Google
Project Zero.
