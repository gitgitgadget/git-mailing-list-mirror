Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 631821F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 22:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941987AbcJEWlL (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 18:41:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52380 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932225AbcJEWlK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 18:41:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 24BC344EB7;
        Wed,  5 Oct 2016 18:41:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YXCVxIdylWxraYeA3sFci1Eu50w=; b=V/0Npu
        6blKfrj3UbJTKJTKLtapJnYjikc17coPO6DiFuvQqvudxHLtPLNWeb+tvGPcyJEE
        oY+6m/rAH4VYAGrVsGHEdR6cUCVaC8LWyGnGtm6fonN6zPBU6N0lcsO6S576itNk
        PNQYF+dGl5ls1aJA0OaQjjrXH+JqO2/fxPbsY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I1cJi7bHDkxd7++RnB2m7DtoI8AWXJeY
        t4Cn0mWbTGx5BOilEPPf86bsr9JPTgtzitD2au+oG6J+Ky6LXFkJo7LQYCzefq5v
        inFfSz33oZlTWnuliraC0LzCOO9qZUx7q781ig7oPBxjLpCTubxtmFzm1Mqcg/Fk
        L7YDmJJA+8w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D71444EB6;
        Wed,  5 Oct 2016 18:41:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9324544EB4;
        Wed,  5 Oct 2016 18:41:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        Jakub =?utf-8?Q?Na?= =?utf-8?Q?r=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3 05/14] i18n: add--interactive: mark plural strings
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
        <20161005172110.30801-6-vascomalmeida@sapo.pt>
Date:   Wed, 05 Oct 2016 15:41:06 -0700
In-Reply-To: <20161005172110.30801-6-vascomalmeida@sapo.pt> (Vasco Almeida's
        message of "Wed, 5 Oct 2016 17:21:01 +0000")
Message-ID: <xmqqoa2ymnb1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CEED0C22-8B4C-11E6-8D70-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> @@ -70,6 +72,8 @@ Git::I18N - Perl interface to Git's Gettext localizations
>  
>  	printf __("The following error occurred: %s\n"), $error;
>  
> +	printf __n("commited %d file", "commited %d files", $files), $files;
> +

A micronit: the existing example above prints a whole line,
i.e. terminated with a LF.  The new one probably should match.
