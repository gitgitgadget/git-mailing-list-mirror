Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C831207BC
	for <e@80x24.org>; Wed, 19 Apr 2017 02:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759244AbdDSCtB (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 22:49:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62244 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1759229AbdDSCs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 22:48:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A66A1821AA;
        Tue, 18 Apr 2017 22:48:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zrYOkQcpOYsJvsJm9pcbOiYZyiM=; b=tdhI6G
        67JI9UaNAn5mg+Phlz4QL4Cc7phJwLYInFdWTVVAsWVptDc4JwqIy8S2qWM9tW3n
        LJxx1bqYoWsx7o9/M+KtV9tzq1aFMDMn5M5gP1GVpBXWQOrW10iAl2uL4J205bgu
        xqIrUIZNFDq1MvoyO6aBYz4rTNI9bEZystTMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BA8DCLVSoI7w0XkeAqQv8OyssxT4v4kN
        y0LXEwCUSS4L9Uu+rV11bZKoPk9uxBAW/Vep8H5dGCUOsyNWAfRw7Vesc+Pv8/Ch
        oy03xnDmoQggGJZpAE8XqWj1oUFGT5MRtn0ZThXoHeJASPcHkqNmL3YtswykUvnk
        CVGRDpoSlUc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E979821A9;
        Tue, 18 Apr 2017 22:48:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D4A42821A8;
        Tue, 18 Apr 2017 22:48:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, l.s.r@web.de
Subject: Re: [PATCH v3 2/2] xgethostname: handle long hostnames
References: <20170418215743.18406-1-dturner@twosigma.com>
        <20170418215743.18406-3-dturner@twosigma.com>
Date:   Tue, 18 Apr 2017 19:48:56 -0700
In-Reply-To: <20170418215743.18406-3-dturner@twosigma.com> (David Turner's
        message of "Tue, 18 Apr 2017 17:57:43 -0400")
Message-ID: <xmqq8tmxcdt3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC3748DE-24AA-11E7-89F6-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twosigma.com> writes:

> If the full hostname doesn't fit in the buffer supplied to
> gethostname, POSIX does not specify whether the buffer will be
> null-terminated, so to be safe, we should do it ourselves.  Introduce

The name of the character whose ASCII value is '\0' is NUL, not
null (similarly for in-code comment).
