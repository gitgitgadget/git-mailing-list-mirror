Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3FC61F404
	for <e@80x24.org>; Tue, 16 Jan 2018 19:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751693AbeAPTcp (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 14:32:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65415 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeAPTco (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 14:32:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC9F5CD5B7;
        Tue, 16 Jan 2018 14:32:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tPugntVks4duSBfide1dWF3p3dY=; b=u6NBYA
        kLbM20eeqgmeUzlRefinq/p+X9exuX9VbDQec8FugaLE8mXULNJ3XHnPQQM62vhu
        akT284LCxEl7fRRPgaqj6rpzbr4yrgYDu5fEY81c1iYi70XEwC9+cST7R/M2AP7b
        SQJefrduVwH+5k3/P2djIJaF0NhRknbv00J/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tiB/Oq0cojWdAuOA9nppu0+iI7eFjQpg
        6k9e8OjI1qjKYyOiZ5Mua57CLfSsTD5P5iosEkjE/Xgb7A7Wrc4z1J33SBqsOQTG
        PvI7wlWIouwjC3qDQOs1j2VZhqSn7DGi0BHtqAJ1fn9HLTVZzZN7LMwottmuQceT
        eeq3JvRx/zU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4CF8CD5B6;
        Tue, 16 Jan 2018 14:32:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 242A0CD5B5;
        Tue, 16 Jan 2018 14:32:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 0/2] Incremental rewrite of git-submodules
References: <20180111201721.25930-1-pc44800@gmail.com>
        <20180114211529.6391-1-pc44800@gmail.com>
Date:   Tue, 16 Jan 2018 11:32:41 -0800
In-Reply-To: <20180114211529.6391-1-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Mon, 15 Jan 2018 02:45:27 +0530")
Message-ID: <xmqq4lnlvbty.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05A34AAC-FAF4-11E7-80B7-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

> Changes in v3:
>
> * For the variables: super_config_url and sub_origin_url, xstrdup() was used
>   while assigning "" to them, before freeing.
>
> * In case of the function deinit_submodule, since the orignal code doesn't die
>   upon failure of the function mkdir(), printf was used instead of die_errno.
>
> As before you can find this series at:
> https://github.com/pratham-pc/git/commits/patch-series-2
>
> And its build report is available at:
> https://travis-ci.org/pratham-pc/git/builds/
> Branch: patch-series-2
> Build #197
>
> Prathamesh Chavan (2):
>   submodule: port submodule subcommand 'sync' from shell to C
>   submodule: port submodule subcommand 'deinit' from shell to C
>
>  builtin/submodule--helper.c | 340 ++++++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            | 112 +--------------
>  2 files changed, 342 insertions(+), 110 deletions(-)

Looks sensible.  Thanks.

