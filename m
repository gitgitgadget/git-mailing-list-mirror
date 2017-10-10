Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FAE420404
	for <e@80x24.org>; Tue, 10 Oct 2017 09:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756422AbdJJJfQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 05:35:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58776 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756258AbdJJJfG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 05:35:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF37CB2028;
        Tue, 10 Oct 2017 05:35:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pEdBj7W1Dxx51cWIKMtf2CXfXvc=; b=PmtxhR
        QpeRx/5jqocVQHXZf1ltYPH/jOfcBgImVjCjf978unqHnZDo6k6klbtZiHQ+uLaH
        A1+ZKMvQuA0q4Z282DkApjCTeGaHA9Um1yU2mQjiNMg6nUi/Z40KOfYQPSp0zJEz
        onOqvJz0zz/8Z9ISUf1bXcnxKty7HegofU4FY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UuAMuN6jaWqObAenm72mC6CiASyXTw0E
        Bx9zQGno0HPJW1gaZLFR3/n1e5zYtPVVrPaQtnlZw/1CkZ21MgfJoWWjNYOnFyXY
        lGGK6iLzkCoocOMpAwfrScItr0uj5UpLSrtviituO2bn1baG961YSqB7uZMllvDI
        n9i8+3DIR+g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E66DDB2025;
        Tue, 10 Oct 2017 05:35:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 64FA5B2024;
        Tue, 10 Oct 2017 05:35:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] for-each-ref: let upstream/push optionally report the remote name
References: <cover.1506952571.git.johannes.schindelin@gmx.de>
        <cover.1507205895.git.johannes.schindelin@gmx.de>
        <964525df50e6d35847bcf57b0fe0949c99f0dbca.1507205895.git.johannes.schindelin@gmx.de>
Date:   Tue, 10 Oct 2017 18:35:04 +0900
In-Reply-To: <964525df50e6d35847bcf57b0fe0949c99f0dbca.1507205895.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 5 Oct 2017 14:19:09 +0200
        (CEST)")
Message-ID: <xmqqlgkjpcqf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C47BAE0-AD9E-11E7-BC53-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> There are times when e.g. scripts want to know not only the name of the
> upstream branch on the remote repository, but also the name of the
> remote.
>
> This patch offers the new suffix :remotename for the upstream and for
> the push atoms, allowing to show exactly that. Example:
> ...
> 	$ git for-each-ref \
> 		--format='%(upstream) %(upstream:remote) %(push:remote)' \
> 		refs/heads/master
> 	refs/remotes/origin/master origin hello-world

While doing the regular re-review of the topics in flight, I noticed
that there are two references to :remote here that should be :remotename,
so I tweaked them locally and pushed the result out as part of 'pu'.

Thanks.
