Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA9921F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 18:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfKMS0J (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 13:26:09 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45973 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbfKMS0J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 13:26:09 -0500
Received: by mail-lj1-f196.google.com with SMTP id n21so3661983ljg.12
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 10:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2CpWfIl9WRA1iYy5WLeLGnvLWIGS1dpMvYPZgEA58Fg=;
        b=uHfF7jplZt8dR3pnR9xPjRJwCRH4ZsDYRpOdoQ3O5WhVj3+aD609P0vkzbj1Mx4YUe
         8CPYVEbPdaW45G3B2IWUfLplFN+eR1CN2R8OTbXRbiTW3TmJF8U26w+0QUllfVqZHYsf
         ynxM/Vw5NeHhldR3ayty42DlmVcseP6b8NXiNldUfw4vqhZBqpr1k7Xvyy6p0kNtUmLj
         3j/k3AA3eSOqKZQ/rstzcQYTBQxEv2fSEaMVGbyVnjCoVPQwofPDl/LEONw20vUKmdig
         aYAufRCPq0J6y7qgBQuTxIEfaiQ4bO2j9trWUjiipUKMI4Or5tWsVk2Qmq+H9VJuRjxB
         ayvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2CpWfIl9WRA1iYy5WLeLGnvLWIGS1dpMvYPZgEA58Fg=;
        b=gFQE6lx93sBTgiKacE3HXA86HQI0ULhLgxnMVmu1iSU7aE6fmea/M4nYt9wB/UtIWD
         S07+lz5oJVgeg9qSPkz9ezN1wqh3PTNTEJpnnoSwD0qEaEyFl5NZ32nfiFyLHuSZmxs9
         p+k0XxaHjeAuyvEMMCQ87Z4m37hemVhnsx/Jf/+CWk4Ob8nIeGp9kiSuPP9WU1hAqyvy
         GyFb/N5wi12W8KFd4WfnvmZmcbvKwqdc9qM9iCU23ICRr140fpuNhAccH4WL6FqaZ+g9
         eRtkwygPE7msFM2w+H4ciQbhy6JCcoJ6N2mp94By2WGo+5IDSut7i+LkRO0MVvdiA2vo
         0cYg==
X-Gm-Message-State: APjAAAU3Vjijr+ra80YOeCh28fI4jWebSI7RMqAHUCiiQ5J47rKbAuBs
        tIxC3Mdi+835RhSbuZPBfZI=
X-Google-Smtp-Source: APXvYqxx0uSnbUa1Wf46YkybgH0xcT4J4zZgV3BxoZ9KbOifiiIrGXg1qosE1xBoeaPSrhOlAmyELA==
X-Received: by 2002:a2e:9784:: with SMTP id y4mr3639385lji.77.1573669567424;
        Wed, 13 Nov 2019 10:26:07 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id u7sm1404117lfg.65.2019.11.13.10.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 10:26:06 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: Re: [PATCH] parse-options: use COPY_ARRAY in parse_options_concat()
Date:   Wed, 13 Nov 2019 19:25:48 +0100
Message-Id: <20191113182548.1707-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <df941c25-22ea-3523-9607-8e892dea320c@web.de>
References: <df941c25-22ea-3523-9607-8e892dea320c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 Nov 2019 at 18:19, René Scharfe <l.s.r@web.de> wrote:
>         ALLOC_ARRAY(ret, st_add3(a_len, b_len, 1));
> -       for (i = 0; i < a_len; i++)
> -               ret[i] = a[i];
> -       for (i = 0; i < b_len; i++)
> -               ret[a_len + i] = b[i];
> +       COPY_ARRAY(ret, a, a_len);
> +       COPY_ARRAY(ret + a_len, b, b_len);
>         ret[a_len + b_len] = b[b_len]; /* final OPTION_END */

Maybe include that last one in the COPY_ARRAY with something like this
on top?

-       COPY_ARRAY(ret + a_len, b, b_len);
-       ret[a_len + b_len] = b[b_len]; /* final OPTION_END */
+       /* 1 more to include the final OPTION_END */
+       COPY_ARRAY(ret + a_len, b, st_add(b_len, 1));

Or maybe even something like the below (directly on top of your patch)?

(Plus, you could drop `i` entirely, but I'm not sure that's worth
golfing on.)

Martin

diff --git a/parse-options-cb.c b/parse-options-cb.c
index 2bde78b726..11196cfb96 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -185,11 +185,11 @@ struct option *parse_options_concat(struct option *a, struct option *b)
 		a_len++;
 	for (i = 0; b[i].type != OPTION_END; i++)
 		b_len++;
+	b_len++; /* final OPTION_END */
 
-	ALLOC_ARRAY(ret, st_add3(a_len, b_len, 1));
+	ALLOC_ARRAY(ret, st_add(a_len, b_len));
 	COPY_ARRAY(ret, a, a_len);
 	COPY_ARRAY(ret + a_len, b, b_len);
-	ret[a_len + b_len] = b[b_len]; /* final OPTION_END */
 
 	return ret;
 }
-- 
2.24.0

