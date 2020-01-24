Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4691C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA452071E
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cixnKCsp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgAXVAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:00:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64916 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgAXVAs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 16:00:48 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E50D420D6;
        Fri, 24 Jan 2020 16:00:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IYqWK/kfhyDhC7HbxQSZRYwsV9o=; b=cixnKC
        spsWsA02XXaZgYasJDzicwwLWKkenO5hGrFAzXVuwp57Z8QqfPNCmb+zZNbeOS/w
        D1WoOzzJ+t32U9hlFphqr7FDY3NJhCEyu8x/9P9APoVh36WMYkF/kBV19bdy8wt3
        K4SlYeyCEFKaMzSEVHha0lKNYCxQKkjGPYBHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=To9bSIR8BXnFSk3AFnlqlyHcC1g+WdF5
        x+Z8Nim2gRQf6ssnM/WxTspju0MzcSFHDPRfdEIjYGZCZo4Fj8sYFioPQyvWVVTn
        163XFHcB4L1P1V/yNE0+6dhXx4Vz0ZiInU7iwco0j2W3iK91Kn7sxaJxDyU6qRIB
        A0ExN4KJqqo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 16511420D5;
        Fri, 24 Jan 2020 16:00:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7A587420D4;
        Fri, 24 Jan 2020 16:00:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] remote rename/remove: improve handling of configuration values
References: <cover.1579857394.git.bert.wesarg@googlemail.com>
Date:   Fri, 24 Jan 2020 13:00:46 -0800
In-Reply-To: <cover.1579857394.git.bert.wesarg@googlemail.com> (Bert Wesarg's
        message of "Fri, 24 Jan 2020 10:25:20 +0100")
Message-ID: <xmqq36c4zi0x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9836BF8C-3EEC-11EA-AA6C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All steps looked quite sensibly done.

>  - patch 5 will be replaced by/rebased on Matthew's work in 'config: allow user to
>    know scope of config options', once 'config_scope_name' is available

I expect that Matthew's topic would become solid enough after one
more reroll to name the function back to config_scope_name(); after
that, let's drop the step and instead fork this topic off of Matthew's
topic to queue the remaining patches on top.

Thanks.
