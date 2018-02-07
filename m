Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E33401F404
	for <e@80x24.org>; Wed,  7 Feb 2018 19:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754448AbeBGT0e (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 14:26:34 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38563 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754103AbeBGT0c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 14:26:32 -0500
Received: by mail-wr0-f195.google.com with SMTP id t94so2284339wrc.5
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 11:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=P7hqjRTG25MTUuSz8xJTAj4DBHic9hgw0TAGaMTQ9Uw=;
        b=Anl79bo7hqslUjofjCAlgMmCmN0H/KrevO3WFUaY77G9NQPrhRDb+uQN4rPCZkHkhi
         XYQrfaI07JtK/NGZQFlxS5Tf4w98WuugOY+ocsMnAkyRW3I+MwgXsGWVIsE8LGJnH/UM
         pDQnMkbcE1+UkI+1OY5i4+3BaQvA6zGTqEuje5yE/38VbcSI4gPn5s34R72xMA+joSER
         Vlnw1pdlkfEBRB0KBDVYGTeKarOPeYLXZB1kwouKXWVbx7TkgOAfhsVNy02oLYwIu3Uk
         VCUY8ddpvHU6qsrV3UWuLc9tD/IyLOpCINTelo0ezgJz/QtTOoBs+sBCFDDA3fEjwkvV
         zCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=P7hqjRTG25MTUuSz8xJTAj4DBHic9hgw0TAGaMTQ9Uw=;
        b=tc0tm109m2M7/ZMZxuDxQsM1G9KWyKvpmji73MNPrJZeW/rBmmMPg3k+siTqCbPBqO
         dReNIFuLJlQb6ar9eKHJGMIAglEOV5PNR5Qh2fh+RXYhwVXrUYjLStOk0SaLFvcg8rXO
         p0DKHmJZBLDPfpFSfUP43sSE1j88UNVXISUFJmhkB3XHvAN+CaaVy7pOCKP3QNR77rUC
         fSs+aCbXiGr0QbPmIkPIbKEAJ/mUKEwbCqlOAu6TRldUlFrUc8r7FhJx+xWsM00wrwzZ
         Ph7CVnHR/1k4dSM9AW/zHaZ0to0brgdju5VUsumu5B6xm5hXDwuisJzRP/obK6h4RCI6
         0gqQ==
X-Gm-Message-State: APf1xPDEPuhL8coQLSrFXfE3pxb/hhS7goKB2X1w3zbnGIVCb/ekrauk
        P2cxv5bKA0gzOTdimKXl53c=
X-Google-Smtp-Source: AH8x2277m0m76inyZSDSxJTzVWqFCqFrLrl+IM4bXw2DbMQxh662xbWYOOqWiZGq7ARrY0CQ/mjS9w==
X-Received: by 10.223.187.10 with SMTP id r10mr6602111wrg.177.1518031591546;
        Wed, 07 Feb 2018 11:26:31 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h200sm2144551wme.11.2018.02.07.11.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Feb 2018 11:26:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Genki Sky <sky@genki.is>, git@vger.kernel.org
Subject: Re: [PATCH v2] rebase: add --allow-empty-message option
References: <9d0414b869f21f38b81f92ee0619fd76410cbcfc.1517552392.git.sky@genki.is>
        <05bedbb20d5f02a9fe1a74996038f7ca42e35829.1517774326.git.sky@genki.is>
        <nycvar.QRO.7.76.6.1802061552090.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Wed, 07 Feb 2018 11:26:30 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1802061552090.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Tue, 6 Feb 2018 15:53:46 +0100
        (STD)")
Message-ID: <xmqqmv0k7g9l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Very nice. I looked over the patch (sorry, I have too little time to test
> this thoroughly, but then, it is the custom on this here mailing list to
> just review the patch as per the mail) and it looks very good to me.
>
> Junio, if you like, please add a "Reviewed-by:" line for me.

Will do.  You do not have to apologize for not "testing" it; nobody
expects _you_ to test every change you come across on the list, and
other people (including the CI) are testing without advertising ;-).




