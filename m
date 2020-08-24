Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894B2C433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D95E20639
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bcz+v2lc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHXRzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:55:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58973 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgHXRzL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 13:55:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 73F2776824;
        Mon, 24 Aug 2020 13:55:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u0C8l29YAyeDgBO1aoSs5gvKnNA=; b=bcz+v2
        lcjLkPK4TrBSv+oNsH5jtL4ljUopFbAGaJiV6oLQPfci5VnLXeqV+oydm9usiN6R
        nN4ctAy3NkrLsI0gql68y5oVJabzHu/MY/keBIgrroMYUh+jWPNUlDJYp37A/5Vx
        oSQCHy3XNDV+PPfXO8hL7uxPQZmiTEauB0YCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Vy6O5E6Sjs/2oJYrqD3af0qNsAJK+BLa
        CsbQJbBA2bOx0qiKLb6HXUbgA5UMiCGQNYUYFtkE4r3IUcxAS7NMbUeja9HNuuJZ
        r79y7ioIGmZHZZx746cuvD9D+uOasvMxjnihMq0HHc7RQ40D6xS6vbNOR9b1x0wm
        uS4abXeXnIg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 440E176822;
        Mon, 24 Aug 2020 13:55:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 21C0476812;
        Mon, 24 Aug 2020 13:55:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC v2 1/1] refspec: add support for negative refspecs
References: <20200821215247.758978-1-jacob.e.keller@intel.com>
        <20200821215247.758978-2-jacob.e.keller@intel.com>
        <nycvar.QRO.7.76.6.2008221528170.56@tvgsbejvaqbjf.bet>
Date:   Mon, 24 Aug 2020 10:55:05 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2008221528170.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sat, 22 Aug 2020 15:29:49 +0200 (CEST)")
Message-ID: <xmqqk0xo53pi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2C07B1C-E632-11EA-964B-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The `?:` operator is not supported e.g. by Visual C. Let's not use it.

Thanks.  IIRC that was GNU extension?

