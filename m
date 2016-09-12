Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB415207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 18:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757281AbcILS6o (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 14:58:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59186 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753014AbcILS6n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 14:58:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1FFB3BD82;
        Mon, 12 Sep 2016 14:58:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IlZKHZcXmSLG6aOpPNNar3EsZTw=; b=CFT9u7
        amu8Q9Vg1F0cJOG26AM2RSZK4Ad+2QakXYwLIB2YccJMzk+4uPfEQWu+UWdJ29k+
        DaGPlMfIEuua2PAbC7eNB8AY7mTWNnskWyUDsHltCP24BxxZXWWcVCZgVXxQVnZ+
        kFGeKzUs+cB/NMYAmMYqLG9oGG5NSC8LYh7yI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TcXjyWocfv/CiC4QDE6K6EqQHeEV3bBq
        El0+HAdic5TimPQbSeM7AfFDjIBqLjz0fP92/GttkLa0dNq2z+gJUfMftY07kjnz
        tIpCJh9N6Ze4FDIRfnb42dycDF2t1Xzjl11FxUC/uhIh81CP1YFPqmYfwZfopBmO
        n0jNt94b9UE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A7DF3BD81;
        Mon, 12 Sep 2016 14:58:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2B5503BD80;
        Mon, 12 Sep 2016 14:58:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/5] Make the require_clean_work_tree() function truly reusable
References: <cover.1472137582.git.johannes.schindelin@gmx.de>
        <cover.1473580914.git.johannes.schindelin@gmx.de>
        <0e1ec34e45fea5bae60e65f316072cb2c89b024a.1473580914.git.johannes.schindelin@gmx.de>
Date:   Mon, 12 Sep 2016 11:58:40 -0700
In-Reply-To: <0e1ec34e45fea5bae60e65f316072cb2c89b024a.1473580914.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Sun, 11 Sep 2016 10:02:47 +0200
        (CEST)")
Message-ID: <xmqqpoo92bdr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC4C6FA4-791A-11E6-9ACC-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> It is remarkable that libgit.a did not sport this function yet... Let's
> move it into a more prominent (and into an actually reusable) spot:
> wt-status.[ch].
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

I do not think "truly" is needed at all.

It was not reusable.  It is somewhat reusable after this patch.  It
may or may not be "truly" reusable depending on the need of future
patches, which we do not know yet.

I agree wt-status.[ch] is a good home for this feature.

Thanks.
