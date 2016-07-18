Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E2792018B
	for <e@80x24.org>; Mon, 18 Jul 2016 18:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbcGRSm5 (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 14:42:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61249 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751615AbcGRSm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 14:42:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 672F12C6FB;
	Mon, 18 Jul 2016 14:42:55 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oaSxVaQMpXAg8v9iMyA7XpWu3rU=; b=uN2RT3
	oGsq7S+SMvl7YqhxAxXLUy/SJx9Ue1U97pVqBq4joUaQ17aBEyZgLUElEPGUUZ5y
	14bkUtPqczuxlWi0ozYB9HBzL75bkbh+i4xOR5RQb6jbqFJsdfJpe2mcI04Zh8wd
	Q164jKu0hQLo+2G1mzwa4HxMqPUoYdh5Hj4OM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I4ZYyNYHBtC2jtFc/TjKKQyv5FQz6sVg
	br9hzYTIB30b6voEKq2dQNazsU7mgDSNHbfEl2MSQqNzzsDKmuj5rPEBs+yUplRs
	6oYf4a5heGSDcVCYLouHDiUoy1/x4n2UgBY36PVGPvThnT2dAsg9sCgU9QlsFovC
	k+ZPumVXtmQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F3FC2C6FA;
	Mon, 18 Jul 2016 14:42:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DBC282C6F9;
	Mon, 18 Jul 2016 14:42:54 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/4] Teach `git fsck` a new option: `--name-objects`
References: <cover.1468510191.git.johannes.schindelin@gmx.de>
	<cover.1468752290.git.johannes.schindelin@gmx.de>
Date:	Mon, 18 Jul 2016 11:42:52 -0700
In-Reply-To: <cover.1468752290.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Sun, 17 Jul 2016 12:59:38 +0200 (CEST)")
Message-ID: <xmqqinw2kcsz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 708AB116-4D17-11E6-B45A-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>  -static int fsck_error_func(struct object *obj, int type, const char *message)
>  +static int fsck_error_func(struct fsck_options *o,
>  +	struct object *obj, int type, const char *message)
>   {
>   	objreport(obj, (type == FSCK_WARN) ? "warning" : "error", message);
>   	return (type == FSCK_WARN) ? 0 : 1;

That's a good change.
