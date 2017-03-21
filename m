Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A9312095B
	for <e@80x24.org>; Tue, 21 Mar 2017 14:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932402AbdCUObM (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 10:31:12 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:34349 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756517AbdCUObK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 10:31:10 -0400
Received: by mail-wr0-f171.google.com with SMTP id l37so113297099wrc.1
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 07:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hgTw7aUr8fb24Hbg8mnAWfnzo30E5UfRkmItw+gZr2Y=;
        b=sc2KPRn2krZ6zz2QjnY+CNZzEFU/ZEFDkbo3mPecPipoEjuyr+afacdigLkKHtmGn3
         AutOudqHaO0d0Qy3AxrXyqa4+eH3zq7m3tFdRxNEn9ooTFyCJBjh93p8eOtKBYy9y1+M
         Pjn4WNtXfLar2D5qYzmTOcxgM8I5MsUpeY+C65xomq0YkU2vivHOL2ysfz1J1LsPbNDy
         UU53pqwpZdbPV5f4EWxSBewvPdsNyaA9RL478//7iOXx7gMXQ9uL5e8/a0qBCH5Iztj6
         heKOPZ3JZlO13D/d4XDKPboFrPeroxUJ2nRJyBk+6luivxXbkH/oYoZEW8hSbhhNCppg
         kvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hgTw7aUr8fb24Hbg8mnAWfnzo30E5UfRkmItw+gZr2Y=;
        b=NR1ut9iiA3zNfOtQFTbZ6OghdU3mTowkf7d4i7g00u9CaxMQZsZZRg1TniAbSD/TY0
         5UDE4YjgO1040DxoTCAulps+d8tDBanRFm7otbiEkoLuN/XMAYc/qg8yawXUyA9wuFj/
         qUvrNwWYQXVLeR5mZxZ2qTTs56yh9WFeEZIOe1JNwXVEsUTjAC2Rnk2y46A1rtUNRlay
         sR3gHPAQFWhOgdSyXuSKpv7dRIavYTr9TMVaqXLRRLHpzj0BctRL9PmC/thAiuP3zucB
         COktBKnmNwsCW5cZvWRr/eSz/HgN3cs5oEWmvOKXvp/UdqQRUIqzz+BFvmLG6Isc4l/7
         ubag==
X-Gm-Message-State: AFeK/H27OMdokdCv01gBOGXZyz/UcpNg6PWlY3bNnvcQ0zVMRRtezfDaH3SNetcsUd5brw==
X-Received: by 10.223.144.209 with SMTP id i75mr30244702wri.51.1490106125506;
        Tue, 21 Mar 2017 07:22:05 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id s17sm25317092wrc.25.2017.03.21.07.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 07:22:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] A couple of minor improvements
Date:   Tue, 21 Mar 2017 14:21:52 +0000
Message-Id: <20170321142154.16993-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <xmqq37ea2ykh.fsf@gitster.mtv.corp.google.com>
References: <xmqq37ea2ykh.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unchanged from v1 in my <20170318184203.16890-1-avarab@gmail.com>,
except 2/2 changes the "show" command to use --date=short as Junio
suggested in <xmqq37ea2ykh.fsf@gitster.mtv.corp.google.com>.

Ævar Arnfjörð Bjarmason (2):
  doc/SubmittingPatches: clarify the casing convention for "area:
    change..."
  doc/SubmittingPatches: show how to get a CLI commit summary

 Documentation/SubmittingPatches | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

-- 
2.11.0

