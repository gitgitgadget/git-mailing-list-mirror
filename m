Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E3491F404
	for <e@80x24.org>; Sat, 24 Mar 2018 18:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752608AbeCXSix (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 14:38:53 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:37018 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752579AbeCXSiw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 14:38:52 -0400
Received: by mail-pf0-f177.google.com with SMTP id t16so1737136pfh.4
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 11:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3okOdW+hraQAJSUmtEM5gBn3DfMykfyJANlix/UfBVM=;
        b=yyD2K9hFijBBHJd9d6WTOaOZkkz3m9DV2Lhz0DOAishX+a8+/Uoh/DkGRyON+do5jB
         1D5RfJeSQguGUwj68GXoMC3Kl64BYBVdIGdQPVNyj9klfJVtd6U+l149A1suzI9Ev0XN
         2RnqsuP87VycsVJJ4lfwJac/uYuhDh/uvvh+VVE2w4QUEcgIz0DeujGQ9VGNEMIxT1mQ
         wYO98d7hHPK7pSivYH9+Gw+J3NBkNnUzQtzZKhcgsOYfHeDa0jyKI12DLyDVTgD3rRAv
         8a9a0WXumjyPS+hPQ2cpbPm+Qcd+A/4X27IIPSoREU6wdZeqTSZjAxTEOAuP3DvgLMAR
         NVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3okOdW+hraQAJSUmtEM5gBn3DfMykfyJANlix/UfBVM=;
        b=Vs3UNHwLK+PUb/Iv9Uc5ehVlvbg7dQY4pMbr759KSpYEl5k/gHR1riPvP+SKX+Hysn
         uHFumlmFw9S+QkAz5dYORicoSFmHe+/HdvcmBlq950PzOjza5opVXT/VGe0+fqJLwnQi
         wmaA0WRMIPve/YD50GGDIlX6U598ahDiCPhLV0JsR7JXlW+bJKIREmeSZIG/39KzYSRb
         AjEQtIxHKsweq5jfIwYm4YkfQ+Bs/Zdflwj4yfTJNwjfriRx1EuOG3x43ciuLooh4AOg
         6EUqnTFU9QAZpf/cqeNyhLoSF8Tkpn18YDzmfas3Dlgih3iqrwb+5ugRs5Q6qtaim/Ni
         h73A==
X-Gm-Message-State: AElRT7FXY3V8I1x+rX3/fHLnbCMxeNdDrGRpuQPvbfANkMTb3lDMtj4M
        7/77B5y/qsMEGorjajBIKhlAMMiX6zs=
X-Google-Smtp-Source: AG47ELvXlwznkqa6PPbmTNQQJ6ETQ8uqif50vcSgxNkKgRxYldM17rzY891PndMlsVD4wiWiSPyReQ==
X-Received: by 10.101.73.2 with SMTP id p2mr10077879pgs.397.1521916731024;
        Sat, 24 Mar 2018 11:38:51 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id d12sm22007343pfn.42.2018.03.24.11.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 11:38:49 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, gitster@pobox.com,
        jeffhost@microsoft.com, ramsay@ramsayjones.plus.com
Subject: [RFC PATCH 0/1] json-writer: add cast to uintmax_t
Date:   Sat, 24 Mar 2018 11:38:31 -0700
Message-Id: <cover.1521916335.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521868951.git.wink@saville.com>
References: <cover.1521868951.git.wink@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Building the pu branch at commit 8b49f5c076c using Travis-Ci all linux
builds worked but the two OSX builds failed with:

    CC ident.o
    CC json-writer.o

json-writer.c:123:38: error: format specifies type 'uintmax_t' (aka 'unsigned long') but the argument has type 'uint64_t' (aka 'unsigned long long') [-Werror,-Wformat]

        strbuf_addf(&jw->json, ":%"PRIuMAX, value);

json-writer.c:228:37: error: format specifies type 'uintmax_t' (aka 'unsigned long') but the argument has type 'uint64_t' (aka 'unsigned long long') [-Werror,-Wformat]

        strbuf_addf(&jw->json, "%"PRIuMAX, value);

Corrected in Patch 1/1 by casting value to uintmax_t.

Wink Saville (1):
  json-writer: add cast to uintmax_t

 json-writer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.16.2

