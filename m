Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8D2A20248
	for <e@80x24.org>; Tue, 26 Feb 2019 21:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfBZVKM (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 16:10:12 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:35562 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfBZVKM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 16:10:12 -0500
Received: by mail-ed1-f52.google.com with SMTP id g19so12060157edp.2
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 13:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cwMa/U75Dz5Ytm5d5p5Ev3gEcVTbPfBhuQOZWxgl6qw=;
        b=rO0a47GFNGkWdK6a2t/9c4clbuKW74dFh75M+cgNBqW6WjpWTY05jQILRHL1p5HeQh
         8/rH5QsiZeHVwsPyi5wJkxPTWHa4bF9/Tqj6H5tf/h+chk/zrvGjIO78JfZRxkFg1Tw/
         J9N4araWGnfIpPRMDrjRJomlGL+L9qA85Hag5EELie95XkSmeCwdy3SxpvBCmO6o4H1B
         Cf1fQH/eiMos2fkvS/YOgok2x/Pz0qJzcCZaM003GOGFzCcoMYVXKWG5kINYq86nYVLp
         D5v+hu4iiyYvzuT4WPP7nxlvqFWdCr3dx1UE+DFtpnwoh17Hxyu9rjVGVSRVdGxECfyc
         wEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cwMa/U75Dz5Ytm5d5p5Ev3gEcVTbPfBhuQOZWxgl6qw=;
        b=pXT43opfpRV98JXHl8abiOcoWe4jSTWkiUYxLT10jdjzB3qVLmS+5P84Q1V256wgZE
         fyOXtnj3ONQz9PrMiKOVc9TuCVPXMNzom9BUOwVAZ8KKlztXz1LVd9Q0XIdKN0CroVLx
         8t/28OZK1oP2I71fMRnT4OD95qRkhOOu1EshhiGHRd2N2aDkZs4REMfeUs1ROppPDfy7
         9TGbNFJp+Agdpbub/hUFPnHfRWisPLaKHSiliWlCUccUDoOLzslBc8gPMIVm/hBjjdSL
         lvpOVMIX2bgWcsYz3gY7v3fULBF/qGrJKpVaL3ZCWtGxFRmi6sY1/r/XWlz2f6kEP4Xt
         jWWA==
X-Gm-Message-State: AHQUAuYXlnnihpADX1KwwzfucmAOMMQBiYYUCkjGt7EzDR3nWM8AdQSO
        GI1NI+tKqRmq2qUvSy1br9w0yJlxpuRY5GcmEBE=
X-Google-Smtp-Source: AHgI3IZwSy7dEFU0Kpc+oWZQwu9SHgv+dvqP8cfZnoAf97GpeloKRBLVPZJPyuhGQ+rSTD4Zdcf2PSZBRxwAzFW48TE=
X-Received: by 2002:a50:94ea:: with SMTP id t39mr18501143eda.262.1551215410506;
 Tue, 26 Feb 2019 13:10:10 -0800 (PST)
MIME-Version: 1.0
References: <0Lfolq-1hNWbf1RUI-00pI54@mail.gmx.com>
In-Reply-To: <0Lfolq-1hNWbf1RUI-00pI54@mail.gmx.com>
From:   =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>
Date:   Tue, 26 Feb 2019 21:09:34 +0000
Message-ID: <CACUQV58Bh-m5Yati2A0hd+7dwJztc=+JkY5x-YAgABe+JP6xFA@mail.gmail.com>
Subject: Re: Bug: "orphaned" trees indistinguishable in git log --graph output
To:     Stefan Tauner <stefan.tauner@gmx.at>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This issue was mentioned previously here in the mailing list.
Here it is for reference:
https://public-inbox.org/git/3305f7dc-0044-41fe-8aab-ee800535d6e9@kde.org/

Cheers,
Rafael Ascens=C3=A3o
