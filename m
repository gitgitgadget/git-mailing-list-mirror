Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12F482018A
	for <e@80x24.org>; Mon, 27 Jun 2016 15:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbcF0Pbb (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 11:31:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56958 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751385AbcF0Pbb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 11:31:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 101CE27D93;
	Mon, 27 Jun 2016 11:31:30 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eq+IQbDDJnbrWJFGjvmkK2DXSPs=; b=mt/WPh
	od1c0ygs5sem8fEZAmvrODxhvTmRQg+b3ywdfFEEgOkF0z5VCcvjhtT1RAo/T7JI
	3DoiYAKhNiVtkNXzi7gD30jgwBJprsokkMiq52aNQMawUmNeV7UObOwhBA3VxEUs
	7nO/4/Iv4p1AKEEbcC8S+Bom/5ivKLq/TYAiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BO4nbOI1ZQb/89KFczSoHnPg+zKw2MHe
	mrlrQp4DNdaw4kL0687KMHjP93LhflEYUHGhXY7QF1Oi2cWwp+A7nge73vEHMm6x
	7LGj3R7GqM6HDwSsAWpMfRpebfZj4TVhIBt+ucn923937IPsJVngq0T5H3lbIp5U
	jwa2m9eyoR4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 06CE227D91;
	Mon, 27 Jun 2016 11:31:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FD1B27D8C;
	Mon, 27 Jun 2016 11:31:29 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Sunshine <sunshine@sunshineco.com>
Cc:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v4 5/5] fetch: reduce duplicate in ref update status lines with placeholder
References: <20160605031141.23513-1-pclouds@gmail.com>
	<20160626055810.26960-1-pclouds@gmail.com>
	<20160626055810.26960-6-pclouds@gmail.com>
	<CAPig+cT=BAuAbEmS5G1v2yGNczA+-WvW0bBZz_hrLcYi0bpO4g@mail.gmail.com>
Date:	Mon, 27 Jun 2016 08:31:27 -0700
In-Reply-To: <CAPig+cT=BAuAbEmS5G1v2yGNczA+-WvW0bBZz_hrLcYi0bpO4g@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 27 Jun 2016 00:33:28 -0400")
Message-ID: <xmqqvb0ubqcw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 380C7712-3C7C-11E6-816E-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> In my brain, at least, '$' is associated so strongly with regex that
> "origin/$" is interpreted automatically as anchoring "origin/" at the
> end of string, and "refs/$/head" just feels weird.
>
> On the other hand, given the familiarity of shell globbing, "origin/*"
> and "refs/*/head" feel quite natural and intuitive.

I had the same thought ;-)
