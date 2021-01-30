Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2376EC433E0
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 01:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE2F064E02
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 01:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhA3BdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 20:33:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52085 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbhA3B33 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 20:29:29 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5B0510637E;
        Fri, 29 Jan 2021 20:28:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a/Tip7BBNCtOlo9LHodyJNKDIRM=; b=Q2qawX
        qoAzwuT2WJGIlWB274fTgph5kYAXQKRAIHG3mo7YqPIj5VuzHdPKVHLj8w90bG8Y
        FF1p9eYhVvoyQ8eUYRPhf5z+oidylOl63wtIenAd3itae3w94dWV1ak90UsLXpe7
        kURMzzCGF3zGbG1Ic9ZwTVDG9kJoPmwWEMaf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rwRdZ9gdKlSMx2qVT8TsyV5mnABWKSp5
        22pLL+nNvsK0OY0Mn3vIcQmIqoa2GvM3RH07iRl9YsF6y/9FuAzcharlnncsFyad
        TxEHOQ6//5aJZhdStmVn+BnOe97KFNyNLqWrYl1GTTCGBgPib8EyT7YxAIyl1fI1
        Bt8PwZT+650=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE9DF10637D;
        Fri, 29 Jan 2021 20:28:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A6F1D10637B;
        Fri, 29 Jan 2021 20:28:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v2 0/3] Unify trailers formatting logic for pretty.c and
 ref-filter.c
References: <pull.726.git.1599335291.gitgitgadget@gmail.com>
        <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
Date:   Fri, 29 Jan 2021 17:28:25 -0800
In-Reply-To: <pull.726.v2.git.1611954543.gitgitgadget@gmail.com> (Hariom Verma
        via GitGitGadget's message of "Fri, 29 Jan 2021 21:09:00 +0000")
Message-ID: <xmqqft2jqkli.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 737C8032-629A-11EB-8114-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With this queued directly on top of master, I am getting these
failures.

t6300-for-each-ref.sh                            (Wstat: 256 Tests: 301 Failed: 6)
  Failed tests:  277-280, 285, 287
  Non-zero exit status: 1

