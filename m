Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A34FA2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 21:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933398AbdCUVrS (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 17:47:18 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33878 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933195AbdCUVrR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 17:47:17 -0400
Received: by mail-pf0-f180.google.com with SMTP id p189so62010142pfp.1
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 14:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=nlOm6FoutTJ13cQh3DjyeB8/MgqnAsV7+/joqzt4L5s=;
        b=sOpzAy5oaDrGMTqNIfkJ3okcJ0wTcbW7Oirtae6+OLB3eZn9JLns4xqSLNS2CmKcZS
         x4eqtWDNgzCWbeNzPkJjJ51cqBPr8Iji8+JuXXUchvIG7pY3T/mF8+SpwduhqdcSsNqw
         EqWOZcI77PxaHqkHx9oPqCTKoyvod2krtDrz02nXoeDDPB5CHng5ne44WL6iCPNJqHMT
         +wil401FmpSNhfcEdZorOVoJFCn/+ARauMes7vO0dJ4BBgMnTEdbjU/yDenlMXpSC/dR
         RUZhSObvhn5L1ETtzfXZ2PIi3SwBZOiUMIk3hXeSwjvjAYFO74ZMpr5sl8mS5AyXiJtu
         XeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=nlOm6FoutTJ13cQh3DjyeB8/MgqnAsV7+/joqzt4L5s=;
        b=OpVTIMEsThEUayH9g72lSaQ8Zf/Vnf/vUnQSBNe/UtpkjejKqC0tTE7V5DEj4YgOMy
         lB6gDk3o8l5PRPs6blcA128B/2+UGaEdQOUyv73fRhOpB7SHZCmRKpWDzZmOB8QvJysd
         X2p4kvVnsfjmm5xou0tOwdb8aWIqdV1g1krd7lMfFk/roQL66LZ+pHZmuMtpDJVXGfMR
         POSrcr/2TQaZOdPZHjo0kzMcFUmf7i/1To3+WVpOppMCDULFswueNOzLZ4CKYnUtB90u
         0lct+9LepL1uYx53Mf/gtzFXQ4TwTVk+Ff1vAu/yQ5pnkf9qK9GqCGHvXi82N1agp2TF
         Kt9A==
X-Gm-Message-State: AFeK/H2+b+Nxxe3ZNF+ROYdLhbAv+u670qyXwSu+C9XrcGADDPN4koDPVTcOwzsVuIogMw==
X-Received: by 10.98.15.7 with SMTP id x7mr43161068pfi.217.1490132835391;
        Tue, 21 Mar 2017 14:47:15 -0700 (PDT)
Received: from [192.168.1.134] (68-185-59-186.static.knwc.wa.charter.com. [68.185.59.186])
        by smtp.gmail.com with ESMTPSA id p4sm41684554pgd.50.2017.03.21.14.47.14
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Mar 2017 14:47:14 -0700 (PDT)
From:   Joshua Clayton <stillcompiling@gmail.com>
To:     git@vger.kernel.org
Subject: gitk: bug viewing diffs with the word items
Message-ID: <8cd30c4d-f21d-142b-5444-eb9a3bba5d4f@gmail.com>
Date:   Tue, 21 Mar 2017 14:47:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

I see a bug with the diff view of gitk.

when the text " <items>" or " </items>" appears

on one of the surrounding contexts lines in a diff,

gitk treats it as part of the "Old Version", highlighting it in red,

and hiding it if "New Version" is selected

I don't know if any other magic words are affected

ied it with the master


bug confirmed exists in github/git/git/master

I created a small repository that shows the error for me:

clone it to reproduce the behavior

https://github.com/d4ddi0/gitk_diff_view


~Joshua Clayton

