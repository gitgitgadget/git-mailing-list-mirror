Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E787320756
	for <e@80x24.org>; Wed, 11 Jan 2017 02:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760934AbdAKCqI (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 21:46:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60290 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754150AbdAKCqH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 21:46:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 43FCB5EBF9;
        Tue, 10 Jan 2017 21:46:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DyPy0gh9MMneu08MCsZQp6tc8II=; b=xnU+WI
        YodXAX+SlgILPBw310X1hmSECyOERuCX5rzRJAzMjT7WyfVsy9r1u4p+x8tbg/yA
        PhuGiF9F1oS3IG8aJkB5oahXg5NKreqq294F91nCUlr5LcrStZxZpcgt6s7fheuV
        qtgXl2LVw4Dg+jevMqwnkFSjY0Vx7leHtY7BM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IKgwy7ocdV42fMIjMmn23Ma+o3+5pEfN
        syo+TjkCEOkDBhSFkoe8I5bWIyoCK7sAVtanHJ86b05R5M3HN7RVaSIcEr5wwWfa
        2eu8Ku0B6gsiYTaRvZPaMnsQgdsQfH7qqTlQly3vwcaMmUTmSjpHVtCOLGuI3h8+
        O27eWntIbDY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B3085EBF6;
        Tue, 10 Jan 2017 21:46:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E5D55EBF4;
        Tue, 10 Jan 2017 21:46:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Richard Hansen <hansenr@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff: document the pattern format for diff.orderFile
References: <20170110004031.57985-1-hansenr@google.com>
        <20170110004031.57985-3-hansenr@google.com>
        <xmqq8tqismdx.fsf@gitster.mtv.corp.google.com>
        <17d48ccd-fd19-3922-8ee8-af6558d22632@google.com>
Date:   Tue, 10 Jan 2017 18:46:04 -0800
In-Reply-To: <17d48ccd-fd19-3922-8ee8-af6558d22632@google.com> (Richard
        Hansen's message of "Tue, 10 Jan 2017 20:14:35 -0500")
Message-ID: <xmqq60lmpb4j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 190AAF88-D7A8-11E6-A1DE-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Richard Hansen <hansenr@google.com> writes:

> I was looking at the code to see how the two file formats differed and
> noticed that match_order() doesn't set the WM_PATHNAME flag when it
> calls wildmatch().  That's unintentional (a bug), right?

It has been that way from day one IIRC even before we introduced
wildmatch()---IOW it may be intentional that the current code that
uses wildmatch() does not use WM_PATHNAME.

