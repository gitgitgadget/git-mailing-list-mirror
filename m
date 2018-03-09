Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3EDF1F404
	for <e@80x24.org>; Fri,  9 Mar 2018 13:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbeCINNu (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 08:13:50 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44211 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeCINNt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 08:13:49 -0500
Received: by mail-pg0-f65.google.com with SMTP id l4so3529613pgp.11
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 05:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mqFrZJ0svCFTxWICdLdw0BS7tj7PtblzJDzEdR0D25w=;
        b=S+UscQdgrUQ8sUD+GtEaXG5PpVc/eK2DJslvlx2QE/E1Oquu17fV55JWACbwvEfcz2
         fR7rSM9yqZIY4ckoux8J3xCYPqCgpF7fY0UTrTMGgK0eVWxmESXWJFLtizrU/mN7CoOy
         JfhQboA8rHXJUeAXmXQaT2uTmmtIIPxa8rxM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mqFrZJ0svCFTxWICdLdw0BS7tj7PtblzJDzEdR0D25w=;
        b=NZ1pYti1TMJxnJp3qjSh/r1P7sdcdHFXqmsLRv2x94W2AL85U4Wis40NW2gDkLp856
         ZcDWOiiYGG7WsOxX+8vE2X3PYWhyCQfg9dM6oY5sKLLvYwfiLy/IgnWDdoCsETPlR9sy
         C0iiVFAE3MZOJhtpgGZaGlEACgoC2dxQyxVNNCst61bU6iFWXag3qpmjAiXM21ucGc/i
         8Ax5BfaEJ+8yNPX/OPCPAThcMfcbRMuXLuCLCB1+h+J32QL8TZoSOZO/3/+0kuj8ry4U
         mFhlxzcOTtC4gjbkTzHSK4ikXWAZAOVDnMjTmgwZHkLAkbjcFLpb9wHo2eEp2T2NbMJg
         lHnA==
X-Gm-Message-State: APf1xPDmngWa2fzzRWcoVsAjnBQCNtsrVQQRszeblqHJm+dqXZQGhIb7
        L6SpZhIOgo+xM7Qk2RJfCpPmT0xRbOM=
X-Google-Smtp-Source: AG47ELvaS3kGSMgppsx98PZDYj/zp40hanRqZCGXcea1H+9mu2BJmJqkG0MGx18n9rT0SElYTXQgLw==
X-Received: by 10.98.73.89 with SMTP id w86mr29890309pfa.227.1520601229037;
        Fri, 09 Mar 2018 05:13:49 -0800 (PST)
Received: from tikuta.tok.corp.google.com ([2401:fa00:4:1002:bd1d:996:abff:29d])
        by smtp.gmail.com with ESMTPSA id b5sm3255132pfc.12.2018.03.09.05.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Mar 2018 05:13:48 -0800 (PST)
From:   Takuto Ikuta <tikuta@chromium.org>
To:     git@vger.kernel.org
Cc:     Takuto Ikuta <tikuta@chromium.org>
Subject: [PATCH v2 0/1] fetch-pack.c: use oidset to check existence of loose object
Date:   Fri,  9 Mar 2018 22:11:35 +0900
Message-Id: <20180309131136.219303-1-tikuta@chromium.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <xmqqr2ouwgsd.fsf@gitster-ct.c.googlers.com>
References: <xmqqr2ouwgsd.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I removed unnecessary type cast, added comment in everthing_local(...),
changed flag name and updated description.

Takuto Ikuta (1):
  fetch-pack.c: use oidset to check existence of loose object

 cache.h      |  2 ++
 fetch-pack.c | 26 +++++++++++++++++++++++---
 sha1_file.c  |  3 +++
 3 files changed, 28 insertions(+), 3 deletions(-)

--
2.16.2
