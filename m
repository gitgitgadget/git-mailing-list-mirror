Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 611041F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 02:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbfJ2CFO (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 22:05:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56231 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfJ2CFO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 22:05:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C8372D24C;
        Mon, 28 Oct 2019 22:05:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nJD18Y2ZUncYRyp0/WiwkJZUabA=; b=uWnQh8
        ObprVCykhFLN2DqwG4eeUaU9gpGHvgwCaiuuGFCCxo4QpavWzwo2joszJlcl8n+9
        Qq9Rkgqg+uuRPmUCJI9BkgY8bTWTQDPagI73+B2xCbMRA6p1VkoMZBF9SLcOZIJY
        2ArdgeEhJBFtBcqopRteA+a9rLw87bhgTBu7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kqzK7a7smKCd6MURn1HkhBhMtSYL7tVC
        G5gUxUSVYwZtgaDtS3pf/Ln8956WQdUJRibDRJxhcinS/3FadROcqXsZIAGLe/I6
        KnrKh9teyrjUbhO8ZkLFXrSD3kdH1GH7K5Ort2Vd7xUHHoXUsryAmbmjddZu7yAj
        oZpuIeczuK0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1318F2D24B;
        Mon, 28 Oct 2019 22:05:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7B4D22D246;
        Mon, 28 Oct 2019 22:05:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 0/3] commit: fix advice for empty commits during rebases
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
        <xmqqr234i2q0.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910251402190.46@tvgsbejvaqbjf.bet>
Date:   Tue, 29 Oct 2019 11:05:10 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910251402190.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 25 Oct 2019 14:11:13 +0200 (CEST)")
Message-ID: <xmqq8sp48fxl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A0E8F70-F9F0-11E9-A0F3-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> As the bug was introduced in this cycle, I would like to see the bug fix
> in v2.24.0, though;...

Do you mean that before the change you blame for the "bug" things
worked better than what we have at the tip of 'master', or do you
mean that the change you blame for the "bug" changed the behaviour
relative to the previous released version but the updated behavior
is not what you consider correct?
