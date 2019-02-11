Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C09501F453
	for <e@80x24.org>; Mon, 11 Feb 2019 03:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfBKDHR (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 22:07:17 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39978 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfBKDHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 22:07:16 -0500
Received: by mail-pf1-f193.google.com with SMTP id h1so1774852pfo.7
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 19:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=me5/UtSeb83X2Zx/k05jrGHfVsKALaSh9viMbGKT6Ts=;
        b=PGoO45yDbSEQ1sCVh03fbN8EP+39+PPbL/UgjvyEsRVpAAV/95svl/J/ZXzuuwCM41
         TjY4n7OySmzVmxd7FvnaZpmz3gSJfe+8rvju0jVRNhA/jWVgJWsZD8u9rVl6N3fntaKD
         YK/8BQ4Ls1QcMoWlUBRhPmpf1aTMglNOpg8vlAZRvJ4W8TZ1C3XikTRIsJCTplVivt30
         l9dLpZdHLy/eKBADvgcq/K0TWup+YYQHc6bmBCvtic84g7ZmH1WSz8kSTVDLBQjXFu8h
         kYYLuJm8AklxMtMOlcM33rzwftUnjLVae6NTVggfQLWEt5oXfffPxsLgv4Aq9DIubOdz
         qEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=me5/UtSeb83X2Zx/k05jrGHfVsKALaSh9viMbGKT6Ts=;
        b=lK6LIXirZbJKf5znpruyccvFRIudPJgcGM2VNItOD+ubapuoB6WpzrCjdW0tNCT73v
         rPUbEKH3pwU70uEX10CWFjygIXDO8ZPLm3UqdPOmgivZYlPEFO/+QL4qwRhb6cGpwTmz
         6SHKKMGjz/cs+MBnRLrSHI0bmUnrLgQTp2/COEsLiunxlF2jeACNHOV6QEcFCp/wxGDY
         BoeIHrkrEAoisbE2VwJPXQnaQnaMcia9nTrtLQ13zJetecs+urGugnzTeuIhA/97jvuA
         B8Q7DlH88IRu8pdHvwWF/I6xRgtbWWSHB05v+m57pZdZ/ssx4DMm6YIl+Pnq+Z9DLuPz
         9zUQ==
X-Gm-Message-State: AHQUAubYXEooYzAjdmxmqU6ugb27ji+INLdndCLEpgsUSQdrMwblpbzA
        FCl47aN+i64kfr9PsEQyXg7oFuu2u5ZXc1F9
X-Google-Smtp-Source: AHgI3IbfdkcgPFO2uDqWiazSCccY92WoaqJ1i+p0d56hJwHNbzklR3MfeVcINrPjVkk1xgPqc5Yxaw==
X-Received: by 2002:a62:9f1a:: with SMTP id g26mr11449499pfe.123.1549854435813;
        Sun, 10 Feb 2019 19:07:15 -0800 (PST)
Received: from localhost.localdomain ([2408:84e1:c0:9021:e936:4b52:7bf9:e838])
        by smtp.gmail.com with ESMTPSA id s16sm15199529pfk.166.2019.02.10.19.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 19:07:14 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>
Subject: [PATCH] Fix typo: "git bisectreset" -> "git bisect reset"
Date:   Mon, 11 Feb 2019 11:06:39 +0800
Message-Id: <20190211030639.18761-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.38.ga5fda54cc5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index c1cff32661..5f0b4bddf1 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -173,7 +173,7 @@ static int bisect_reset(const char *commit)
 			argv_array_clear(&argv);
 			return error(_("could not check out original"
 				       " HEAD '%s'. Try 'git bisect"
-				       "reset <commit>'."), branch.buf);
+				       " reset <commit>'."), branch.buf);
 		}
 		argv_array_clear(&argv);
 	}
-- 
2.21.0.rc0.38.ga5fda54cc5

