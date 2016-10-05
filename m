Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC1191F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 17:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934123AbcJERnp (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 13:43:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50310 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934111AbcJERnm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 13:43:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0865B42A1B;
        Wed,  5 Oct 2016 13:43:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GeIX81v+BFfjeg65Ui4D1RvJ2Zg=; b=aDwHXk
        lmNWyrg8vei+QL6k3JBFE8QL94iULj77khORVtCafpKHIKcG1zPE+Pc7w0aTfr+t
        9R0wls7Sm4Pg75YKzHX2/Ny9bsJmUDuWTpdmgEq7Hryak9rv9iCf8WYiu+yH2EqJ
        fp6rhQ3ZoBnUAX/7v+wcjl25+OqvzbzpHvdoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nstjzpjG8BByQg6N7trkZgCGrc5sdE+L
        0mlfcxmYsfYfU9sDIKWj8OVsRUu98LE8vMvyeqwwnEq7vfOt12Cgqh/WKX7d0+QA
        OF1kWxSSVFMGYLX363jveFXm+vVN6xp4Lxsz1jYrHsFxSYtnUV/qyWX0a6Xi4Ybp
        KSSyj2gvLxQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 003E542A1A;
        Wed,  5 Oct 2016 13:43:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6FA1842A19;
        Wed,  5 Oct 2016 13:43:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 19/25] sequencer: remember do_recursive_merge()'s return value
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <cover.1473590966.git.johannes.schindelin@gmx.de>
        <44c455710fd9c420a3f759d021c4864f3a83c97a.1473590966.git.johannes.schindelin@gmx.de>
        <xmqqh99kzua9.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610051348020.35196@virtualbox>
Date:   Wed, 05 Oct 2016 10:43:38 -0700
In-Reply-To: <alpine.DEB.2.20.1610051348020.35196@virtualbox> (Johannes
        Schindelin's message of "Wed, 5 Oct 2016 14:35:50 +0200 (CEST)")
Message-ID: <xmqqmviipu7p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4090550C-8B23-11E6-AFCF-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Actually, come to think of it, I will change the patch, as it is too
> confusing. What I want is to preserve a positive return value in case of
> merge conflicts, and that is exactly what I should do instead of playing
> games with the Boolean OR operator.

That would be good; that was exactly the confusion I felt that led
to my comments.
