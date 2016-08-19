Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB8371F859
	for <e@80x24.org>; Fri, 19 Aug 2016 21:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755533AbcHSVFV (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 17:05:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64958 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755283AbcHSVFV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 17:05:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B204A3746F;
        Fri, 19 Aug 2016 17:05:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nxiMgXrhUkalF0qrXJh0+lq4XPY=; b=XYb9kU
        VHCfk9B05xoWZyuarsjZBzfm/2wHdQWVwtuT8s4lu7KR2dEw0jry5dC1PcRcL+Tp
        aSQ/ThcQcQfOyn9pUyXasUI3pENQceX4RpefCh+C6KKqboOnqJKtZDZjVwsRBt9g
        iot2D9D7lfn5Boz78kzHz6fo5nNSq5FW1rc+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U0NnkbOTn5RSElZlHA4CN8nG3T/yE6yy
        MzEGtdXrAdhF+1wwhCPLEgXVTHmAeWzfLzofRxvJIEj1kO4SD7wTIUzVoqTRd6F7
        RpcYaYx8WpdmXdwhxtKZ3em9VFlpYZhjh0XJz0xajkz0uvRCZx+1Dzo5PdCNeyAE
        vsnesIt30IM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8F633746E;
        Fri, 19 Aug 2016 17:05:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4525A3746D;
        Fri, 19 Aug 2016 17:05:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brian Henderson <henderson.bj@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, e@80x24.org
Subject: Re: [PATCH] diff-highlight: add some tests.
References: <xmqqh9ag39zk.fsf@gitster.mtv.corp.google.com>
        <20160819201837.GA18918@tci.corp.yp.com>
Date:   Fri, 19 Aug 2016 14:05:17 -0700
In-Reply-To: <20160819201837.GA18918@tci.corp.yp.com> (Brian Henderson's
        message of "Fri, 19 Aug 2016 13:18:37 -0700")
Message-ID: <xmqq37m01nci.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A29C635A-6650-11E6-A1F8-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brian Henderson <henderson.bj@gmail.com> writes:

> +# dh_test is a test helper function which takes 1) some file data, 2) some
> +# change of the file data, creates a diff and commit of the changes and passes
> +# that through diff-highlight.
> +# The optional 3rd parameter is the expected output of diff-highlight minus the
> +# diff/commit header. This parameter is given directly to printf as the format
> +# string (in order to properly handle ascii escape codes; CW, CR), so any '%'
> +# need to be doubled to protect it.

My mistake.  All three are given directly to printf as the format
string, so it is misleading to single out $3 when warning the
callers about '%'.

Sorry about that.
