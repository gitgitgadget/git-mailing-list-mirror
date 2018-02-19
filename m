Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE4591F404
	for <e@80x24.org>; Mon, 19 Feb 2018 18:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932074AbeBSSwh (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 13:52:37 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36207 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932067AbeBSSwg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 13:52:36 -0500
Received: by mail-qt0-f170.google.com with SMTP id q18so13453374qtl.3
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 10:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8cnOWeeuZ6t4qjs5+rGXBgbGRillLGaNQFrTHGNnzfw=;
        b=mRiPlqghkeRDmt74+6/6IR2bNNIDPWBuLliYAPkYCU8SoC/FRsuAl5LgDnFtdLxz9K
         9AvybImREmpgt+ObimE1lvT7zjYEQkjTerjEOBpo/5wIJnc+PmDpqn27HQzhPLa5Bs+k
         dW3tKCkixBsB0f2jTCpB6kZcVghZ06G2yV97CNl2V5V6H8Yj4z1U6TvXZi0DtMcsOgbA
         /ggyB0iErfKrCoKEsQjo7SvmVFybVWonPXYz/wqqF5dbosxWS0HtjCbm4hK8cf7yDHFr
         +ioSD6SHfTnR8V5osQ3OQK/PpgjezFi7ixjZIA3ddbSdtS9dMwFPMxdNdQKiH5DvrvfU
         Jycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8cnOWeeuZ6t4qjs5+rGXBgbGRillLGaNQFrTHGNnzfw=;
        b=pX0kAgvp8a30DljawZx38+5qDGAkZCYDnfs6P5wNBELhqs3zZ5MqVUNo8eCKB0Wur1
         r27O1QtkGYjLYMw+4s/QxCu5c+1lcQsvFq0mPWVfyy1Y0mks0Z/5Bn+yK0R38bkGth4L
         KJ5fB41ufWhEw/jfQ5MDl2xyLFQ2JXc52SUga+TX5wragPwRPCG2YQXlihQosruP5/MH
         vl4kH0VmmrZn7VTAJCKkPk3TXN7erRU8g3ERIYyI//jh75E9J8oerCilnlOb0X0+xEsC
         DT3dnjr0tswoaDYHkNatHLrPX6/1wAg2Pe2Rxp6vZ/yNrmo/vJBFWP+bRD2Ji/CM1dPh
         Iugw==
X-Gm-Message-State: APf1xPD1tiWlm3RUAqe838vhVgMjtsl5fWpcEsRUT3IYD1JbYE4TvTZL
        5uMnYW8JGINHt3ZaVNFckV+FMcwVMO3xffBjj0w=
X-Google-Smtp-Source: AH8x225vaAWkvdLB/EGYdDk9jPMYGFxXA3F+IpTfXUu4GvQtYrFBIqYFikX1+EBHtLVpQKBB/6GnKkZ4VqYdFzwLmDE=
X-Received: by 10.237.45.226 with SMTP id i89mr17315748qtd.246.1519066355384;
 Mon, 19 Feb 2018 10:52:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.143.26 with HTTP; Mon, 19 Feb 2018 10:52:34 -0800 (PST)
In-Reply-To: <20180219112910.24471-5-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180219112910.24471-1-phillip.wood@talktalk.net> <20180219112910.24471-5-phillip.wood@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 19 Feb 2018 13:52:34 -0500
X-Google-Sender-Auth: lBVzvLKoEWESfYmJMrDYgENoQ5M
Message-ID: <CAPig+cRUrct06AxgW6BgsDFPq2i_MpD8OOR_Ks_Kko_AYOQMcA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] t3701: don't hard code sha1 hash values
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 19, 2018 at 6:29 AM, Phillip Wood <phillip.wood@talktalk.net> wrote:
> Purge the index lines from diffs so we're not hard coding sha1 hash
> values in the expected output.

Perhaps the commit message could provide a bit more explanation about
why this is a good idea. For instance, briefly mention that doing so
will ease Git's transition from SHA1 to some newer hash function.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
