Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AABF2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 18:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933181AbdCUSJw (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 14:09:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54191 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757490AbdCUSJM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 14:09:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F5F16E94F;
        Tue, 21 Mar 2017 14:09:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=96LFuW/uIqSQAgX8QuRRpWBD3Hw=; b=RVVgSV
        9VqVRseOwJNBSjiVvXjfSYtf+vPOLghwWrWo6h1jYWN0H47uVc7LFQTR6GWdTcef
        zf18zUvKJ92C/ZX708m6Foe3D1hI0xzKXyF7+UoLRxudQcZWetKr2rmKDlLOBg07
        cTrXFdAlQ5dKTc7dH4CW1NwuORFjxJd0PVqb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X416eRQ/i44iwQjo5Y1HoB3qXUFeOPvF
        MTv5tOTmVz57P1dxW/ptqGZk2V+7Q5McHIvsvq731aTJ6sLLXYAAOTDxrpSBv0vN
        zKfcKFAmD2nlPuz0p8+lCzqCL081VDbiaKUDSJ0+upmDZAGDBDeGHds+IeezhK6v
        9/go2QZ3JEk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 74EEC6E94E;
        Tue, 21 Mar 2017 14:09:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE8726E94D;
        Tue, 21 Mar 2017 14:09:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] l10n: Introduce framework for localizing man pages
References: <20170312200248.3610-1-jn.avila@free.fr>
        <20170320210225.13046-1-jn.avila@free.fr>
        <20170320210225.13046-2-jn.avila@free.fr>
Date:   Tue, 21 Mar 2017 11:09:08 -0700
In-Reply-To: <20170320210225.13046-2-jn.avila@free.fr> (Jean-Noel Avila's
        message of "Mon, 20 Mar 2017 22:02:24 +0100")
Message-ID: <xmqqmvceqz7f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B1AB142-0E61-11E7-BD85-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noel Avila <jn.avila@free.fr> writes:

> @@ -247,6 +260,11 @@ install-man: man
>  	$(INSTALL) -m 644 $(DOC_MAN1) $(DESTDIR)$(man1dir)
>  	$(INSTALL) -m 644 $(DOC_MAN5) $(DESTDIR)$(man5dir)
>  	$(INSTALL) -m 644 $(DOC_MAN7) $(DESTDIR)$(man7dir)
> +	$(MAKE) install-man-l10n

FYI.  Having this line in "install-man" target will invoke the po4a
chain when "make install-doc" is done at the toplevel, so I added a
SQUASH to remove it after queuing your two patches.

Thanks.
