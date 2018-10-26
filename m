Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7D191F453
	for <e@80x24.org>; Fri, 26 Oct 2018 06:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbeJZOrR (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 10:47:17 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51962 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeJZOrR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 10:47:17 -0400
Received: by mail-it1-f194.google.com with SMTP id 74-v6so315492itw.1
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 23:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bVWkNvvf10bEbK2AoewgFDanuzUKkZ2yNEjyplWds9U=;
        b=jd8eiRosXxfOytbo2c+svcoQZPzUI3+tqKzGlHB14GQ+ZvfUcSFPhDkJ9bcOGwukS2
         qeGDFBWeq+N9j7+IteGZeSdPOZizDAfw94DVvi5pJHfgAV9cCJU58ebM7bWupBwcKhlR
         MB3/usenP8E1q0pkTZSKiyX+KnL5L3QhbRWkn61qBz27k5xE3wHRld9LBlXy0gDmZ/TV
         YldFITu6ecCzWcQZ6Kcb167PBWMb7T5ePaY54nQ3Yu9EJrRTmaBk8daNjSneUmstiaJB
         ZMKZXWi3XeANebPA4S1ACTiu98hh9zbXibxvnIv9+gnJvVocEsd1QyfvdnSFfTw2NG6P
         n1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bVWkNvvf10bEbK2AoewgFDanuzUKkZ2yNEjyplWds9U=;
        b=HgXOZhjLFbpr9hNtfm79VawfRdzXzPy6aBDh487M/Ue1s/SIjXaucua+R/MSyIMAFR
         vcjChePLDtNQNLBxZimVrnHXz/69EzoT7H9W0B0sqsSLFhMMgLEZ4vBAzBEDD/oqk7wE
         qPLT4pUlL/QEw5N+tlm6y5k4Nk7DeO4eEGUUR40+gevE+xXev6muMSI4loyVuPhgZ++P
         LQD5nH4ZlLhAfbEjBWJF+nvjiIJKLOC56eow5sCb8dnW3zOOn2kb5XjZepfPZ+wARjyR
         4+T8iMp8jS3F6MC6Lee5BdD+HNQM+NDBqhRQZthDa86EPwo0YHauf3N3Jm5N7GJDSZyX
         ynpQ==
X-Gm-Message-State: AGRZ1gI0IyFL0U+n5Ae/iFQnn+sZ89g2fh3qFeVd5dmjjVnv1kcaNdld
        JSiJ+Dge4NhpguVkLrpzzpyX6Rn2
X-Google-Smtp-Source: AJdET5e59e548Ljx+G5XkyqKmczFz2dGLon9+jyn84BPo2N0Wb1WfP7KfDh3pxge4JXFdcb//1pa6w==
X-Received: by 2002:a24:24c9:: with SMTP id f192-v6mr2566097ita.144.1540534296997;
        Thu, 25 Oct 2018 23:11:36 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id v6-v6sm3492704ioh.42.2018.10.25.23.11.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 23:11:36 -0700 (PDT)
Date:   Fri, 26 Oct 2018 02:11:34 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     liu.denton@gmail.com, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com, davvid@gmail.com,
        gitster@pobox.com
Subject: [RESEND PATCH v3 3/3] doc: document diff/merge.guitool config keys
Message-ID: <20181026061134.GA7311@archbookpro.localdomain>
References: <cover.1540398076.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1540398076.git.liu.denton@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/diff-config.txt  | 8 ++++++++
 Documentation/merge-config.txt | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 85bca83c3..e64d983c3 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -177,6 +177,14 @@ diff.tool::
 	Any other value is treated as a custom diff tool and requires
 	that a corresponding difftool.<tool>.cmd variable is defined.
 
+diff.guitool::
+	Controls which diff tool is used by linkgit:git-difftool[1] when
+	the -g/--gui flag is specified. This variable overrides the value
+	configured in `merge.guitool`. The list below shows the valid
+	built-in values. Any other value is treated as a custom diff tool
+	and requires that a corresponding difftool.<guitool>.cmd variable
+	is defined.
+
 include::mergetools-diff.txt[]
 
 diff.indentHeuristic::
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 662c2713c..a7f4ea90c 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -63,6 +63,12 @@ merge.tool::
 	Any other value is treated as a custom merge tool and requires
 	that a corresponding mergetool.<tool>.cmd variable is defined.
 
+merge.guitool::
+	Controls which merge tool is used by linkgit:git-mergetool[1] when the
+	-g/--gui flag is specified. The list below shows the valid built-in values.
+	Any other value is treated as a custom merge tool and requires that a
+	corresponding mergetool.<guitool>.cmd variable is defined.
+
 include::mergetools-merge.txt[]
 
 merge.verbosity::
-- 
2.19.1

