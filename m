Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBB2720958
	for <e@80x24.org>; Mon, 20 Mar 2017 18:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932485AbdCTSNw (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 14:13:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64452 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932477AbdCTSNO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 14:13:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF0E97E106;
        Mon, 20 Mar 2017 14:12:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8NoPnCsHhJae6ga0bWsPq8DULBA=; b=ppgMOw
        6DtuWupSnj76jRghWaljKY2TB1wTez2G7dlOm4VfolqH52/JMMFb3KIgvp9PQxX3
        7TUNvGp5GdfocFR05gWbL4F0SOyGybwffeSrmeP2n+awDY3ZUVJtFLCB9cYLWVMr
        LhhLN4j0bcsWA6sVo1YRxRu06TtnEmPiC+htQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TreL9f8GYVx20UPMd9Uv5UEWlTLaWFdn
        yV7FsZFDXrdZuO8sV4Rkt8H5x0cXwxSus3imTey/qK75LCSvTgQlUNtnctunqd+w
        qSXTbBHFbgqzsFE+Wqo7R3M9YdyL0/ezeB8XwjS4Qs8ezJvEN8ji54ejLI2SrH5/
        56lynGQpSyY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7E197E105;
        Mon, 20 Mar 2017 14:12:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2BA2E7E104;
        Mon, 20 Mar 2017 14:12:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation/git-worktree: use working tree for trees on the file system
References: <20170317222842.GP26789@aiede.mtv.corp.google.com>
        <20170317225110.13417-1-sbeller@google.com>
        <xmqq60j75psk.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kayeSxFTJr3Q1atFgOyR74PzQyCLiejuZxh7+wTGGb=ww@mail.gmail.com>
Date:   Mon, 20 Mar 2017 11:12:37 -0700
In-Reply-To: <CAGZ79kayeSxFTJr3Q1atFgOyR74PzQyCLiejuZxh7+wTGGb=ww@mail.gmail.com>
        (Stefan Beller's message of "Mon, 20 Mar 2017 10:29:56 -0700")
Message-ID: <xmqqbmsvx1ey.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD7E8C5C-0D98-11E7-A7B8-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> While it may be true that you can have bare worktrees; I would question
> why anyone wants to do this, as the only thing it provides is an
> additional HEAD (plus its reflog).

A more plausible situation is you start with a bare one as the
primary and used to make local clones to do your work in the world
before "git worktree".  It would be a natural extension to your
workflow to instead create worktrees of of that bare one as the
primary worktree with secondaries with working trees.
