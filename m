Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 724FB1FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 00:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755259AbeASA2c (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 19:28:32 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45586 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755130AbeASA2L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 19:28:11 -0500
Received: by mail-pf0-f196.google.com with SMTP id a88so21992pfe.12
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 16:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K5y1ISQBfhdTlgzgofXdkyKQptQ7yfzJGTClDW5W2+A=;
        b=kpJ6cffDuHokK6JKELLUvR2qbuOP5ehN+bWrLEppcOGir2RZ2BgKsX9RxxXEBfSCYE
         hRwR4fz9FyikIihtcack4w+LeBKmLcqtJjHHpPQlZbwNoqyuWjfG9+iPt5BZXfZsTrvK
         xfq+wjao6tx6oItbgoTWsxZohG1fHi4poLdGyC6iUZWPvo4FDZoYa1xO3Pw62qbbvAaH
         F7uB2F5EIqZraD/dzuCJqp0vEEJyozd7SCczBs9xNmUaCQ1bEl+zyTpzrvdbUiU7hez3
         EyDgKI/J4nH3rg3grN6RFcMC31L8YjFJGgJ3PxSb/uiCZM0XdxJBL2SY/qULjbBajexe
         BFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K5y1ISQBfhdTlgzgofXdkyKQptQ7yfzJGTClDW5W2+A=;
        b=UYLoXHFpK3nS6nhsgaRKvXB5Vev/3QrCsqsvYeED9xc4I0nGvAUL7Evbdu6H47me2G
         3g93ztTVwaPjfMF2ECpuJzMbOjTbgPuzue2KsEutKJzpkyAPyLo0zlKIwY9wT+snIN7X
         bEz8QKPAWEMlHjHoGDv1P3VMbV1qEZeEftgOrutKgPqpBjrX9PCrtCnWgOCp+kP8rBmb
         pL24tpdYAjTidaICmiDFNKG+2j/Cz3dF3xMIc0yiUhwal1Dwb9HAPCTbHA8+m8WEe7d7
         Re4qCM+xkrxUDIHzu8ngKLt2jKOfzyBM6KGw+ICD7ilXxWZx9DTwahfgAdNAgvHmtQBe
         ToDw==
X-Gm-Message-State: AKGB3mJs7GQbhxXbyeYF/OEIwjl07wpTWfJHY3uEkbA/f3BxIzb5lmj7
        rLQa9R1qoEMPjqf9M2YYUnDQ8rFuY2A=
X-Google-Smtp-Source: ACJfBosuVxSXA+5XYYg+cYt/iPpNHrQo1qrup0XEZv+6Dh4xJFRhqf0qGe5e0e+WovWgF3KbT0W9Pg==
X-Received: by 10.98.16.132 with SMTP id 4mr37219959pfq.42.1516321690745;
        Thu, 18 Jan 2018 16:28:10 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id t1sm13571469pgs.73.2018.01.18.16.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 16:28:10 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sunshine@sunshineco.com
Subject: [PATCH v2 0/2] Cookie redaction during GIT_TRACE_CURL
Date:   Thu, 18 Jan 2018 16:28:00 -0800
Message-Id: <cover.1516321355.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.16.0.rc2.37.ge0d575025.dirty
In-Reply-To: <cover.1516235197.git.jonathantanmy@google.com>
References: <cover.1516235197.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Eric. Changes in v2:
 - documented all environment variables introduced
 - made test more clear by ensuring that no cookie keys are suffixes or
   prefixes of others
 - tested empty value

As far as I can tell, it does not seem possible that Git generates a
cookie with no equals sign (like "Secure" or "HttpOnly" described in RFC
6265). When I try to craft a cookie file containing that (using
"Set-Cookie: Foo=; HttpOnly", for example), the no-equals-sign cookie
just disappears.

Jonathan Tan (2):
  http: support cookie redaction when tracing
  http: support omitting data from traces

 Documentation/git.txt       | 10 ++++++
 http.c                      | 82 ++++++++++++++++++++++++++++++++++++++++-----
 t/t5551-http-fetch-smart.sh | 33 ++++++++++++++++++
 3 files changed, 117 insertions(+), 8 deletions(-)

-- 
2.16.0.rc2.37.ge0d575025.dirty

