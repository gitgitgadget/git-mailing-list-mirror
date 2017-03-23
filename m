Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC6A120958
	for <e@80x24.org>; Thu, 23 Mar 2017 18:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935525AbdCWSPx (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 14:15:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60896 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934568AbdCWSPx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 14:15:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71BE08B7F3;
        Thu, 23 Mar 2017 14:15:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=60r9AYShvZzC9oFZOrc1QjxwG9s=; b=ntANqo
        UvqeMI97s64+p5yvaYxQkmEXW0AY/bvZZFSU9jGNzFwQvYWUjMXZTo3LH8pLkuUG
        0TSqqzJQ+KIMlkRm3oZnRJ2oXsJID/w/4m+zbcy4WmlXSZHgm2t260LwGqP1f1aA
        RKXpF76MGBphvY1flB0jtotc2oBiniwI3zUqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Pg2LnJwukCfLBXdjZ5KNp+5Es6EYWIbV
        16JRjiCQJYA3qVva7hl6za/208MZmDTA53l4m2hd8efYcbQG5pxe+s5+zOdV5mE5
        tLb6bkUu7gVVuSswZpDsaYhs6bsdgZMC/FDjSUqWOjfpHf9cbFARsa0JsXX903NE
        zSvGqWQkVlE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68E848B7F2;
        Thu, 23 Mar 2017 14:15:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D073D8B7F1;
        Thu, 23 Mar 2017 14:15:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ulrik Sverdrup <ulrik.sverdrup@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug: Revert with -m 0 says no -m was given
References: <12e6fae3-a341-3dcd-0920-c3df2d54d0a8@gmail.com>
Date:   Thu, 23 Mar 2017 11:15:49 -0700
In-Reply-To: <12e6fae3-a341-3dcd-0920-c3df2d54d0a8@gmail.com> (Ulrik
        Sverdrup's message of "Thu, 23 Mar 2017 18:17:40 +0100")
Message-ID: <xmqq4lyjeu5m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BEFB6480-0FF4-11E7-B41D-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ulrik Sverdrup <ulrik.sverdrup@gmail.com> writes:

> Git produces a misleading error when you tell it `git revert -m 0`.

Thanks.  

I think this is the same issue as the one with 'cherry-pick' that
was reported earlier.  We have a fix in the 'master' branch already;
please try it out.



