Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 221C51FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 16:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757362AbdCXQ6O (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 12:58:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56960 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756692AbdCXQ6M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 12:58:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81F4774A6E;
        Fri, 24 Mar 2017 12:58:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Bzht7y7U0OGs9onygqHZiLYT7ZY=; b=q7YllA
        wZYuJciZnQidl2pjkqv8VTW3fiyJ71VWySQc/ha28PXqjtXq2uGjb052C9Xn2bbT
        HS13vX/67o29S32kdGmfpbz9IOBUCCdVo7B/BhslpJg0IK4kg9Tym+xiuC+73cy1
        ll8wDVYNaI/zXhwAJT7r3Z/bXJFsRijVsUwBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UtkavQ4eCr8byrjfLYL66kWOeK7XTpHw
        PsHUrxecNJddrDI5YQxMtq6+im2sjCXk7zhkrXT0ZaqDSMlrZPsW35u2FHSoHWje
        4iLD4/ucwHnGXYNXfNKD7IVtptp2s530bkOqAW4O4v7HhJYoPX6+pWadtq73fnPB
        f9XSZVREqUs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7854174A6D;
        Fri, 24 Mar 2017 12:58:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CB9D574A6C;
        Fri, 24 Mar 2017 12:58:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        sxlijin@gmail.com
Subject: Re: [PATCH v2] travis-ci: build and test Git on Windows
References: <20170324113747.44991-1-larsxschneider@gmail.com>
Date:   Fri, 24 Mar 2017 09:58:08 -0700
In-Reply-To: <20170324113747.44991-1-larsxschneider@gmail.com> (Lars
        Schneider's message of "Fri, 24 Mar 2017 12:37:47 +0100")
Message-ID: <xmqqh92i8vdr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F364442-10B3-11E7-BF03-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> I think I addressed all issues from the v1 review (see interdiff below)
> with one exception. The script still uses bash instead of sh. Something
> about this does not work in sh:
>     --output >(sed "$(printf '1s/^\xef\xbb\xbf//')" >cat >&3)
>
> Does anyone know how to make this sh compatible?

Making this runnable under any shell is not a goal; if your script
does rely on that bash-ism, then leave it as-is and mark it with
#!/bin/bash or somesuch.

Thanks.

