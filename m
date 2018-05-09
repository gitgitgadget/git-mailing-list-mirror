Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BD551F424
	for <e@80x24.org>; Wed,  9 May 2018 12:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934257AbeEIMf4 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 9 May 2018 08:35:56 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:46139 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933953AbeEIMfx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 08:35:53 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0M371n-1eQDPI2ekJ-00swfT; Wed, 09 May 2018 14:35:47 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 27CB4649A03;
        Wed,  9 May 2018 12:35:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N8OTlHFFYO9P; Wed,  9 May 2018 14:35:28 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 551C164A7C8;
        Wed,  9 May 2018 14:35:28 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.10.2.141) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1320.4; Wed, 9 May 2018 14:35:28 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 010BB804D2; Wed,  9 May 2018 14:35:27 +0200 (CEST)
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Paul Mackerras <paulus@ozlabs.org>
CC:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Alex Riesen <raa.lkml@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH v2 0/2] gitk: improve handling of submodules in the file list panel
Date:   Wed, 9 May 2018 14:35:24 +0200
Message-ID: <cover.1525868167.git.raa.lkml@gmail.com>
X-Mailer: git-send-email 2.17.0.593.g2029711e64
In-Reply-To: <20180508121104.rtsrektxiihvpqtx@pflmari>
References: <20180508121104.rtsrektxiihvpqtx@pflmari>
MIME-Version: 1.0
Content-Type: text/plain;
 charset="UTF-8"
X-Originating-IP: [10.10.2.141]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
Content-Transfer-Encoding: 8BIT
X-Antivirus: Avast (VPS 180509-0, 09.05.2018), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K1:zYlSNkTW1w6IKIcJFC+RqdduoM3ELxhbLsG4hiZoz1RppEfkmpN
 kZIynUfKU1YtNA9sCBVtrudZOUFh9wgKjZ0ELJRdAShIYyCslEx+loK5ZExZFeynD2lqbRf
 ptjYhaGGIP9oRoW3fP2RnTdnxcwFGtKYqzU5Wq4nK7eIR7avu37RhiZYp1ws1rIwusuMWlU
 RLXIi5Vri9Ck+oQzW687Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZMqu5keyEpg=:JXXnyHj+rP5OUvv9CAjFo1
 +AfpURbbOAGqSTE0fYrWov3kP6ccCfiSCQuPVfyKa36+LGz4t+72wp5GoWoGfBeKUCekkQZFV
 K+enpnIUlVv6xWy/Q+2kqVA2ZfBIWxTiiRZHUJ66eUviY/prO7BOIh/Ud8jl0JPWf/S80R3ma
 czByhfAcnIgi+323S/TVqsNehH5WPaCBWNq9hWKvPXZ9MoiLPSlW7Dn4MGuGJgWSlNCKylBOP
 bp3oSzQXKN+rtXiEF4gXQYmzGkfS7mjw/dJ9dkgosWmJCOuOrxfyGj9ZgITg+OOPJ4lGF/54E
 21DbcNAHWkTjvrNlaCu2IN6Bnw3kFIzP0zfYgrgZ29wyO10HRU8b00/Brk/OnMz1DL00ePU5E
 t1bOws+AVbEAsyMOH5UxsIyF9XSEbb/bcfGW/7K6huZsOTCfp7nim8ppm/E1ah4yIasXi9rRz
 H/PZrmie/w8uy1vgXj5Kkr9TBczRRPAQGKdA/sRkI0qeYM3InGLkAMokKYj8dB3P8iSUiZV3P
 MxM5sGCpHGhQ6QR8U45IhXQk6414c/aLNi4uGKZdkDGhSb75Mdp8szW0Wq+wADsLaggCwGgBd
 GMlSyiwa1NVKdI9FkdsMUlxPQzHTncMmAkCMgn3KBMYPxb7vymR83tOC7JazaWQ3/jpJqtM9N
 amDue6hM7ctGqZZwaOPlU0iqqeeFd5Pw/e/xzFyx/3Vi9KMcBs0MJz0+nTy+ogVaWGAWoorRa
 cQARYQ7YcIQzQGLb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Riesen <raa.lkml@gmail.com>

Currently, the submodule entries in the file list panel are mostly ignored.
This series attempts to improve the situation by showing part of submodule
history when focusing it in the file list panel and by adding a menu element
to start gitk in the submodule (similar to git gui).

This iteration does not address the behaviour of file list panel in tree mode
when gitk is started from a subdirectory (gitk strictly limits the file
listing to the files in that repository, without a way out).
I would like to hear some more opinions regarding changing its behaviour to
always list the full tree.

Alex Riesen (2):
  gitk: show part of submodule log instead of empty pane when listing
    trees
  gitk: add an option to run gitk on an item in the file list

 gitk | 56 ++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 10 deletions(-)

-- 
2.17.0.593.g2029711e64


---
Diese E-Mail wurde von Avast Antivirus-Software auf Viren geprüft.
https://www.avast.com/antivirus

