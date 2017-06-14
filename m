Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FB7120282
	for <e@80x24.org>; Wed, 14 Jun 2017 18:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbdFNSHt (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 14:07:49 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36568 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752790AbdFNSHr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 14:07:47 -0400
Received: by mail-pf0-f181.google.com with SMTP id x63so3914994pff.3
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 11:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F3U7KRJh9IcEzDGpyOe/ehY0om2xdvqRmQQiSAWDgJ4=;
        b=XXOXieThtBsKvSdc47HfUHEeVB5S4m4+z9riyHBH00e7+12CfwM1et959rqHaACbeO
         XH/2aGZicNglDYV8t4eybRgx50bshMGkht4j/39/kpDyp1W+DSR5x/dKqgrIwMr9NkS/
         Otiau/xDLjDn+zsT+nT7E6wH4wW9l7q8b8vNwyzU/pVBkgPJsGqZhZvSfXbLsDh58Bcf
         gx4NqW0Dg8n7207it6t+MgHPmGm2F3rfwjeaW1+CoxPdy3OZz+lV1v7BxvYzC1928nhB
         PYO5SP5gYQVdez83n+6MRhgUeAJiG48UwspVyRD0Hq0vpaHChKXM3IgmF395VW4qkvks
         EnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F3U7KRJh9IcEzDGpyOe/ehY0om2xdvqRmQQiSAWDgJ4=;
        b=HEgsHa50ISV86z18EAivFNqa3J3pHwSIRIOTLvCv/DVg81EHxIdrvjtjv2Z7n9lGRQ
         M68HOl2ZGlCPxD1e6P4NuAXHUo90o01Uhz8oj7ZscHVO3SE9KVcPEJAfKaA80gya3vz4
         K1od8MgdXaBvgTfLuYggURReOSwoPXgRK6NFy1BmSJTIgq9VrI058+FC2r3BznL261az
         YLGumivvAdr13Zyzb3lOtN0DptP/u1w/IvF9GcAb19fM02TFfHU0IrVBlzY/70bsfFxj
         PeHJ7KBekl0R+xgKI3lXqPJlGhxFq/0yyWUF8TxJgv3lurK8SaM7VQdGris5og4Ppz3d
         9nvA==
X-Gm-Message-State: AKS2vOyR0Rngy890AXWp3MwSyK6TBSwTb/wmiQXaZihSPdO1qy9jmXBg
        B5vuF1vZYbYnVWNBXfZhYg==
X-Received: by 10.84.128.68 with SMTP id 62mr1470830pla.184.1497463666744;
        Wed, 14 Jun 2017 11:07:46 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t2sm1001646pfi.76.2017.06.14.11.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 11:07:45 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 2/6] config: remove git_config_iter
Date:   Wed, 14 Jun 2017 11:07:35 -0700
Message-Id: <20170614180739.72193-3-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170614180739.72193-1-bmwill@google.com>
References: <20170613210321.152978-1-bmwill@google.com>
 <20170614180739.72193-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since there is no implementation of the function 'git_config_iter',
let's stop exporting it and remove the prototype from config.h.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 config.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.h b/config.h
index f7f8b66c5..c70599bd5 100644
--- a/config.h
+++ b/config.h
@@ -165,7 +165,6 @@ extern int git_configset_get_pathname(struct config_set *cs, const char *key, co
 extern int git_config_get_value(const char *key, const char **value);
 extern const struct string_list *git_config_get_value_multi(const char *key);
 extern void git_config_clear(void);
-extern void git_config_iter(config_fn_t fn, void *data);
 extern int git_config_get_string_const(const char *key, const char **dest);
 extern int git_config_get_string(const char *key, char **dest);
 extern int git_config_get_int(const char *key, int *dest);
-- 
2.13.1.518.g3df882009-goog

