Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D71D20323
	for <e@80x24.org>; Wed, 22 Mar 2017 22:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbdCVWWI (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:22:08 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33484 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbdCVWWH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:22:07 -0400
Received: by mail-pg0-f48.google.com with SMTP id w20so10932327pgc.0
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 15:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LHfU+e8h8r4RsYydVtpwGxqS675DmbNEn0dJM+M9qiI=;
        b=RNn9WHl0d46JRcL3YkiSuvVTp65UBpq6oehEejGL2rvVuuT368Pr2QinedWh5Qnc+H
         SEMeQHHsSElSdu7VEyENkGDahuMq1XnMFQxNrddNsfDqJbF2Zj+TrOJjbEa9a2XOcrhW
         4myi8Z7e1Ail2ssHQCFKtrXDZ/oVfpLVTpPyu5y4cytSEV7HF6LBmxu2BnP1CfTcsVWj
         AfherqzZwP9RdZxwtmMMNxdsPlNnOKzYyOfhxZQQHornjYewom40rG26gPprHGvUw9uF
         C7m+5iEQcTIrzE00WUVwqYt/ImiNYRP/JvewQOcaCGxX1gszGm+f2KVQnGacyG3OMp4L
         sq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LHfU+e8h8r4RsYydVtpwGxqS675DmbNEn0dJM+M9qiI=;
        b=m2rubuiCM+09nlNnw5oCtcJEBwd3bclR3zBG3TZcHlLjf/GAgOr9YqXQCJO6bRePF2
         1OlMIyOTx+qc0KKYwOBMoiUlMXmcSPRcYeL8e6zjssqCIjXRrfGOpNIITxA2CLEgzO7H
         kfEXdVLHf9CiqCamICElzwMemLCKhhY4w6Pf2f0eMMCvMSVux0jf5ulk7Bp9rGJ/7pvG
         nH8YtwQLnW/Qmb3JGViirRgvMfllbzmlkJ+6BVtcY5yqrxpIhmkyxzDPAlkaPBs3nsev
         cDXhnD6g6+Mti7S2AAIbvKFUXp37xtkDBYa7MKNdI/kmxOdWlWhvfFNv3GBBYWZoWTuO
         mT9g==
X-Gm-Message-State: AFeK/H2L8aNNuK3Rlveswrg0qd6RnPcB+3smolZAa+i12urbGT+izMi93NKPal10pax1y/DB
X-Received: by 10.99.188.10 with SMTP id q10mr46552914pge.106.1490221325645;
        Wed, 22 Mar 2017 15:22:05 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id t67sm5813582pfd.76.2017.03.22.15.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 15:22:04 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        jrnieder@gmail.com, gitster@pobox.com
Subject: [PATCH v2 0/2] push options across http
Date:   Wed, 22 Mar 2017 15:21:58 -0700
Message-Id: <20170322222200.103204-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.1.500.gab5fba24ee-goog
In-Reply-To: <20170322195102.165314-1-bmwill@google.com>
References: <20170322195102.165314-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 addresses Jonathan's comments from v1.
  * Fix a test
  * Add some documentation
  * remove short option from --push-option in git send-pack

Brandon Williams (2):
  send-pack: send push options correctly in stateless-rpc case
  remote-curl: allow push options

 Documentation/git-send-pack.txt |  6 ++++++
 builtin/send-pack.c             |  5 +++++
 remote-curl.c                   |  8 ++++++++
 send-pack.c                     | 20 ++++++++------------
 t/t5545-push-options.sh         | 33 +++++++++++++++++++++++++++++++--
 5 files changed, 58 insertions(+), 14 deletions(-)

-- 
2.12.1.500.gab5fba24ee-goog

