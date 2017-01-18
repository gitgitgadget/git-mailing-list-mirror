Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E37AD20756
	for <e@80x24.org>; Wed, 18 Jan 2017 00:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752285AbdARAFO (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 19:05:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60612 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752280AbdARAFM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 19:05:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B378761F0B;
        Tue, 17 Jan 2017 19:05:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZYWiDqcljQ9Cl53aGDXU36cbcWc=; b=HF8p0b
        jpQ66bQw0xnam3Z4F51HTgqcTrbyrJ7slIbGC28pkj9mgKFLHTjSqQREDfTCEjPl
        13o87gshfbXCXLLDaosypVNWxzFelJBBNP/PnsQnGVYV6mdDqHVlT/LdttmdWP9m
        +ESbQ5Bo3JPAQMO89ubhyDabx9xsPMermwf8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S2MslhXwgUOqh5ci0QeIuSDdAOSrnije
        cUBSY1U5/PrkZ8HrPI5oTmHEYS3I+m+33TSjny1GEURtq3D052lzezFxGJ+J7QdA
        d+HysIgULEeDodpEUejkMmgOtrhkcasUzIr3A1fDLFivRoANynQMJpNLIjrfjKO9
        0vBS9jTRNiw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 747DB61F07;
        Tue, 17 Jan 2017 19:05:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F9B261F00;
        Tue, 17 Jan 2017 19:05:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v6 4/6] builtin/tag: add --format argument for tag -v
References: <20170117233723.23897-1-santiago@nyu.edu>
        <20170117233723.23897-5-santiago@nyu.edu>
Date:   Tue, 17 Jan 2017 16:05:00 -0800
In-Reply-To: <20170117233723.23897-5-santiago@nyu.edu> (santiago@nyu.edu's
        message of "Tue, 17 Jan 2017 18:37:21 -0500")
Message-ID: <xmqqziipb5cj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2A0EC1A-DD11-11E6-A22A-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

santiago@nyu.edu writes:

> -static int for_each_tag_name(const char **argv, each_tag_name_fn fn)
> +static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
> +		void *cb_data)
>  {
>  	const char **p;
>  	char ref[PATH_MAX];
>  	int had_error = 0;
>  	unsigned char sha1[20];
>  
> +

Why?  I'll remove this while queuing.

>  	for (p = argv; *p; p++) {
>  		if (snprintf(ref, sizeof(ref), "refs/tags/%s", *p)
>  					>= sizeof(ref)) {
