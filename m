Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25BF41FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 20:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752142AbdFSUc4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 16:32:56 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:32909 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbdFSUcz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 16:32:55 -0400
Received: by mail-vk0-f54.google.com with SMTP id p62so58813588vkp.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 13:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=PwR4UkyyV3hecwIJN9FfvPJq33DEdr1G/pBFOHBM8Mo=;
        b=u2YZHrcYA/i9Luvn0cZDlxTyOXsJTPN23aLdleWNHsZ+8DxfpHi56PXt8+GtdPyV24
         XkCEsDTOYjFh4PthXO2u22u0mawqfEYbCT4YECl/0yoLYF8QvaFdhvqBEVxmQNgGTBSC
         NwvKTdiNCudFRkHMUbeljRFWq+dQy1JV3WXwsukpuMUYopxeVhIvetCFG4keaZoyeBfC
         QgUBWQMorev82j5Og4i5Fgcjbp/82tB3aDxcXZpprFtj6YZ4cwBAsMsWC9ueazubfSvX
         ym6OcXqmo8oz/8Ykvsrbgt4KMkclVgfalFCIJH+JEojTz3J4737oHpaeyiYslGBsPQjz
         GfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=PwR4UkyyV3hecwIJN9FfvPJq33DEdr1G/pBFOHBM8Mo=;
        b=i8DibNIs8D0nbiNT3Qy9KWjGu3dz3+0s6sTwDJMq5iceipj/LDTh+P4qPVp1xYyUZO
         kdjuX5Ys2CpLcFzPIgFQXEGDppwCzRgBLS5iSaZGuDJ1QVT4AFwMCdshh6koE4WPBeyf
         31RipGarbY/F0Kd29Uq0aXVDydbM3uOpsYEqUId4F7PCxWaPdcilv7Bq57RT36ECXUoh
         ArLlHwGzGzp5donZudQRXLw2iPHL0qjieSQhrVJgsIFHfaEXfPd7vuQQn+EDfCz33b8D
         b2P5aBzAmDXbz12s92yGBzy/Fo6GFe5hCRpcWAFxUvKZG92QtO2/6Me8sp8H67I+NJHe
         G1Ng==
X-Gm-Message-State: AKS2vOz/V4pFba+ZS5MgMwC5kFtJnTqWN7U0ZlGu7ji9OQAWMd8hbheB
        7xo1AE4q83RsuuS244JcmWI+POHiqpDR
X-Received: by 10.31.108.83 with SMTP id h80mr14903907vkc.33.1497904374979;
 Mon, 19 Jun 2017 13:32:54 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.85.157 with HTTP; Mon, 19 Jun 2017 13:32:54 -0700 (PDT)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Mon, 19 Jun 2017 15:32:54 -0500
X-Google-Sender-Auth: 4Q1vvd4yT91pb3anXOeE78QB2o8
Message-ID: <CAHd499C8x_zWJyRNXO-410gxudk897-okJaA3uOPYr38QNHjpA@mail.gmail.com>
Subject: Better usability of stash refs
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To drop a stash, I have to do this (example):

$ git stash drop stash@{3}

Using the full "stash@{N}" seems superfluous since the documentation
states it must be a stash in the first place. It would make more sense
(and be quicker to type) to do:

$ git stash drop 3

Is there a trick I can use to make this shorthand possible? I thought
about creating a "s" script for "stash" that intercepted the
parameters for only a couple of stash sub-commands and created the
ref, but that seems a lot of work.

Any productivity tips here? Thanks in advance.
