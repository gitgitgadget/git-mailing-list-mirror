Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27EA61F463
	for <e@80x24.org>; Mon, 16 Sep 2019 17:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388106AbfIPRnc (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 13:43:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50379 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfIPRnc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 13:43:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 19265262F3;
        Mon, 16 Sep 2019 13:43:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eejo8gPEOdbhsdBWneABxSJi4JE=; b=D0IOX8
        SwscGqjbEsNvVt6SXVL+/XDUWkoxYjddnX8tb1HSRrYUIgOPkgKgBzysa1IuKZ8G
        9ThtCNBCIkKl8K7V3YMiaTMcfIHNc3KJ1OvgROZaiJmzBB9/PpoDj9/FAsTgXShM
        NORME2bughFvLkYB4HVj81hvOhUbz2GB6c1RI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Mq/WKBDciyH0/YqVxCGYgju1q/lw8Ezg
        1IlfvC0gHPvhFWu2CHQHquh7anO1O2PWo0BWpUfExVxNcgsDna45+ErDzLMW4lHo
        KIXEjMGtKYrgaI1KbM+bmp78rQm3DS4XQ71Tf5CO8tBITQhjjd7BeFCtHzpbnb5D
        bB6ATyaVDa4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FBB3262F2;
        Mon, 16 Sep 2019 13:43:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 522BD262F1;
        Mon, 16 Sep 2019 13:43:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org
Subject: Re: pd/fetch-jobs, was Re: What's cooking in git.git (Sep 2019, #01; Sat, 7)
References: <mhng-2c9b8fd0-22e7-4679-9d9b-f8128881fada@palmer-si-x1e>
Date:   Mon, 16 Sep 2019 10:43:28 -0700
In-Reply-To: <mhng-2c9b8fd0-22e7-4679-9d9b-f8128881fada@palmer-si-x1e> (Palmer
        Dabbelt's message of "Sat, 14 Sep 2019 06:58:37 -0700 (PDT)")
Message-ID: <xmqqh85cb0hr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E6AF34C-D8A9-11E9-A78C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Palmer Dabbelt <palmer@sifive.com> writes:

> ...  It looks
> like there are some test failures when I rebase to the latest master,
> which I'm happy to fix.  Just let me know if I should:

> * Send just the first 4 patches, holding onto the last one for later.
> ...
> * Send just a single patch, which wouldn't add the --fetch-jobs and
> --submodule-fetch-jobs arguments.

It is either one of these two, I would say.  I am personally much
more comfotable with the usual "backward incompatibility migration"
form (i.e. the former), but apparently I am nto the only person on
the list so ... ;-)
