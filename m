Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54B1020986
	for <e@80x24.org>; Tue,  4 Oct 2016 22:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751527AbcJDWyy (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 18:54:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55838 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751201AbcJDWyx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 18:54:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4319244BE7;
        Tue,  4 Oct 2016 18:54:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=69j+
        TQt76iuXQ5M47Lvr69we6y0=; b=UO3YuvTTVbfrBC/IE+cCfif1mVZ7YKm43iQm
        zqN8miQ63TvFzSmDeeBUUfyVU+JsVpZj6ELcNU31AOtUxzyFxXLF7stHbWJEys9+
        ZJo0F2k6W0d3G5PHLWjc/FZSuHarr/GjuVHlEToKvcZJ4a/7+1eaxrlCPxKmFlJq
        1ZfXmHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        JIfXZRMwKgTROMY2e9Y2owYF61X4RpQ+eMgQNPY3EWUTfgWMn08FMP8VR8OY03cl
        KpJ5loyBRmZkEJR2vyBqRTpwoJmOQEjFQPxKOSDcRV8mNtJVSivU21UWqXd7vYfa
        igElrnebKphMRz7V1z7PTdISebFLEjwZnYuWosz6rZo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39FE344BE6;
        Tue,  4 Oct 2016 18:54:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A9AEF44BE5;
        Tue,  4 Oct 2016 18:54:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, strk@kbt.io
Subject: [PATCH 0/4] diff.wsErrorHighlight configuration variable
Date:   Tue,  4 Oct 2016 15:54:45 -0700
Message-Id: <20161004225449.6759-1-gitster@pobox.com>
X-Mailer: git-send-email 2.10.1-510-g1ef781f2c1
In-Reply-To: <xmqqk2douhe0.fsf@gitster.mtv.corp.google.com>
References: <xmqqk2douhe0.fsf@gitster.mtv.corp.google.com>
X-Pobox-Relay-ID: 8F137BDA-8A85-11E6-A6E1-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git diff" and its family of commands have "--ws-error-highlight"
option to allow whitespace breakages on old and context lines
painted in color.diff.whitespace color, instead of the usual "we
paint breakages only on new lines", but there wasn't a configuration
variable that corresponds to it.

This would be a lot closer to a series that could be acceptable,
compared to the previous "it should look like this" patch.

Junio C Hamano (4):
  t4015: split out the "setup" part of ws-error-highlight test
  diff.c: refactor parse_ws_error_highlight()
  diff.c: move ws-error-highlight parsing helpers up
  diff: introduce diff.wsErrorHighlight option

 Documentation/diff-config.txt  |  6 +++
 Documentation/diff-options.txt |  2 +
 diff.c                         | 88 ++++++++++++++++++++++++++----------------
 t/t4015-diff-whitespace.sh     | 74 ++++++++++++++++++++++++++---------
 4 files changed, 118 insertions(+), 52 deletions(-)

-- 
2.10.1-510-g1ef781f2c1

