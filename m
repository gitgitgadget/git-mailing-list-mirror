Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0DF21FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 17:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbdCXRlO (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 13:41:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59987 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752179AbdCXRlN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 13:41:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B96475379;
        Fri, 24 Mar 2017 13:41:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M69Rc/e+e0BiNTCXv6Eg9MrwB4o=; b=ZwQ162
        MCtgD1egYiwxR0sZhg+NKZd/tDqZ5d/Tz44CYlNXq0gXhaXL0VBdlIpLzuuoxAdC
        Z9qo6U+AIdbxwIzdApTNkgtIk45wy5lIXHcRgxuDvYKsLo3HvPDjTgSXy5xQuSWw
        qMHN5MCUQHv63qFSBLTPp8LhkeOyCyPKT0U/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YnWH95GDRmsaSsctkor5ujKLyGejzuRf
        +C7AjC02Np3Gg3FDkXVAGNzp+rmYnNnMFCLOOO3eX3KzoxYKaxCIeiOa22xUvCt5
        8xO6LxPyKL50oBrjziQ+5rCNrOrYDOTSiwPjG0GlbyDITouMn9yPH2k278NMY+mP
        4mmkQfH+GPs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4302075378;
        Fri, 24 Mar 2017 13:41:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9DD2975377;
        Fri, 24 Mar 2017 13:41:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] log: if --decorate is not given, default to --decorate=auto
References: <20170324054631.21622-1-alexhenrie24@gmail.com>
Date:   Fri, 24 Mar 2017 10:41:09 -0700
In-Reply-To: <20170324054631.21622-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Thu, 23 Mar 2017 23:46:31 -0600")
Message-ID: <xmqq8tnu8te2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 117E6530-10B9-11E7-BFA2-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> +test_expect_success TTY 'log output on a TTY' '
> +	git log --oneline --decorate >expect.short &&
> +
> +	test_terminal git log --oneline >actual &&
> +	test_cmp expect.short actual
> +'
> +

Nice.  I didn't know test_terminal was so easy to use ;-)

Looks good.  Will queue.

Thanks.
