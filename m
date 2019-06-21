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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E7291F4B6
	for <e@80x24.org>; Fri, 21 Jun 2019 22:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfFUWbR (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 18:31:17 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39762 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfFUWbP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 18:31:15 -0400
Received: by mail-oi1-f194.google.com with SMTP id m202so5757600oig.6
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 15:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gLuzT2L8a7/hrrShWA9VlzKiDNx5TG+AFuchFC22wKE=;
        b=C5tsw2LgwibLcU5GBRbIsRH3z39WmDrOoQRETBOwk/VOY1JdINHm8uu2RLd/CBurQL
         QyrUoWYKkd0RTTiTrEmtPLYAplNxOvjoYBui9WQdtzG3jGA91dN6blb35O/mlvHehch5
         cfqtAEtFf7K0fhUWNd0CQXgjUv+7Ci6Wq+3Eij+3alC2/bx8AfYB8Rzwr43qj4G8V4S1
         F15iwFU2ywtK5sAXLMAR2agOKIh+MFmPdrVd43jDUjoZV1XDLdg+I3iETDCDBjAejzqP
         HtsdNAE3utRo3isqOuk2q2EWm4EMCh3jYxR+OsCrWg7m/jGX6+zjk9bbaskg2IWYQP05
         v00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gLuzT2L8a7/hrrShWA9VlzKiDNx5TG+AFuchFC22wKE=;
        b=auP8NFYwMo8QtAw0RrNTRI5SDDaWyH7SwYaY7iqRCwQDAzpPU9OSdroozvLvCZdvM7
         fPdXjrGNdf368q6SnmLn1gT6xLu+WH62XxA4QWX7WrcttsLY6sBkUae0PsbxZ9bAzeTk
         XFZGAFA2e/ABFvknvvV26OduGnWG2mq7Rv+o0BNp5Db8IBG8JsTuJ4G4U5rF6YTVXrt5
         aHy0BtuiysS7YWtb/zqPvTyTeTdSYvas3YgZZhIwkGp8zRMT6sTG5lS8Ctlx3lEVs8q2
         +8tB64mp1ie/9CpUBJlLhL8h/Sm1yNkiBqkF6i09e/fwYbv97PC6eminbTNU49ayZHak
         5P5Q==
X-Gm-Message-State: APjAAAUACzgy8AFavfvAzRFggsJNMd02U/jWQbq+6TVti1sdTpBo0/l9
        0rYqMcN25vWqLhJTJ4d0/3mGZdNIA2g=
X-Google-Smtp-Source: APXvYqwaQe+LJyxBCrUqsXD6k8Ykq0mca44U4CWOKijg4kerNIdkDMRPrOIvp4+zhA4rIXkwQ/xj0A==
X-Received: by 2002:a05:6808:904:: with SMTP id w4mr4294657oih.9.1561156275001;
        Fri, 21 Jun 2019 15:31:15 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id o32sm1630453ota.37.2019.06.21.15.31.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 15:31:14 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 04/14] completion: zsh: improve main function selection
Date:   Fri, 21 Jun 2019 17:30:57 -0500
Message-Id: <20190621223107.8022-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190621223107.8022-1-felipe.contreras@gmail.com>
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes we want to use the function directly (e.g. _git_checkout), for
example when zsh has the option 'complete_aliases', this way, we can do
something like:

  compdef _git gco=git_checkout

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index aade33ec9f..2801f2f7c8 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -226,8 +226,10 @@ _git ()
 
 	if (( $+functions[__${service}_zsh_main] )); then
 		__${service}_zsh_main
-	else
+	elif (( $+functions[__${service}_main] )); then
 		emulate ksh -c __${service}_main
+	elif (( $+functions[_${service}] )); then
+		emulate ksh -c _${service}
 	fi
 
 	let _ret && _default && _ret=0
-- 
2.22.0

