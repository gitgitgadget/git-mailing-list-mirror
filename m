Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B06A0207EC
	for <e@80x24.org>; Wed,  5 Oct 2016 11:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbcJELid (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 07:38:33 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38397 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbcJELid (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 07:38:33 -0400
Received: by mail-wm0-f45.google.com with SMTP id p138so268688400wmb.1
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 04:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=y+N1rmFjTOzbljwimcZZHwKpsk/3JRaAe+Cu17ct2xQ=;
        b=V5LAzWGuziv1ifkzaaa3Tcd/33oBNihgwpwsGiIOx6frvYxXSDwdgOEVKvw9Kzo6SO
         L9QC/CscDbVUqfrcx3zt79/V4f9LpgMF8MDo5LyVtFMzFnTbEbc7+WO58l9jALmMyJZH
         NzWg3Y86trDPZQZnjZRJ0BcXkfU2aH0n3TdrdbxqRZp6hx//vQvLcAoloiOZqFaX/OCn
         cBO08nSF+O+VcuBTSLcbsu8q1E8PBuh9xD0Q7Z3/e+vrSfizAnSRPiST+IPngIATHEK7
         r57Br0vzvu+CAH1q9gYLayT936qVlJ32S3im3bh9jzqmtEerVKVt1kN4656CMHmPxYmE
         HUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=y+N1rmFjTOzbljwimcZZHwKpsk/3JRaAe+Cu17ct2xQ=;
        b=PTxR76fA7o0VoarC8pSdMKZojcNPxw8fGvlqJwehb6co5RjCryJT2Gk3fna2A0CQtO
         +CwKBBaxBUCdExf6wNxvURgqXyjjU9QTBOb0IdhDZP+uu1hs4FAdzJHUwokAK8vIEukP
         oqFPoKYooIekWKua/62h05jxTbrCCJprFM8p/8S9tJs6AUAMxUazfeH7WOBAWeE5jNPC
         yG1hEnRU93CHQkGVf9jBAhz65IHidsESISHl8MssCA6btw//8panY2eMJZiiZtD+9cHs
         m+EEPWe0ESWXihDefOjzSRbM4bmYsM/tXyrohKvpMocCpr/FNedTVQr/tGuy0qLM4uOK
         2qfQ==
X-Gm-Message-State: AA6/9RlS7/Rth/bPtm/H3dkNS2Mdv7hOf2TRp8GsGN3kj8WIzqIfq55VPk/gm6OqiFQpvw==
X-Received: by 10.194.28.5 with SMTP id x5mr8399151wjg.63.1475667511153;
        Wed, 05 Oct 2016 04:38:31 -0700 (PDT)
Received: from juno.home.vuxu.org ([2001:4ca0:0:f231:a288:b4ff:fea1:ce50])
        by smtp.gmail.com with ESMTPSA id lj2sm8505495wjc.38.2016.10.05.04.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Oct 2016 04:38:29 -0700 (PDT)
Received: from localhost (juno.home.vuxu.org [local])
        by juno.home.vuxu.org (OpenSMTPD) with ESMTPA id 04137a71;
        Wed, 5 Oct 2016 11:38:28 +0000 (UTC)
From:   Christian Neukirchen <chneukirchen@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit -p with file arguments
References: <87zinmhx68.fsf@juno.home.vuxu.org>
        <CACsJy8DOqoW8quz-6qSVR2+3aJau2V=qXCx_SoZvBpmU+9+Oxw@mail.gmail.com>
        <20161005102633.GA9948@ash>
Date:   Wed, 05 Oct 2016 13:38:28 +0200
In-Reply-To: <20161005102633.GA9948@ash> (Duy Nguyen's message of "Wed, 5 Oct
        2016 17:26:33 +0700")
Message-ID: <87k2dnowjv.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> At the least I think we should clarify this in the document.
>
> How about something like this? Would it help?

I think it captures the current behavior well.

-- 
Christian Neukirchen  <chneukirchen@gmail.com>  http://chneukirchen.org
