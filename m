Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D396020705
	for <e@80x24.org>; Thu,  8 Sep 2016 16:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758165AbcIHQSG (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 12:18:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52932 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757951AbcIHQSG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 12:18:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 827DF3AA44;
        Thu,  8 Sep 2016 12:18:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s4isznJv+nv8sYnAv2Nw/9J12zE=; b=J5wfRY
        P/xKaL/n34k+x2ctOD34yXx8Io6iqBuE7T2GHDIf26OrSZfHAEKZSliTw+kotwnc
        OCZMYM9zo4gD6VwhGtkpNmUs1pdnoktG3G6igzUCkd2CRTxJQA50zBPpy+PivLw3
        svKeeRhXe/XfDzdf8b/ttn5s+hNUxY4sdOcHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PredDykBC8hbSP2f7H9ttCPh6n0ffvSz
        0zQ2hg4PwL4o5Ri3izmlzPo5jyTtjMUyWbN0wxPinmk1IAj/GO9195MnKeOCULdt
        ogIo1f4BKV2yrWCUsaiACDGfhx9WpPsuHioV9ccR0GIxk9vYjA9ieIGX+k2/lG2p
        HSvikRvY9VY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79D653AA43;
        Thu,  8 Sep 2016 12:18:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D70A13AA42;
        Thu,  8 Sep 2016 12:18:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        spearce@spearce.org, sbeller@google.com, peff@peff.net
Subject: Re: [PATCH v3 2/2] connect: advertized capability is not a ref
References: <cover.1472836026.git.jonathantanmy@google.com>
        <cover.1473291819.git.jonathantanmy@google.com>
        <4b09bb7a5b7f4eb5fc31df3d98ce7ffc042eb367.1473291819.git.jonathantanmy@google.com>
        <20160908013431.GC25016@google.com>
Date:   Thu, 08 Sep 2016 09:18:01 -0700
In-Reply-To: <20160908013431.GC25016@google.com> (Jonathan Nieder's message of
        "Wed, 7 Sep 2016 18:34:31 -0700")
Message-ID: <xmqqmvjijrgm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1CF5DDC-75DF-11E6-AD47-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> I think we can make this stricter.  The capabilities^{} line is supposed
> to be the first advertised ref, before any 'shallow' lines or .have
> extra refs.

"The first", or "the first and only"?  I thought that it would be
the latter.
