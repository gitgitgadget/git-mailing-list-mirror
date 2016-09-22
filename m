Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCF331F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 19:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966201AbcIVTRh (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 15:17:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61103 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S966127AbcIVTQv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 15:16:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E7051E5BE;
        Thu, 22 Sep 2016 15:16:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AJQwdeI+4iCGxtUvpA1yRhJfItA=; b=VnSFl8
        gE16YpJyFtSH4zNTm4Za0A8PHWTxeOyEaM1Pu3jmECuKjB/rhaFa1awNPO5oRBtS
        Tv6sTLhLiWD/mmXJf12qjdyjsEyuxsIRVXE/o2iTDuoTIuBfbDTKDLk4ehyv2VJZ
        Ic3O828rfPvXWhlqGWraNKBhQfrvoNLXTr2sc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p7FDXb4Hbw2U3c4LdHmVKaKWowYrsGAb
        nLKA/Anf5P6AAN2hKFHjQ+0K8n1H13FDYOoQunGtyTFwwjZvDyh1zcirJplQFvfT
        HyX+oxnr52/IQ/FkcYj4eCkbh1IDMxfZ2Ocep96GQsYSB9JDLJOOyf/mhX0xNPPM
        +P0m2JTGn2w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE0A5E5BD;
        Thu, 22 Sep 2016 15:16:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 52556E5BC;
        Thu, 22 Sep 2016 15:16:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Timur Tabi <timur@codeaurora.org>
Cc:     Kevin Daudt <me@ikke.info>, git <git@vger.kernel.org>
Subject: Re: .gitignore does not ignore Makefile
References: <CAOZdJXWpcSZ+jAoV8HttkaB7Fh=wzWDTCsHy8W-S9xOOBodVFw@mail.gmail.com>
        <20160922154421.GA6641@ikke.info>
        <xmqqy42j4wp9.fsf@gitster.mtv.corp.google.com>
        <57E4267B.1050507@codeaurora.org>
Date:   Thu, 22 Sep 2016 12:16:47 -0700
In-Reply-To: <57E4267B.1050507@codeaurora.org> (Timur Tabi's message of "Thu,
        22 Sep 2016 13:44:11 -0500")
Message-ID: <xmqqtwd74ue8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C6D2404-80F9-11E6-ADBE-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Timur Tabi <timur@codeaurora.org> writes:

> So .gitignore only ignores new files, not modified ones?

It is determines if an untracked file should be considered by "git
add" to add it or ignore it.
