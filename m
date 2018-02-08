Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05D881F404
	for <e@80x24.org>; Thu,  8 Feb 2018 16:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752266AbeBHQUA (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 11:20:00 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32936 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752166AbeBHQT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 11:19:59 -0500
Received: by mail-wr0-f193.google.com with SMTP id s5so5326125wra.0
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 08:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2atKY5JP9RSZ2WcFH5EVwuioWXGE6N4BpO6l4lXokA4=;
        b=j305bstUPscm53dpeDnU2DyVFN9U0SGGmz2w/5HAQ/hZVic0M6/nfXLS8Z1kCylp6N
         L2N/n/VR3BUUGsPEExox2uPXdO0w0ipkuyNgoiNAm9xeJogUrKhWyJHQ3GOhS/p/NmP4
         ZXWk27HEHQ31oOx4+qgod7cUORJUCy7aqh8tWCFlzupf0I7ZBcVpS9mHKmrE2rNUl2+p
         Nbvtro9zIgpkDbfhppr7v/9OoSFWppBVzDQGESwzImuc5Hz7EUzISu+DVWdQeQxGo9qM
         +uzSVAjzoSr1/R/88M86+NMpXcczCFng90tBdVrFA3+bITTIsnLbB+10TuBeMIreln8r
         EURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2atKY5JP9RSZ2WcFH5EVwuioWXGE6N4BpO6l4lXokA4=;
        b=jXBJO0dDjhuBpO7zl7NRuINbn8Mz5dvNNYnGJ/2yAplVs8QiUP0aN5rN7Mn/eopJ4a
         Bhvem6hUoUM7Q8trajnDquiEMp7N9zD7lsoXdIkhmqZQEr6mP5VdaSr/HlHZwZp6oXOW
         KoaWeHBRWmeQxwzxeCm8A7zhMkk3e7wgmQ58KYsyrB/ZexiWb2W7MDldguT4GLJClw81
         YQNXH2Dhiew1SC2ZS86RTMLXHIiUK5q9y11wLRbz1DsxBkQoSsx+64YFfHbhU/KOclJe
         Zds1BPZkVUSWi1BWclK503qyhPhRrRoGMMLe4WhzbjW0j0KzNLrVQt9QfN4Chpt3BBr+
         211w==
X-Gm-Message-State: APf1xPAcd9j1SpFdR/dEv6GnKYsFVDs/rsDLrI0YIONmXTZMowG0YWZU
        Iu/a95fqHbgEFVCppmYbz1TPU9iq
X-Google-Smtp-Source: AH8x226H16tPhpH0BXfUWgrzRMjzYvVH6yaUt23BzzXdZtG3RYi+kMpQbeU6/A75z7PN/uQt5VJtvA==
X-Received: by 10.223.134.68 with SMTP id 4mr1296677wrw.218.1518106797611;
        Thu, 08 Feb 2018 08:19:57 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m1sm332532wrb.78.2018.02.08.08.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2018 08:19:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/17] fetch: don't redundantly NULL something calloc() gave us
Date:   Thu,  8 Feb 2018 16:19:20 +0000
Message-Id: <20180208161936.8196-2-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180208161936.8196-1-avarab@gmail.com>
References: <20180208161936.8196-1-avarab@gmail.com>
In-Reply-To: <20180123221326.28495-1-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop redundantly NULL-ing the last element of the refs structure,
which was retrieved via calloc(), and is thus guaranteed to be
pre-NULL'd.

This code dates back to b888d61c83 ("Make fetch a builtin",
2007-09-10), where wasn't any reason to do this back then either, it's
just boilerplate left over from when git-fetch was initially
introduced.

The motivation for this change was to make a subsequent change which
would also modify the refs variable smaller, since it won't have to
copy this redundant "NULL the last + 1 item" pattern.

We may not end up keeping that change, but as this pattern is still
pointless, so let's fix it.

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

