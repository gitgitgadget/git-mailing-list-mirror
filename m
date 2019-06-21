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
	by dcvr.yhbt.net (Postfix) with ESMTP id A4A4B1F4B6
	for <e@80x24.org>; Fri, 21 Jun 2019 22:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfFUWbM (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 18:31:12 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35900 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfFUWbM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 18:31:12 -0400
Received: by mail-oi1-f194.google.com with SMTP id w7so5766852oic.3
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 15:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VtHV5zTS3soqq+ZGlAysNvSswCep2UXClY2cSqCUe90=;
        b=myjjPgkjSlHVS8sMf9RVIbYmUXI0z7asVQgOdOTX1xbOWPpTknWJhL920v40RAG5tR
         xMJU/DN3L3Km7/yxjgchuJ1IXHTv5jmM87CAX1qJeVC3g/cPZ7eoWJ0uJJgJc/mOp0kf
         rNk9Ia1I2JoZl84W2jonoFqfxXNI+LWX80ddhUn6Rg4OJZZwzAYHXvarRPWRkB1N0Tob
         M3hrCcQkVujvrDkdARp/N7cVZhcEKKQEcUapfFOG8SfkLrJ5HbpiRFsIFON4D2OK4vBk
         T7IktqbU4ThIa0t4IDZt2wWrUbYyLH4KqKok1Kz3D0JeQP257rfA72tLkIDRe1r1hIyu
         n08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VtHV5zTS3soqq+ZGlAysNvSswCep2UXClY2cSqCUe90=;
        b=Q1CZg0TamK7ALH7YAOa2PADutrbvJaWlg+d5HjukYn+WRM+GnjqXNSWh6iTZO4DEMY
         tkdKRvLKQxYlC+ro6Q+vVXyYiG0OashjwViNSlCwh3pJhLrNNzH27xWWAIdZ6P1kNkWn
         7dsNUy75kEVvy+ck+RR6rBi5MdV3OS/kwLuiZqnIi4rxpZzDx4xx1haDnoWy6lN1QZnd
         nBp1x/JirAgH1iIK3YzLwDdD7Z8ZCxhEbBdgoKwYA4HRDidMdNrTZLq6v5jvw7lEsaqN
         sd9APGP0z5FPbITw4lpe4YnOh41iI7AarHvBQbF24vkPTF9nzEHgMCI4Rf6Mu0XuoWqN
         gNGA==
X-Gm-Message-State: APjAAAWB4PXlwmYI4qGnWhm4sW2QrDK37rJoM2P15t55gMHauLiWh6q2
        BAhuKOJ0RXDnx2d0cbbPdTzAXKZl+g4=
X-Google-Smtp-Source: APXvYqy2EP2bMnz6N/ZFXJHyUDn64UYA8T+fWzW4Ti3U9bw28dVFGZTf12tw/zjn7JJ4vp1+35Tv4Q==
X-Received: by 2002:aca:b808:: with SMTP id i8mr4162180oif.160.1561156270996;
        Fri, 21 Jun 2019 15:31:10 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id a125sm2124153oib.11.2019.06.21.15.31.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 15:31:10 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 01/14] completion: zsh: fix __gitcomp_direct()
Date:   Fri, 21 Jun 2019 17:30:54 -0500
Message-Id: <20190621223107.8022-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190621223107.8022-1-felipe.contreras@gmail.com>
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many callers append a space suffix, but zsh automatically appends a
space, making the completion add two spaces, for example:

  git log ma<tab>

Will complete 'master  '.

Let's remove that extra space.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 contrib/completion/git-completion.zsh  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9f71bcde96..a65d5956c1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3009,7 +3009,7 @@ if [[ -n ${ZSH_VERSION-} ]] &&
 
 		local IFS=$'\n'
 		compset -P '*[=:]'
-		compadd -Q -- ${=1} && _ret=0
+		compadd -Q -- ${${=1}% } && _ret=0
 	}
 
 	__gitcomp_nl ()
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 886bf95d1f..0d66c27366 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -73,7 +73,7 @@ __gitcomp_direct ()
 
 	local IFS=$'\n'
 	compset -P '*[=:]'
-	compadd -Q -- ${=1} && _ret=0
+	compadd -Q -- ${${=1}% } && _ret=0
 }
 
 __gitcomp_nl ()
-- 
2.22.0

