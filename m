Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D79CC20FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 20:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbcF2Uub (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 16:50:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58876 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751023AbcF2Uu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 16:50:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09AC628012;
	Wed, 29 Jun 2016 16:50:27 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1hArAGKpmIUWUNyOQqyOluOfPgU=; b=ScGX9F
	0JvN/CICt0CYXc4jnJ4En87TJRtZNK3DxMjH2YNcXq9qzpSvi2oaumFpVwFEINsr
	sddrjTC8N/lDFxQ/Uwjop7QJi9kPvw5pwajWuRICpfKgG6Z2iNU9Smcn0jL2s3kB
	3Y2vRyTGY1lpCNabf1pI0nlStMtyj7WJtKOrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GZ8vy0L/fFCxbK8+Gl3dji4JfneFbvBr
	AlJSq1aceEk41F5oCLiSiSKmRzQVwRWsN4TN421BqyuZ7TEbbchWEOw9GzsV1xGr
	j4V1Pa3EKUqTmrL3nEOQKb6V1ZRx6I5b4IQaiBH3Kogms8+nkTnG2q2qf/a+ylDA
	GWY9LSjx54k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0154A28011;
	Wed, 29 Jun 2016 16:50:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 680D528010;
	Wed, 29 Jun 2016 16:50:26 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/9] Report bugs consistently
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
	<8615dc276828a3f99a27ff2eda9909548a7d435e.1467199553.git.johannes.schindelin@gmx.de>
Date:	Wed, 29 Jun 2016 13:50:24 -0700
In-Reply-To: <8615dc276828a3f99a27ff2eda9909548a7d435e.1467199553.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 29 Jun 2016 13:36:41 +0200
	(CEST)")
Message-ID: <xmqqfurv3ejz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B5BD980-3E3B-11E6-84A5-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The vast majority of error messages in Git's source code which report a
> bug use the convention to prefix the message with "BUG:".

Good thing to do.

But if we were to review and apply a 200+ line patch, I wonder if we
want to go one step further to allow us to write

    BUG("killed-file %s not found", name);

instead.

