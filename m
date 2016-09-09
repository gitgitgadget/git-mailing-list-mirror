Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E985E1F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 21:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754967AbcIIVBT (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 17:01:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65226 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754727AbcIIVBS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 17:01:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 209163AD09;
        Fri,  9 Sep 2016 17:01:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x3jBqWU+knzSXSrAvJGwHS/lMIc=; b=XDy3av
        PoJLGzDxCjiTfW6/zA1uLnFVmWTony0ZD2JOM3MdUrN3RYHEjETxwd6NK+whof+e
        NIn5JFi7HucDrhagbcViObRnlXswEz1jD0PlW03cr+tozV8RmoNO91KPCzFFs8eM
        bw6HLW+wsoVTGCwjgH3ia5/QaimAjXcHRgaDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kWyxYe0d89qj3eRVbmW3b9RFQVO0AHl+
        jFyN0qt0MZOqevzvGEg9TINkh8EncY2MKPT2uKT7Fl7vXxw+pnlnooRtzD1TvQ8H
        s0iBS4ChEiKs5/cJVKrdNBjBCPtFpHqDyOAXcFxrugUwtiTfFjrxz/4TsymxeiBD
        1i0FIDm1mEM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1839E3AD08;
        Fri,  9 Sep 2016 17:01:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8DD6F3AD03;
        Fri,  9 Sep 2016 17:01:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v3 0/2] patch-id for merges
References: <20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net>
        <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net>
        <20160909203406.5j5pmom442yoe4su@sigill.intra.peff.net>
Date:   Fri, 09 Sep 2016 14:01:14 -0700
In-Reply-To: <20160909203406.5j5pmom442yoe4su@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 9 Sep 2016 16:34:06 -0400")
Message-ID: <xmqqfup8aiud.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8CA9DA24-76D0-11E6-895E-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> And here is v3. Besides commit-message fixups, it drops patch 2, and
> instead the third patch teaches commit_patch_id() to distinguish between
> errors and "no patch id".
>
> Frankly, I still like v2 better, but I do not feel like arguing with
> Johannes about it anymore.

FWIW, I too like the simplicity of v2, as all the error-to-die
conversion is for cases in which there is no sane recovery path.

I'll have to take a bit deeper look at [v3 2/2] that had to become
more involved to decide if the additional flexibility is really
worth it.

Thanks.

