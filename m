Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13F0B1FF72
	for <e@80x24.org>; Thu, 19 Oct 2017 01:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751498AbdJSBzA (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 21:55:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52961 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751091AbdJSBy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 21:54:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 86D96B86CA;
        Wed, 18 Oct 2017 21:54:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bGSUsLGm+72mjEFKmXt6kCkP52M=; b=YKCv+X
        H83xHEnx1CFYUch5f8KGQpiyEe+5uQUUY6Ez+rkkATscghX3cD6w9/JbqIQ+9ccG
        m587zGTWyxkMINMx0ephl7hyco8OMh3zcg0v4uoWDlMU4u3lJm8fEjgnmqdIwAAF
        XKR88AOnT30qex873ywWHFzsoEft+egrQ7E+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=giGEKDBykY2ygs3p0EIOqng+6vYBr6TW
        crUbaxyrYSNoejMqXLGYmqzZCXVlqYs922JqYxYAY4Mf571/rlfT+XgA8uOar/lS
        aT1Z0btBakb8QAvruXyrC764w6hPVsGx98hCnpdCGq9pVEZ+d4ADZOQTIsRgKdps
        grtDbMRxuzc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7ECD0B86C9;
        Wed, 18 Oct 2017 21:54:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED433B86C8;
        Wed, 18 Oct 2017 21:54:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     orgads@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] name-rev: Fix tag lookup on repository with mixed types of tags
References: <20171018132420.4577-1-orgads@gmail.com>
Date:   Thu, 19 Oct 2017 10:54:55 +0900
In-Reply-To: <20171018132420.4577-1-orgads@gmail.com> (orgads@gmail.com's
        message of "Wed, 18 Oct 2017 16:24:20 +0300")
Message-ID: <xmqqefpzkikw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82155244-B470-11E7-B722-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

orgads@gmail.com writes:

> From: Orgad Shaneh <orgads@gmail.com>
>
> Commit 7550424804 (name-rev: include taggerdate in considering the best
> name) introduced a bug in name-rev.
> ...
>  builtin/name-rev.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Can you update a test to protect the change this patch makes from
future breakages?  That would also demonstrate how the current code
is broken and this patch improves the situation, as I am having a
bit of trouble seeing why this change is needed.

Thanks.
