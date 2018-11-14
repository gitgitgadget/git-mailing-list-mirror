Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01E781F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 03:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbeKNNHK (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 08:07:10 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54320 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeKNNHK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 08:07:10 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AA9A228B72;
        Tue, 13 Nov 2018 22:05:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QqzXL6EZJTT8MnYctnOE16ei+Qk=; b=VE7zaG
        D3b+cuVPNaTucVU7puNSb66mzRODMd9cyW2g2Oud5AOjVPs6Q6AL+LtFuI3cj1Le
        b3bP4MSICd2cjKFVntgSlDMpaj2EVW7itQb+mTHGUjm3VrtX+ISWnS3FeIvD0R0H
        yXxhN+5UnYYKAhbPM02QX4eo/feNKlS4ARWdA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xLDlYIYJ5nTeZAleXfHz/MnMDA+tvlOw
        jP+Oy8Kh3/7N/ho2UPA+Gs2WHKPR2MARdd4qbJWg5jh9preKF8vcqRN1I0dX/bLl
        mhRCnlVl8Fmh0tlCxpUsW7oh2fuZ1ogi1Ui9xZcLMexSVpdK3VnEL9xpEVRsCFCd
        SapKbcpJZkQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A366228B71;
        Tue, 13 Nov 2018 22:05:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 479BC28B70;
        Tue, 13 Nov 2018 22:05:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH 2/3] ieot: default to not writing IEOT section
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20181010155938.20996-1-peartben@gmail.com>
        <20181113003817.GA170017@google.com>
        <20181113003938.GC170017@google.com>
        <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
Date:   Wed, 14 Nov 2018 12:05:49 +0900
In-Reply-To: <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com> (Ben Peart's
        message of "Tue, 13 Nov 2018 10:22:44 -0500")
Message-ID: <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 315FE55C-E7BA-11E8-AA20-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> Why introduce a new setting to disable writing the IEOT extension
> instead of just using the existing index.threads setting?

But index.threads is about what the reader does, not about the
writer who does not even know who will be reading the resulting
index, no?
