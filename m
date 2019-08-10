Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E37891F731
	for <e@80x24.org>; Sat, 10 Aug 2019 12:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfHJMbV (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Aug 2019 08:31:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39721 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfHJMbV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Aug 2019 08:31:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so47172010pgi.6
        for <git@vger.kernel.org>; Sat, 10 Aug 2019 05:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c/2Pq72YjjX+gw1xyQLjTnIclBdo0KPYq5HS+itnqXI=;
        b=vO9aGWy+vd79Pf8yWRfWAi0ZOL/pcpQnSjSY1rXxBvWwub7Las2/rbUSXNSqBsr01c
         /HiSrKzmt7poTU492sSkeLHzEUTXJFNOxboQOSGQIwq0zPCRYQzq4iynrM7HHnCMEOKe
         dGigBBCHo7jwi5g0cjVm2WgGQYL3sompTtMPBJe3MIa3DE4dSyjEXog5cBl73gtMz40L
         EzODwt7g69QDfwDQDitPqR+KZaeVSIQJkLVNKxRSb/VBES9o684hHOJFN3uOEmkS9/WX
         O1gVAP9NnhIKEPA7qVSYU9+j19uwWuqSNBwbRLyzt7iuHSLsyAq8StFU+c810pyzTM9s
         0B9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c/2Pq72YjjX+gw1xyQLjTnIclBdo0KPYq5HS+itnqXI=;
        b=mJCU2ciSMtG4L7fD5m4qDj4KaWSgejclJQvz5Jn0gJWbsHcRi7uSNxPpCdGvjPX9ia
         u2I2g5muqu7xCb4EBkZ2uw7d/IWqWW4zdvGhsTmQln0jKasffwPkPEtt/d8pv/zjAZUZ
         9jibbKpXKro8X6aj0TqFW9nqyt3JslNejtUIuKAiMXCJmnnrZ68fNJ6J2LKWLdTujsTG
         YzaxnoBpQzk4t5Z57phtyyrqm093J1SSIXUBspYKS1yXqrfMDoHsXQWcpgVzwx411oq5
         RPXaUjnDocbJgqCsu4ns0TnxecGxPgsgyy3rR8TGOHfwoUgpGbh2AsOs8zPSRk0XVrjl
         l5ig==
X-Gm-Message-State: APjAAAVjLMOLFud2TC8W83PlmavX2+Fb6hxNKcNOmypcQi+dFQaklany
        uiPzoHuAPl1QC2qSlftr03JPKzqECFONRA==
X-Google-Smtp-Source: APXvYqxCb51jhxXcOFa8bwxRR94lILCxGLBeC5s6LVFeYAzrAEskyPlbAavu5kBRxXXwLfEhBxNIkQ==
X-Received: by 2002:aa7:8817:: with SMTP id c23mr27136512pfo.146.1565440280559;
        Sat, 10 Aug 2019 05:31:20 -0700 (PDT)
Received: from localhost.localdomain ([2408:84e1:e6:bc28:25ba:428d:c223:7d41])
        by smtp.gmail.com with ESMTPSA id h11sm106368522pfn.120.2019.08.10.05.31.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 05:31:19 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff for Git 2.23.0 round #2
Date:   Sat, 10 Aug 2019 20:30:59 +0800
Message-Id: <20190810123059.24833-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.23.0.rc0.7.geccd872c76
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.23.0-rc2 has been released, and it's time to start new round of git l10n.
This time there are 4 updated messages need to be translated since last update:

    l10n: git.pot: v2.23.0 round 2 (4 new, 6 removed)
    
    Generate po/git.pot from v2.23.0-rc2 for git v2.23.0 l10n round 2.
    
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin
