Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B2D51F859
	for <e@80x24.org>; Fri, 19 Aug 2016 19:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755235AbcHSTtt (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 15:49:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53672 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754127AbcHSTts (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 15:49:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F41B237911;
        Fri, 19 Aug 2016 15:49:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xPkTGNNBWizPK4DlB92sn4Jfywo=; b=Twa+JN
        78bixQPfNbqKY2iaSnfZOwoHz0irzzSoT60kpkMMKnvL/24xvwk1o+1XiE3ax3Hm
        kAr+0KENS8H3xzL2hrmp4yS89YKvDtAhygjWn46lPMCTsWyZkvs1m3PXXQmaC0/V
        ZalEaJrWe9c+ZW4Irx/k7YpRaPSVplmX5gt00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LuGg7DfUEuAd/Q7SMGdYTd6ifkkV7a4a
        P6nyvhWcxEpjOj5Dv5cGaRTPPgqb9PCkBuZ+5LO+uLhGvIjAAyNJmzWh2hHr76O0
        AO7UDHWt51M0rxProRJQDmShH/6VyruIJiqlEWiuNdOEWDeZqaH85F/NnYajh8OX
        UhhjZFg84pk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB68837910;
        Fri, 19 Aug 2016 15:49:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 712643790F;
        Fri, 19 Aug 2016 15:49:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v8 3/8] diff: prepare for additional submodule formats
References: <20160819000031.24854-1-jacob.e.keller@intel.com>
        <20160819000031.24854-4-jacob.e.keller@intel.com>
Date:   Fri, 19 Aug 2016 12:49:38 -0700
In-Reply-To: <20160819000031.24854-4-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Thu, 18 Aug 2016 17:00:26 -0700")
Message-ID: <xmqqzio81qul.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1143F0B2-6646-11E6-A300-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> +enum diff_submodule_format {
> +	DIFF_SUBMODULE_SHORT = 0,
> +	DIFF_SUBMODULE_LOG,
> +};

Unlike definition of an array elements, enum {} did not allow
trailing comma until recent versions of C, and we avoid it.

No need to resend only to fix this, as I have locally amended it.

Thanks.
