Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F86C433EF
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 04:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiCREMq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 00:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiCREMp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 00:12:45 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24142B5EDD
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 21:11:27 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D100A12DF57;
        Fri, 18 Mar 2022 00:11:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=my43Q/xN6DYH36skzDrLqw7bA5kReYAdmOFKm/
        UKRQA=; b=cb6G2hM0STJrRTMAYxk5kDA6muvQTx7iUdV0+brtDDy3aKTi01RvUo
        ivXHnKwwIXeDNuTxJ05xy3jbgcQrU1FQSK96kxQ6PIh8TjslPqkmwV1eOOLQJxGv
        pw/j+ddoc/txT0OHPh74hXGUxvn3eOjaiIX5gxufTMWm9LhU9CpbQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C913512DF56;
        Fri, 18 Mar 2022 00:11:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4163212DF55;
        Fri, 18 Mar 2022 00:11:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
Cc:     git@vger.kernel.org
Subject: Re: how to automatically open conflicted files when "git rebase"
 encounter conflict
References: <bc7b04de-17be-df86-1c93-792903eeec9b@mails.ucas.ac.cn>
Date:   Thu, 17 Mar 2022 21:11:25 -0700
In-Reply-To: <bc7b04de-17be-df86-1c93-792903eeec9b@mails.ucas.ac.cn>
        (wuzhouhui's message of "Fri, 18 Mar 2022 10:00:52 +0800")
Message-ID: <xmqqtubvc32q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7AC40ED4-A671-11EC-BC71-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

wuzhouhui <wuzhouhui14@mails.ucas.ac.cn> writes:

> Hi
>
> When "git rebase" stopped due to conflict, I have to manually open
> conflicted
> file one by one and resolve conflict, and the typing file path is too
> boring.
> So, how to automatically open (e.g. use Vim) conflicted files?
>
> Thanks.

Perhaps take "git jump" from contrib/ and do

    $ GIT_EDITOR=vi git jump merge
