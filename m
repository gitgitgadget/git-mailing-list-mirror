Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44C041F597
	for <e@80x24.org>; Mon, 30 Jul 2018 21:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbeG3XQt (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 19:16:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32873 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbeG3XQs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 19:16:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id g6-v6so14409428wrp.0
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 14:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gTpKQhsjSlBP+17PRep5DAEEn2SaBdsnd1zyzaXAVcE=;
        b=hpUrnx6XRLlFrbCpSeKBesDB3wUgUY3qP5H4lggbYrzGSAUjXpg3rSaTKWGVAaCOyM
         RBxIQ6jUJDMOx4r87P6AtbYpgf/vFQRKqf1+CZ6wotNa1M+9WgkAFu+CABGhEMCCs0SN
         ujDYCkyArfFpSosFT4FukplS/fF80DhKUZ/ehv7FQLnBokmNv7hyJcKqa6KeAHDVipZp
         D32QvfaqFyajTUqymulCEtAwjadn8nmnJ4JGGigMk4QtzDslcWax+fdFaQOsSA62lwpY
         qnPsy1jhfiL7ENkzIogDprUyyHwNwYlmSljunUYcmpbAoCjgniQUJDEVyo3LrWUVOFVf
         tC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gTpKQhsjSlBP+17PRep5DAEEn2SaBdsnd1zyzaXAVcE=;
        b=U20HLdju+NK+z9K1NBf9Ofzv1wKlj0CM15toL0/K1VEDyM+DlXTCgIAfE6vvMa3Jjl
         k6zyu+eIoA63cTTstaKtdEJAnnM2Ua80yGV9XIpasMJ7iS18pVnEPl4pt317GvPFa8fo
         2hyKVHEpAEKnyAznHEXF0ceYBCLfwEIUWGmLG7vXWMqu28YdE8Njwz/irvEJykF8C48q
         UkW83QPc4qDZfph4rzq5AUZa78s7K8PY+ofYuWus7ENkrr/vdm891Eq4dOMeIN+yGlig
         lWjrBqN6p62GwMylu1Nr4+j2dH3ABbBxnL3AZE3ToR4lEzzsx7Ttl4xO2jPiyb7xPAuw
         BadA==
X-Gm-Message-State: AOUpUlHloorPl8paPfH/iHKLOTTI3A3rpIIvqQF0XhLb0P10tmLQjysx
        muBaPptBccwb1CH2KDcHxyo=
X-Google-Smtp-Source: AAOMgpdeDVThQnCYSZB0srCA5MxxvKxT4SXRmZsEQDGokcCwpEC4WMkOjdbzoN4BvjigchMUlT0pTA==
X-Received: by 2002:adf:c383:: with SMTP id p3-v6mr19314755wrf.68.1532986791444;
        Mon, 30 Jul 2018 14:39:51 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l14-v6sm17779428wrw.65.2018.07.30.14.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 14:39:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] Highlight keywords in remote sideband output.
References: <20180730123334.65186-1-hanwen@google.com>
        <20180730123334.65186-2-hanwen@google.com>
Date:   Mon, 30 Jul 2018 14:39:50 -0700
In-Reply-To: <20180730123334.65186-2-hanwen@google.com> (Han-Wen Nienhuys's
        message of "Mon, 30 Jul 2018 14:33:34 +0200")
Message-ID: <xmqqsh40e72x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> The highlighting is done on the client-side. Supported keywords are
> "error", "warning", "hint" and "success".
>
> The colorization is controlled with the config setting "color.remote".
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  sideband.c                          | 78 +++++++++++++++++++++++++----
>  t/t5409-colorize-remote-messages.sh | 34 +++++++++++++
>  2 files changed, 103 insertions(+), 9 deletions(-)
>  create mode 100644 t/t5409-colorize-remote-messages.sh
>
> diff --git a/sideband.c b/sideband.c
> index 325bf0e97..e939cd436 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -1,7 +1,63 @@
>  #include "cache.h"
> +#include "color.h"
> +#include "config.h"
>  #include "pkt-line.h"
>  #include "sideband.h"
>
> +
> +/*
> + * Optionally highlight some keywords in remote output if they appear at the
> + * start of the line.
> + */
> +void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)

I'll make this "static" to this file while queuing.  Also hoist
"struct kwtable ... keywords[]"  to an earlier place in the function
to avoid decl-after-stmt error.

 sideband.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sideband.c b/sideband.c
index e939cd4360..74b2fcaf64 100644
--- a/sideband.c
+++ b/sideband.c
@@ -9,10 +9,20 @@
  * Optionally highlight some keywords in remote output if they appear at the
  * start of the line.
  */
-void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
+static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 {
 	static int sideband_use_color = -1;
 	int i;
+	struct kwtable {
+		const char *keyword;
+		const char *color;
+	} keywords[] = {
+		{"hint", GIT_COLOR_YELLOW},
+		{"warning", GIT_COLOR_BOLD_YELLOW},
+		{"success", GIT_COLOR_BOLD_GREEN},
+		{"error", GIT_COLOR_BOLD_RED},
+	};
+
 	if (sideband_use_color < 0) {
 		const char *key = "color.remote";
 		char *value = NULL;
@@ -25,16 +35,6 @@ void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 		return;
 	}
 
-	struct kwtable {
-		const char *keyword;
-		const char *color;
-	} keywords[] = {
-		{"hint", GIT_COLOR_YELLOW},
-		{"warning", GIT_COLOR_BOLD_YELLOW},
-		{"success", GIT_COLOR_BOLD_GREEN},
-		{"error", GIT_COLOR_BOLD_RED},
-	};
-
 	while (isspace(*src)) {
 		strbuf_addch(dest, *src);
 		src++;
