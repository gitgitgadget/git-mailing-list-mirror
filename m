Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C7BC432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 04:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC1222463
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 04:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xi7RnzeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfKTERr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 23:17:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54337 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfKTERr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 23:17:47 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E9D02A669;
        Tue, 19 Nov 2019 23:17:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t3xEsQiIprcT+oNnWTRQChIn8iE=; b=xi7Rnz
        eLQWALbGNTaxUqRzSdpCDhAb7zXx6KBgHPe8RNa1H/ZKRK6o9rXYIjSYqBErRlG2
        /h7TVX/CNuCJP1Sr28RC45daV96zi1duOUnlq1Dk1a91wi6tOZTTXuPxH33Hjxox
        5gLD70pOJ7cTYhTZFMd80J6f5HUzglizWiwgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w9I+khQO5/2aZzAOzyRS2ceTssARS3Xl
        xWViEIHtzIEBDjTV91dZBdIRpVHK3m8+SsgX+6zsUUUrWB2lbAbFNQSDqA1B3MMK
        Fk1sIHSw+tbBosENBsth1oCrvrO3pLHxtOeOjU2Ndv1KDAi6rT+hI75bC6KtiNP7
        IdW9PEwOAdM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 14AE22A668;
        Tue, 19 Nov 2019 23:17:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 74F7B2A667;
        Tue, 19 Nov 2019 23:17:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 5/8] t3206: demonstrate current notes behavior
References: <cover.1574125554.git.liu.denton@gmail.com>
        <cover.1574207673.git.liu.denton@gmail.com>
        <4cf7d39fe342a1f140598f09369afaf785358aa5.1574207673.git.liu.denton@gmail.com>
Date:   Wed, 20 Nov 2019 13:17:43 +0900
In-Reply-To: <4cf7d39fe342a1f140598f09369afaf785358aa5.1574207673.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 19 Nov 2019 15:55:39 -0800")
Message-ID: <xmqq1ru3chaw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B37DC1EC-0B4C-11EA-8FBE-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Subject: Re: [PATCH v2 5/8] t3206: demonstrate current notes behavior

This makes it sound as if "current" is either bad or stale and will
be "fixed".  In the previous round that might have been your
intention, but I do not think the focus of v2 is that, so phrasing
may want to be updated, perhaps like

    t3206: range-diff compares log message with commit notes

or something.

> The test suite had a blindspot where it did not check the behavior of
> range-diff and format-patch when notes were present. Cover this
> blindspot.

Good description.
