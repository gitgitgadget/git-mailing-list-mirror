Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B0DE207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 23:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbcI3X2w (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 19:28:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64258 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751677AbcI3X2v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 19:28:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6495843539;
        Fri, 30 Sep 2016 19:28:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VK/ZtPBqM7x4yB3z9mYX8AbYPxA=; b=YIEQ2f
        AWf3+EikIaYGDWU3gZ6D9+NOmAq9aZ7SzaDE6cbmt+cP1SVTLRrJxT+7jUcHefxc
        5wzGBh6bWmbhE4N8RdknYv/Nb1BcHx1l8haUH5r9WmYtQwVLQOvK3viF6PweBOw0
        roXTN6rPn2uDvo9LLqgnPBEatpKZp+tKjlMIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K1WU6DkXzZxDpa+RiC2ORpzBh9nF/2ay
        2bHkpXWsOj/N9RcU7Td0ohninmZcGYbqcNwJwoN/Ejrdzza0zBlQ7IgpcSHdJnBe
        z/6Aax59HNRVbkajgSg+amMBvkD1m7lxai6WCCNweOxoi32GAVeRLp5gmQBYTtZr
        4ZQ9UGxJPis=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5180343537;
        Fri, 30 Sep 2016 19:28:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD71443535;
        Fri, 30 Sep 2016 19:28:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org
Subject: Re: [PATCH v3 0/5] Add --format to tag verification
References: <20160930221806.3398-1-santiago@nyu.edu>
Date:   Fri, 30 Sep 2016 16:28:47 -0700
In-Reply-To: <20160930221806.3398-1-santiago@nyu.edu> (santiago@nyu.edu's
        message of "Fri, 30 Sep 2016 18:18:01 -0400")
Message-ID: <xmqqlgy97ys0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A44166CA-8765-11E6-9DFB-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What is in the patch series looked more or less good to me.  Lukas's
sirname was still P in [3/5], a patch in [4/5] added an unnecssary
blank line before git_verify_tag_config() and also a local variable
declaration for "char *fmt_pretty" was indented funnily, but none of
these were something I couldn't fix up locally.

I however notice that there is no new tests to protect these two new
features from future breakages.  Perhaps you want to add some in
[6/5]?

Thanks.



