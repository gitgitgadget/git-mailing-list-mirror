Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 230151F462
	for <e@80x24.org>; Wed,  5 Jun 2019 20:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfFEUKM (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 16:10:12 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39991 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfFEUKM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 16:10:12 -0400
Received: by mail-it1-f193.google.com with SMTP id w190so4113095itc.5
        for <git@vger.kernel.org>; Wed, 05 Jun 2019 13:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xnIod1NkQtfXP9fnISVllLKR7vaulKj1hubeoQXR0TU=;
        b=u5+/QNOWsqJjTp3uCjXKs3oLD/10UFkd1TPyK9/zkvhdNMs3fd4GHR2Kgbabh2+qOh
         CBupIVnXHkmVpveYwTWUSSy0VBojvMDkwCBEAv9d53wzUQXtOicFc1mCTgl1NyWOrQkN
         o/sTvzXT7tlZB3bt9quigAS5rYBlEc7nTwuV58nnjrX5AjRdllcxnLzJoQ3XqcRx1Q2Y
         F6j6OY/tAVGxcI+P74MGPVtYlQIc/ub4Xyz9ypDjPdnBDGvYgXyco4B3blLqT2Cu3As8
         z0s6Jbz388O/JyhiP1JCQkENw+xIf6uRlaWN/JJ27Jr9hkkU9LJ4QM8QbIZ2x8plALXz
         EALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xnIod1NkQtfXP9fnISVllLKR7vaulKj1hubeoQXR0TU=;
        b=KENCxSsZ7QFX8OaN4S6k9MTaSq7uZI8dfo+sDXw4zq6NINBK+YfO8av5PyXfIHD19g
         zC1VgJch+i+ytBSHrq5JjuyV4fmYL1mrVroEnAlxuG2YdRcsJHsXUkCvCNGXUgRJpcXI
         Ql3ExBk/XehJ531bytqTbLE8uOaNCqGVr0Op6+7S22a6ZQ3ND34eBPZDeIy6vEPXt3Rv
         hF2Nrn/Gb4PXkl384kjs/9W/vzKSbLuHFeHr//Qta74KYoBwqs/sS8cYOi1P75xxIjSn
         k1hYC7xdc1EriFq323EO1vUActchq+dMnawIZUvAoPo9rQYUzpvP40m6Srd5fXLOiSEL
         qDeg==
X-Gm-Message-State: APjAAAUK/CrW/rkAH7D0Ms9XUEIdqcsXaVGeGDZzL0xdGOWNUflsmmS+
        ynHV5ttPiG0yf8LVIM8Bt2b+b39L
X-Google-Smtp-Source: APXvYqxUb/LI7mtQ204Y57jM4Rb7N/p3khACgcVF51AaTp6w2I1J+Vey5Ayi/rvBIS6usDQHSX/9/w==
X-Received: by 2002:a24:d486:: with SMTP id x128mr27229804itg.80.1559765410725;
        Wed, 05 Jun 2019 13:10:10 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id r139sm7338814iod.61.2019.06.05.13.10.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 13:10:09 -0700 (PDT)
Date:   Wed, 5 Jun 2019 16:10:07 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 0/2] Doc: document alias accepting non-command first word
Message-ID: <cover.1559755652.git.liu.denton@gmail.com>
References: <cover.1559333840.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1559333840.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review, Johannes. I think it's a good idea to add another
alias for `-p` so included that suggestion. Also, while I was at it, I
found a typo so I fixed that too.

Changes since v1:

* s/loud-merge/loud-rebase/
* Add `-p` as another example since that was Dscho's original use-case


Denton Liu (2):
  config/alias.txt: change " and ' to `
  config/alias.txt: document alias accepting non-command first word

 Documentation/config/alias.txt | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

Interdiff against v1:
diff --git a/Documentation/config/alias.txt b/Documentation/config/alias.txt
index f241f03ebe..f1ca739d57 100644
--- a/Documentation/config/alias.txt
+++ b/Documentation/config/alias.txt
@@ -10,10 +10,12 @@ alias.*::
 Note that the first word of an alias does not necessarily have to be a
 command. It can be a command-line option that will be passed into the
 invocation of `git`. In particular, this is useful when used with `-c`
-to pass in one-time configurations. For example,
+to pass in one-time configurations or `-p` to force pagination. For example,
 `loud-rebase = -c commit.verbose=true rebase` can be defined such that
-running `git loud-merge` would be equivalent to
-`git -c commit.verbose=true rebase`.
+running `git loud-rebase` would be equivalent to
+`git -c commit.verbose=true rebase`. Also, `ps = -p status` would be a
+helpful alias since `git ps` would paginate the output of `git status`
+where the original command does not.
 +
 If the alias expansion is prefixed with an exclamation point,
 it will be treated as a shell command.  For example, defining
-- 
2.22.0.rc1.169.g49223abbf8

