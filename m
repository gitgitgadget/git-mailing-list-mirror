Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42AD91FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 18:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933616AbcLSSrK (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 13:47:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62525 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932546AbcLSSrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 13:47:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B6F359DE5;
        Mon, 19 Dec 2016 13:47:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uoq1oCgLlTqpdDX/iUbLy7J1Wic=; b=FTTp0V
        ujVGBc6UFLwzeZIhRUkjFV0BvqBPeVRgNTx15GQTZIdgIA/wf+OUmUy84NjHHD0H
        4ssvO29UPwFDw7ozSlFrPuW6K7G5IUv9UrYDUZu6282Jk0qjLm9700B+WsXnvgan
        koSweY3K8rF9R7KvIM8vpWXYc+cnoEA16XVZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lvr8eQw8LAFo+EsKajhlyAWF7Y6noUAB
        NAauKX2sP/nmERu3SP/okBFrTJveAkYCHBZ68qAiwUU8/0ZH5DCnFg8r68dEbGo2
        Zhk2NxNN+CnqZ4UDlG3faLAIqvYAZkVnyU/TlGuLY++S91nfw5KmBmDvTpkyUVTf
        AQCy3Tf8mpA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4281E59DE4;
        Mon, 19 Dec 2016 13:47:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8B0159DE0;
        Mon, 19 Dec 2016 13:47:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 03/34] sequencer (rebase -i): implement the 'edit' command
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <a1361151ad1dad8f4dc3c412c7ed30f625d67ba0.1481642927.git.johannes.schindelin@gmx.de>
        <xmqqbmwf1pqd.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1612191438200.54750@virtualbox>
Date:   Mon, 19 Dec 2016 10:47:06 -0800
In-Reply-To: <alpine.DEB.2.20.1612191438200.54750@virtualbox> (Johannes
        Schindelin's message of "Mon, 19 Dec 2016 14:46:08 +0100 (CET)")
Message-ID: <xmqq8trbpxhx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Pobox-Relay-ID: 8AD650B6-C61B-11E6-9262-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

