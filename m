Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FE40203E2
	for <e@80x24.org>; Fri, 19 Aug 2016 01:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754553AbcHSA7x (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 20:59:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53261 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754291AbcHSA7u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 20:59:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 813433530C;
        Thu, 18 Aug 2016 16:42:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QQLT/LcKqHY+q2yJWCNyZSM887Q=; b=thHqPJ
        gWrh/D2rvch5qryMMaxB/06999OSwvdvTBgm9B/u/urzM9zcq2ysASjPFW1lo9LP
        6jn0qET0ZloaeG9+eqAIeDf9CjcwsLsSw4JXtTjpykhAi7r9nLtz6iYyMDwHf5qH
        FBmLR938WcADsRgTDjf5QaWQi9YiQWhEUSPQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mQjruGldbYotikPZRNu0WfedvGv5DC5q
        LT0AMrhi9suf2YCKdr5VOhzqLfvZ27CLqgUp8SPRzHj5pJ6fOzpBtlAphUNgvbi5
        drp6hV7Gmc/+f/lrXXF5ROR8Gcxdj2R2VJP3lBKowrz14sh3JkOCzfnJVAVZGaXC
        QB7m9SbCaTo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 76A7D3530B;
        Thu, 18 Aug 2016 16:42:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F1CB73530A;
        Thu, 18 Aug 2016 16:42:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Olaf Hering <olaf@aepfle.de>, git@vger.kernel.org
Subject: Re: git format-patch --break-rewrites broken in 2.9.3
References: <20160818144421.GA9062@aepfle.de>
        <alpine.DEB.2.20.1608181713440.4924@virtualbox>
        <xmqq7fbe6l7y.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 18 Aug 2016 13:42:04 -0700
In-Reply-To: <xmqq7fbe6l7y.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 18 Aug 2016 10:27:45 -0700")
Message-ID: <xmqqk2fd6c83.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A53EDF8-6584-11E6-9B7B-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I think that is one half of the story.
>
> The other half is a long/well known bug that lets "diff -B -M" to
> produce incorrect/broken patch that cannot be applied.  It was
> documented in the thread that begins at:
>
>     public-inbox.org/git/xmqqfvapuhkk.fsf@gitster.dls.corp.google.com
>
> but still hasn't been solved.

The problem report actually starts here:

    public-inbox.org/git/xmqqegqaahnh.fsf@gitster.dls.corp.google.com/

