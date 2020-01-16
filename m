Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2883BC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 22:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC70320728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 22:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oQC89Gsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbgAPWvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 17:51:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53293 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbgAPWva (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 17:51:30 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 82AC738E22;
        Thu, 16 Jan 2020 17:51:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8mqRv6pyFcFQb8T9fv48d6YA3NE=; b=oQC89G
        sdiUPgXDtHZwbzyRutnwCqQleWjFTfixncPIv9BWfS73TKAUJXWhnCRdmb0cpnpQ
        LNwaQoEgY/ZW90iF21wcj4m/uYM86QnFXuZzeVaHBJCNyhotoOUCmDIe4idGpB36
        ofFI4nIBv2ti38P6bu9X9xCRTo56wRQhqf+IA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tPqdLKgZJWiGo5XcpRIqFuqzTDlGI/+8
        Dc/TkoiMeWJZHBymhUzFHO6YR71oKPAVlpGvl0D5pW8gfyGROIuzDXM5cfUcnUq2
        sb4J92v7lW3paVlyQWNsTW+1MqeYue/g7e9C4ZjHdhoLJaAYf5rtCvcpz+GjX4uu
        a4IiuP8RE5w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7955038E20;
        Thu, 16 Jan 2020 17:51:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DF9B738E1F;
        Thu, 16 Jan 2020 17:51:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nirmal Khedkar <nirmalhk7@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Facing error in git-imap-send while compiling Git
References: <CAFFaXsyVy-fU5c7teDbVCTdUXFTK0GQ=Fse5wSi2vMifyZxS9A@mail.gmail.com>
Date:   Thu, 16 Jan 2020 14:51:26 -0800
In-Reply-To: <CAFFaXsyVy-fU5c7teDbVCTdUXFTK0GQ=Fse5wSi2vMifyZxS9A@mail.gmail.com>
        (Nirmal Khedkar's message of "Fri, 17 Jan 2020 00:50:37 +0530")
Message-ID: <xmqqk15rf21d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BAE7A96E-38B2-11EA-8949-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nirmal Khedkar <nirmalhk7@gmail.com> writes:

> Hey!
> I've been facing this error everytime I run the Makefile:
> -----
> LINK git-imap-send
> imap-send.o: In function `verify_hostname':
> /git/imap-send.c:252: undefined reference to `sk_num'

Perhaps the thread

  https://lore.kernel.org/git/xmqqpnfv3tq4.fsf@gitster-ct.c.googlers.com/

may help?

