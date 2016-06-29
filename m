Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8867A20FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 17:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbcF2Rv4 (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 13:51:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65136 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750878AbcF2Rv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 13:51:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E10926C46;
	Wed, 29 Jun 2016 13:51:30 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gX7abOUsz2qdIoT8a/CyuSP53q8=; b=LHXqUG
	TYrkd/C39hzCuF1Qibbljq0DwXPG9NK5K7cVSK1FB3RQBy2NS/4ilOYpgghXHH6r
	uSh3B3qqE1zPGHMqSrlMoXAwAZRWlihuqucREQraZLHtZnAl+dj4WynkqHtsBO9B
	CnwDwSbOSs0EwLH0OzNSHXQADZGNzA3c9/nxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=igzXZCfFr0X6wyu+0V56FDr/zDlsx3om
	ByZDbCNxRe6n4nrrcRmst46Y8j4fveAn3OImvnCjn8a+Qu2ms0/9+TA5QYX6GzbC
	1tusQJG+O7yY4pJRLSmef7TOEdlHPuRx3PZ3fPCzE3SPXiEC+e6f5xkWQA3zVev4
	M0RPDJTHABo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 45C4426C45;
	Wed, 29 Jun 2016 13:51:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C636026C43;
	Wed, 29 Jun 2016 13:51:29 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 0/5] Use skip_blank_lines() for more commit messages
References: <cover.1467209576.git.johannes.schindelin@gmx.de>
Date:	Wed, 29 Jun 2016 10:51:27 -0700
In-Reply-To: <cover.1467209576.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Wed, 29 Jun 2016 16:14:37 +0200 (CEST)")
Message-ID: <xmqqlh1n51eo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1BD676F4-3E22-11E6-87E3-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> It occurred to me that there might be more code locations where finding
> the commit object's body is hand-rolled, and could benefit from using
> the skip_blank_lines() function to handle not-quite-standard but
> still-allowed objects from being processed correctly.

Thanks for following up on this one.  We could have left them as
low-hanging-fruit for new people, but doing these ourselves while
we still remember is a good idea.
