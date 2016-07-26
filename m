Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F64F203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 21:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757196AbcGZVid (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 17:38:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753954AbcGZVic (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 17:38:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E8C8C2F179;
	Tue, 26 Jul 2016 17:38:30 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3shcVur6duk9MzmKenCCnxnpfQA=; b=q/m9te
	uEyGfB7INiWuoNSkrzN5ROiN7WFKTVBugzvQcZYny5P/hQmS4cBA4Z6v5QtnoWyY
	yHxfvU9hQ/TvzV9c/+9tvaxbSc5xseGm8R73Ju/GzUVgz2txI3kxV8q95SvXVO/x
	Cb70GFNc6Bj+fBRDCzAifAMauZsxWbqxI7cIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vSnPPlW3f2XlyV55IXRai2LPas7bo6la
	rCpx0Ad9wXbZ+ysxMQ2T6tG+Gd+VcXD333HtegAEl8Bkoydx1VBcZtq+va9dgFOD
	lheJE/AWM1S5sA7CE0GO6xHLsdd6AuyR9m5ladx0iDaiqDZdGKgfLCEo9il2AGXr
	mMDSPvXN608=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E1CBB2F178;
	Tue, 26 Jul 2016 17:38:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 695702F177;
	Tue, 26 Jul 2016 17:38:30 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/2] pack-objects: break out of want_object loop early
References: <20160725184938.GA12871@sigill.intra.peff.net>
	<20160725185010.GA12974@sigill.intra.peff.net>
	<xmqqeg6h5w60.fsf@gitster.mtv.corp.google.com>
	<20160725214113.GA13589@sigill.intra.peff.net>
	<xmqqbn1l4c87.fsf@gitster.mtv.corp.google.com>
	<20160725221411.GA14131@sigill.intra.peff.net>
	<xmqqshuwyw14.fsf@gitster.mtv.corp.google.com>
	<20160726204851.GA22353@sigill.intra.peff.net>
Date:	Tue, 26 Jul 2016 14:38:28 -0700
In-Reply-To: <20160726204851.GA22353@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 26 Jul 2016 16:48:51 -0400")
Message-ID: <xmqqr3agxep7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B835DE2-5379-11E6-A0AF-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I got side-tracked by adding a t/perf test to show off the improvement.
> It's rather tricky to get right and takes a long time to run. I _think_
> I have it now, but am waiting for results. :)

Well, then I'd stop here and wait for the reroll to requeue.

Thanks.

