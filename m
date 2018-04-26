Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 802A81F424
	for <e@80x24.org>; Thu, 26 Apr 2018 17:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756879AbeDZRPs (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 13:15:48 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46478 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754419AbeDZRPp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 13:15:45 -0400
Received: by mail-lf0-f65.google.com with SMTP id v85-v6so10287601lfa.13
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 10:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EW4zA7KcPJ/BXl1q8Xd4uFCJS1Wy4YNx/h5+VorIMbo=;
        b=ezDBksbE8jCr4rIpOPe0F+Cx1gRIwlhAnV/Tmi2SBTE4K6w/ZeNG+BYbJP9+wY+AaC
         4YU38KZBjgSvGJpjMYKp2Nl49VOyjPx3ZtkKXr4eyU+V66lCGQHS+Ul2Z3HwM7WSpu9K
         tYlSh/3WwjrFkWIKBGzDR20W2k5tX8clEumCopStrj8QpvcuRruNmcC/Eh9/aYnc5tXy
         tzm+xL8SP0RgGETkwohfSw8nnDEDIM452O+JdteXmVtax/S9JxCjWYkggbvcqK0rTJkH
         DegIZUk3lnEba+/AYgg8xi8CDq6ik9jBsYVONDL1RBiFCg9Nbj/eEyWx+/DPZbEtoxAJ
         e7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EW4zA7KcPJ/BXl1q8Xd4uFCJS1Wy4YNx/h5+VorIMbo=;
        b=Uf1xxKnmQjCCPo1+ZGFxff/9yCJR6pOCNk7Q2ZHhF8LcRdQEoItAByzGPrVlUMhmhe
         CIxqhWDKbvBTbHLSxXIiKB0Uu5fUK98QAUs/YBWN9HfF0HFxobNq0riSjPU+NDsVWVxn
         hu+oBpjCMuvxqBm3vBedGrzygWBKafEjUR1SnU1KMF3eylNQi/T7J5CH8J4G3iKjVmpQ
         Rsy963TjICt+1hCj73xZYc8zmi++lBg6wTFJTg3iIb/m7hMeVi/UvYUaltD7MAoBzbxr
         Oiwhx4zIWy6XUJCiNTtvxLyj/llSP2gmAFDIHRUNZh6UFuEVxrUFXFt3T0uVwJWFQfsX
         yfow==
X-Gm-Message-State: ALQs6tADXbJVRHht4nPY/VqY/u9br4RzM6uiB9ugm/MdIWnpKYbu6Cq2
        jxlNcI/ReLhS1lwefWMC15A=
X-Google-Smtp-Source: AB8JxZrzaSs3yjX5tiuA3tqSnQaJ97n8rQZGO28vcDm073dkdcBkORgyt3Wl8d0s8iLo7q3B3ANeqQ==
X-Received: by 2002:a19:7113:: with SMTP id m19-v6mr18163614lfc.96.1524762943784;
        Thu, 26 Apr 2018 10:15:43 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id 22sm3835293ljv.45.2018.04.26.10.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Apr 2018 10:15:42 -0700 (PDT)
Date:   Thu, 26 Apr 2018 19:15:40 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
Message-ID: <20180426171540.GA2037@duynguyen.home>
References: <20180413170129.15310-1-mgorny@gentoo.org>
 <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
 <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com>
 <871sf3el01.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871sf3el01.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 25, 2018 at 10:41:18AM +0200, Ævar Arnfjörð Bjarmason wrote:
>  2. Add some config so we can have hook search paths, and ship with a
>     default search path for hooks shipped with git.

I would go for something like this instead of search paths. This
allows you to specify a path to any specific hook in hooks.* config
group. This is basically "$GIT_DIR/hooks directory in config file" but
with lower priority than those in $GIT_DIR/hooks.

Now we can do something like


    git -c hooks.post-checkout=/path/to/some/script clone ...

but of course I would need to fix the FIXME or this hook config is
only effective just this one time. (And of course you could put it in
~/.gitconfig)

-- 8< --
diff --git a/builtin/clone.c b/builtin/clone.c
index 7df5932b85..143413ed2d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1063,6 +1063,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
 	}
 
+	/*
+	 * FIXME: we should keep all custom config settings via
+	 * "git  -c ..." in $GIT_DIR/config.
+	 */
+
 	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
 	strbuf_addf(&key, "remote.%s.url", option_origin);
 	git_config_set(key.buf, repo);
diff --git a/run-command.c b/run-command.c
index 84899e423f..ee5b6ea329 100644
--- a/run-command.c
+++ b/run-command.c
@@ -7,6 +7,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "quote.h"
+#include "config.h"
 
 void child_process_init(struct child_process *child)
 {
@@ -1256,6 +1257,8 @@ const char *find_hook(const char *name)
 	strbuf_reset(&path);
 	strbuf_git_path(&path, "hooks/%s", name);
 	if (access(path.buf, X_OK) < 0) {
+		const char *cfg_hook;
+		struct strbuf cfg_key = STRBUF_INIT;
 		int err = errno;
 
 #ifdef STRIP_EXTENSION
@@ -1278,9 +1281,14 @@ const char *find_hook(const char *name)
 				       path.buf);
 			}
 		}
-		return NULL;
+
+		strbuf_reset(&path);
+		strbuf_addf(&cfg_key, "hooks.%s", name);
+		if (!git_config_get_pathname(cfg_key.buf, &cfg_hook))
+			strbuf_addstr(&path, cfg_hook);
+		strbuf_release(&cfg_key);
 	}
-	return path.buf;
+	return path.len ? path.buf : NULL;
 }
 
 int run_hook_ve(const char *const *env, const char *name, va_list args)
-- 8< --
--
Duy
