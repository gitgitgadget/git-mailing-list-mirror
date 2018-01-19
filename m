Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56FE01FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 00:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932738AbeASABU (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 19:01:20 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:42805 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932854AbeASABI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 19:01:08 -0500
Received: by mail-wm0-f66.google.com with SMTP id b141so235111wme.1
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 16:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=emrf4IGZGWXIDF0vyJ+ubgonDo0o51eyHiQjQF/CJMA=;
        b=fcC2W84e6fSFBHRB5MfeDXtWrglX4Wor4T5cl0AJCHMCgsuu0dwxurSP/dejwTOZR7
         5NaUbT5uQmGpQLiCFs8x4hbRIkYzeYAiTbQbduCYl7NxHjUWCQuJRwVmowYNJAshV9v1
         ZyxqU/PQFqgH/74nvvehUeGdtu5IfAxyNhuQxkHtqANOFj9TBqgX9ModM8oiVkPYOWhZ
         VMlACCGEe9ZQJeKlX1CzkBWTv4hyfFmHPJz/gmRJ9xkTtxpHV9cpO6o2DVpFLHtAksNq
         uorcubY25a3zJ5AjFqKonHo+WjzDAIc2AYz7XcReLR92+OCTIbxtKx+Z31vj4u4c3buC
         iLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=emrf4IGZGWXIDF0vyJ+ubgonDo0o51eyHiQjQF/CJMA=;
        b=ixuMPd8od0d59EDS2D3OjwKJH1pGsVS51soF/W+H2HHVYSwuHUofxi+eHyye3CK/BD
         FmcBHP/9Fl+Jy0m/ocpkeZ8GeQNJsIkPh+voozpLNGgc3jdapq0NjrhJ5bc7csKIOGQZ
         gON+j1Zht9SU/1Ty12HFGREbQx0bJVBoxpWAteW7wy31+yQCl4DOo3rf/glAg0S6+CZI
         GjKm4Vz8nzV89ofkUzvr54RS8aBBaBhIPQxzDWLwwmgPa5IC4QuhvUo0ixEE81PtaGo6
         hy+T9KWehfMa9WIzCXE0aTrVDz89G7j5aGPA2SB9Ykv5bP84wOOjLS/t5mlxPaRgsNBX
         ac1Q==
X-Gm-Message-State: AKwxyteT/nFJSwpxnr+Dtd7noklWCFIWoWN2atG/wb2BCHcX6frIsigy
        KnXkRXVhT2ZCEwDKEMl9scrRNKM/
X-Google-Smtp-Source: ACJfBouiSeCWzA4pIxdtDgwGcSb/Kbv/5xlJvo4EZ6NWeptuvgdiftpo+ihihIiPDsH5qWdalCScwQ==
X-Received: by 10.28.203.135 with SMTP id b129mr5946107wmg.155.1516320067080;
        Thu, 18 Jan 2018 16:01:07 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b48sm17706481wrd.69.2018.01.18.16.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 16:01:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/11] fetch: don't redundantly null something calloc() gave us
Date:   Fri, 19 Jan 2018 00:00:25 +0000
Message-Id: <20180119000027.28898-10-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180119000027.28898-1-avarab@gmail.com>
References: <20180119000027.28898-1-avarab@gmail.com>
In-Reply-To: <87po6ahx87.fsf@evledraar.gmail.com>
References: <87po6ahx87.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop redundantly NULL-ing the last element of the refs structure,
which was retrieved via calloc() and is thus guaranteed to be
pre-NULL'd.

This code dates back to b888d61c83 ("Make fetch a builtin",
2007-09-10), where wasn't any reason to do this back then either, it's
just something left over from when git-fetch was initially introduced.

The initial motivation for this change was to make a subsequent change
which'll also modify the refs variable smaller, since it won't have to
copy this redundant "NULL the last + 1 item" pattern.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7bbcd26faf..b34665db9e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1302,7 +1302,6 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 			} else
 				refs[j++] = argv[i];
 		}
-		refs[j] = NULL;
 		ref_nr = j;
 	}
 
-- 
2.15.1.424.g9478a66081

