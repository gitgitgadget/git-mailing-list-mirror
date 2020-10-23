Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5B3C55179
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0195221527
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a/BGi96Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750578AbgJWOa0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 10:30:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61887 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370692AbgJWOa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 10:30:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E950989A1A;
        Fri, 23 Oct 2020 10:30:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=t
        t5+BrDSPhAtDayJ8zzkJFyDTEA=; b=a/BGi96ZSarOgWEoSgbvTvEfxyNSY10Vl
        nrvzXeUSWJc0WDl9tMKfO43xcKpbd6pc4wgiCYUBwQ7+4e4h1M5X6ksrehH7/mtF
        Baau/ASVn0uDZdsrK1FmxiZIbnpYgeMGOojB17I5GrEdE3Wr3qhSWJhorLZmK57i
        6kW8+ZcSjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; q=dns; s=
        sasl; b=xgr3BW7rEJYA1aMYUxlEtWFVYXfU1lNz2ojsc9ncmQoY+bed06DFNuBA
        aubyblKG/XPRlVT57a7XKZpVz1ysC4owBDwPhDqKU2uzodIWa8es1ay5bK/MxlBu
        368YweIlslavV5Z7vatOD5GiJeZZomc4KSlk+cyau2uj8mV+H+E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1B5589A18;
        Fri, 23 Oct 2020 10:30:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D70F89A17;
        Fri, 23 Oct 2020 10:30:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.29.1
Date:   Fri, 23 Oct 2020 07:30:22 -0700
Message-ID: <xmqq4kmlj9q9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4929F52C-153C-11EB-9BE6-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.29.1 is now available at
the usual places.

The change in this release affects only those who build from the
source *and* install with a non-standard SKIP_DASHED_BUILT_INS
option turned on.  With the option turned on, Git 2.29 forgot to
install a few programs in /usr/bin that made it unusable as the
server side to accept pushes and fetches.

To everybody else, this release is irrelevant and ignorable.  We
know about at least one other brown-paper-bag regression we are
going to fix with another maintenance release, so it may be a better
idea to wait for 2.29.2 for most people.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.29.1'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.29.1 Release Notes
=========================

This is to fix the build procedure change in 2.29 where we failed
to install a few programs that should be installed in /usr/bin
(namely, receive-pack, upload-archive and upload-pack) when the
non-default SKIP_DASHED_BUILT_INS installation option is in effect.

A minor glitch in a non-default installation may usually not deserve
a hotfix, but I think Git for Windows ship binaries built with this
option, so let's make an exception.

----------------------------------------------------------------

Changes since v2.29.0 are as follows:

Johannes Schindelin (1):
      SKIP_DASHED_BUILT_INS: do not skip the bin/ programs

Junio C Hamano (1):
      Git 2.29.1

