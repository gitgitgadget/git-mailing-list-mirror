Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 187991F453
	for <e@80x24.org>; Tue, 22 Jan 2019 00:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfAVAak (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 19:30:40 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:34587 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfAVAak (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 19:30:40 -0500
Received: by mail-pf1-f172.google.com with SMTP id h3so10874611pfg.1
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 16:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sN95V7vrox+M3bGdYj8Rnl9bJ2nyHjoXUOXJb6xt1Wg=;
        b=fnI9hC1e/CexRxpVIonsVQ6XbSff2CSi7i2DpQYnawEsxh+heOv3mOlvck53hDg6yK
         B20cPTUhzrcNPB6zGPlZhN+8PcFQN5D7jwwD5+C2TEsELzpSGFqacir4ivAygoMXStvl
         p77NFL+/I3Ky/7sjb/Web2WuaHBEig8ln9BW+RkzMwd2F5wcomklIFVOTvDnFNE8VBXE
         WECHV7QymYw7EHMiUC5xt2Mp+TSnu1O5BY6g7nEoQsKn5dUeR1DUE77QJcaRftyZjihe
         JTuQbAP8FJYzVgutdewt2JYCuCS3LWICUa+LGX/F3zUculjoFsESQWW8kEVaHEvkq021
         IIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sN95V7vrox+M3bGdYj8Rnl9bJ2nyHjoXUOXJb6xt1Wg=;
        b=Szs167hhV4zND/aCIEPKmFWvb9Pyhxf0RM2Zf/ucLeLmvv8r/Fe7BSNVRPlLMosS6X
         gwpUbdXJSIi7VUSE3u9TX2kY7JfPH6HE04vlufUCGW2EInzEUUAguDbEmRfi7JqkyrkD
         lHZaWaXn72Cz6VnqR/5B/V7URMe6kJnFei5Mb/fsytb6f7q1HTf3lafgysxniHxDwg2/
         rEuvtrrBI0odgk/2DP/ZCUtnCPrvE4ggdPzTJ9a6Vqm0LD90PnUTNyXwa7gUOvnnZLpa
         CLZz4W8WtbZ9knIXttVbzRWRjqBSSKwcFErakXAkTCOvQLyx24ZOT8GuNpnFvvHFVwcT
         GAlw==
X-Gm-Message-State: AJcUukepN0ah69Z9ZKyTes1S5o5/rzP76oCGESG5qWeEIx8ei4VI2BYS
        xuBry7te11lLK1oBDP7lmNPY8MX5
X-Google-Smtp-Source: ALg8bN6idOR2pFgXvOeM3VS6qoibZUcy63qS77OdbKtddRXiGcGtLKZ2nPQP5ZMQlHizCuRR7KCNjA==
X-Received: by 2002:a63:f1f:: with SMTP id e31mr29655988pgl.274.1548117039743;
        Mon, 21 Jan 2019 16:30:39 -0800 (PST)
Received: from dektop.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id p77sm26157897pfi.85.2019.01.21.16.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 16:30:39 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 0/3] nd/diff-parseopt fixups
Date:   Tue, 22 Jan 2019 07:30:17 +0700
Message-Id: <20190122003020.9672-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190122002635.9411-1-pclouds@gmail.com>
References: <20190122002635.9411-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Resend with s-o-b. Oops.

Nguyễn Thái Ngọc Duy (3):
  Revert "parse-options: allow keep-unknown + stop-at-non-opt
    combination"
  diff.c: delete unused functions
  diff.c: simplify diff_opt_break_rewrites()

 diff.c          | 74 ++-----------------------------------------------
 parse-options.c |  4 +++
 2 files changed, 6 insertions(+), 72 deletions(-)

-- 
2.20.1.560.g70ca8b83ee

