Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038AFC00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 17:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiHORd1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 13:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHORdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 13:33:25 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F88C237E4
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 10:33:25 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F2ED15669F;
        Mon, 15 Aug 2022 13:33:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IXmBYCaAoqi+++LI9WKciVFHUn2f9virm19j79
        HRaGE=; b=eg8LqK7IEN6KzOAVsbSmPKoc+ymvHSqQhBdWUU592l2PdR1BiMKwZa
        wpJU25/f7N77e0Sl/tnLMHf1ZHykgNTxX0kwQdrPdbic2XLtLyYfS4qf8fqZdm62
        bJI/3vobWzqgAbkgeq1/R01eAvaJZ24lug/+/sekAj0ru13bSn7qM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 574FF15669E;
        Mon, 15 Aug 2022 13:33:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BED1715669C;
        Mon, 15 Aug 2022 13:33:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v4] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
References: <pull.1317.v3.git.1660242752495.gitgitgadget@gmail.com>
        <pull.1317.v4.git.1660262231357.gitgitgadget@gmail.com>
        <47e86c2f-ab13-e8e6-8f69-0a79c3f4c343@jeffhostetler.com>
Date:   Mon, 15 Aug 2022 10:33:22 -0700
In-Reply-To: <47e86c2f-ab13-e8e6-8f69-0a79c3f4c343@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 15 Aug 2022 12:01:50 -0400")
Message-ID: <xmqq7d392yzh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D00787C-1CC0-11ED-8DCF-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 8/11/22 7:57 PM, Eric DeCosta via GitGitGadget wrote:
>> From: Eric DeCosta <edecosta@mathworks.com>
>> Though perhaps not common, there are uses cases where users have
>> large,
>> network-mounted repos. Having the ability to run fsmonitor against
>> network paths would benefit those users.
>> Most modern Samba-based filers have the necessary support to enable
>> fsmonitor on network-mounted repos. As a first step towards enabling
>> fsmonitor to work against network-mounted repos, introduce a
>> configuration option, 'fsmonitor.allowRemote'. Setting this option to
>> true will override the default behavior (erroring-out) when a
>> network-mounted repo is detected by fsmonitor.
>
> V4 LGTM.  Thanks for your persistence and attention to detail here.

Thanks, both.  Queued.
