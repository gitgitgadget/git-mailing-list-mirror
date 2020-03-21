Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A539C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 21:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351B520775
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 21:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lmAlC3BE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCUVhw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 17:37:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56649 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgCUVhw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 17:37:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6D76EC0CB7;
        Sat, 21 Mar 2020 17:37:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=8
        Zq67PKE6204gcdJKpGwI/1d3kw=; b=lmAlC3BE5sAOVrVByQsIpFY4AnAIBPQJg
        r6dECoijDBftqk6g6IZ6g4qMFnCyTajQ9CJf5TGxY7gNEI7bpow9c50plZvMLTIB
        Aubfg1xFOAGy8/Qt8iQDlYNOH/cjDho/SWiXEZgCDHBYCZZvX/YEqwCJz0H2xQcd
        qXaJwjXjVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=FLG
        4SV0bfbS9z+zeYy7SnmGx0lafGxBTcUfnNwW+M3n/Hgaldv76Uu//1YVw94Y8Jmm
        sJYJqdB81HHwpS955X+1mLjcguMuUdAip4Pbw2OtO4WMpYGcgpT9sB1YADGHSQnJ
        nKsD2pAbL5e4pfAJmnWfL6JYu+qGOrWBMHcNQDws=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 657B2C0CB6;
        Sat, 21 Mar 2020 17:37:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5CB72C0CB4;
        Sat, 21 Mar 2020 17:37:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: macOS builds having trouble at travis-ci.org?
Date:   Sat, 21 Mar 2020 14:37:44 -0700
Message-ID: <xmqqlfnt8k47.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34507C04-6BBC-11EA-A042-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Starting sometime yeserday, it appears that macOS builds of our
branches at travis-ci.org are having trouble in an undiagnosable
way.  All you see on their webpage is a helpful message "An error
occurred while generating the build script." and nothing else.

https://travis-ci.org/github/git/git/builds/665032524 was the first
such failed build of 'pu'.

Curiously, a job that was submitted later for an updated 'pu', which
was https://travis-ci.org/github/git/git/builds/665061157, did not
exhibit the symptom.  Anyway, that 1157 build was a one-off and
since then macOS builds are failing all branches consistently.

For now, I'll write macOS build at travis-ci off as not giving any
useful information and move on, but it would be nice to get it
corrected, and I am assuming that it is not something we did
recently.

Just FYI.
