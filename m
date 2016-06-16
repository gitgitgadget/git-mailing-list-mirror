Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID,
	URI_HEX shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC63C1FE4C
	for <e@80x24.org>; Thu, 16 Jun 2016 21:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754470AbcFPVOc (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 17:14:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61637 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754006AbcFPVOc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 17:14:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B59B24F6B;
	Thu, 16 Jun 2016 17:14:30 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mczuy/z411SlqzVLeOREb/Gv/90=; b=pVIqbP
	XSt4dPMAa7+rGMBY8VXlNx6d6m1vXxwp9h9Gs563zAPjULRNUOaKvcMGhCbJK08r
	7xEqCsekOAfh+ZRHwa693JtN+TIsOTJOjqVFg+4llnLEXW2NVpGUWpIy0gJpeeJ0
	kA4iqYxiYI2hQZe6sDNfEVmZ0zhZT4hTMDM4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TEN6+n6chaBzseylwvj1oDhnDnMxxSlG
	vnf4YnsSuMA+/q6SNhMGF9fbHM8nc0kZAV0nECZ4AMwuQ/daFxV9hyBYAPo27SC6
	z/auh5yaRxX+EWExgqhDGZKqtHLdf17XSqHmTO2Qz4uAMCSgvuiWsxeoUP56I6LT
	CqsgNcKY4yw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 93C6924F6A;
	Thu, 16 Jun 2016 17:14:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 19FE024F69;
	Thu, 16 Jun 2016 17:14:30 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Elia Pinto <gitter.spiros@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jun 2016, #04; Tue, 14)
References: <xmqqtwgv77az.fsf@gitster.mtv.corp.google.com>
	<CA+EOSBm5DLkv2RyovSrOuvqDS6OR15g5Z_JuGthwQr2t=R8vdg@mail.gmail.com>
	<20160616123644.GD15988@sigill.intra.peff.net>
Date:	Thu, 16 Jun 2016 14:14:28 -0700
In-Reply-To: <20160616123644.GD15988@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 16 Jun 2016 08:36:44 -0400")
Message-ID: <xmqqh9cs4z0r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5086A952-3407-11E6-8F6F-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jun 15, 2016 at 09:35:20AM +0200, Elia Pinto wrote:
>
>> > * ep/http-curl-trace (2016-05-24) 2 commits
>> >  - imap-send.c: introduce the GIT_TRACE_CURL enviroment variable
>> >  - http.c: implement the GIT_TRACE_CURL environment variable
>> >
>> >  HTTP transport gained an option to produce more detailed debugging
>> >  trace.
>> >
>> >  Rerolled.  Is everybody happy with this version?
>> >
>> The refs is there
>> http://git.661346.n2.nabble.com/PATCH-v7-0-2-Implement-the-GIT-TRACE-CURL-environment-variable-td7657079.html
>> 
>> If  kindly someone who has reviewed and helped me to do the patch
>> could give an ack (or a nack eventually). Thanks in advance
>
> I gave another look at what is queued in pu, and I think it is OK. I
> still find the output a little verbose, but I think we should ship it
> and see how it fares in practice while debugging. I don't think its
> exact format needs to be set in stone, so we can tweak it later if we
> choose.

Thanks, let's push it forwared then.

>
> -Peff
>
> PS Please trim your quotes to just the relevant bits.
