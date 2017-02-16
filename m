Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D36371FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 23:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933742AbdBPXdC (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 18:33:02 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34806 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933695AbdBPXdB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 18:33:01 -0500
Received: by mail-lf0-f67.google.com with SMTP id q89so2587221lfi.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 15:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OFvNdjKmgfuaBJ+TgFdbqNLON42Akyn7UroIGts5gDU=;
        b=S9wmFlLP5V9NdIuE+trbpUXx2bBkZwxmUtfUnzfacnV+2fHXqZKftaCNCn3r4x1Zp/
         Uw3BtlrfW1qDbuoAdl19Q+m/KPiK18sDJt78W7FGh4L7W8LGysk1bNCYgIfEhOPxP+iw
         HxsaYJO2qIir20c7KRt2+MfdPOxHLs1G+2AcWT0WMOYH/JUTfve95P96x1gO4zXeFi3o
         yM9cW/wTlwhk5utLFcPNwaM1KeDh0+d2vXW21q2KAcQxLS0Mg0AIYAfBqvuhyP19Ki3V
         xQ7BsSvv/GRMe9/8+5da8+3Tw3jJaFLoxhYFTJNfanykvrdHZALPGMJKYKaaLg+4HSRV
         yCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OFvNdjKmgfuaBJ+TgFdbqNLON42Akyn7UroIGts5gDU=;
        b=C6tcDzj2UQEMjMUwDbvUE1YBFb5ICpFlDEoMvoeHI88v1Jx5QlRKv8rmne7udWPxND
         QBt8oMgqPND6nHZp02I8WwK+Zw21jhmvZkGLE25ffDRp49KxfnXy8X3eNhYcx4mPvE/p
         ssNoC4pK/4E4hXTdEUyoPzN9rVz9gBbftYM7u7RaLMmETj6p5utOWKCP3hvZ29QDML5i
         UAR9vNT7nGisqxOgDzb5uq3eNbdtjN2/YnygAf1zqjzqnRatUHHOjInTQlXlaYsBlt0W
         B5D8Uv8cl+tj8tdttXIW+2mBzEB33HszKUmeo+q1omsbRMYhbQ3espp9+8M5uavb5PUd
         hKXA==
X-Gm-Message-State: AMke39lxC6gqaZONfjewXaUnDo2b792+0zmbwjwj2qh4IASWmwfqB24AvxyzbhpbQywzMA==
X-Received: by 10.25.27.147 with SMTP id b141mr1483570lfb.183.1487287979897;
        Thu, 16 Feb 2017 15:32:59 -0800 (PST)
Received: from localhost.localdomain ([2001:470:1f0b:8fc:eda1:2dcd:3a83:adeb])
        by smtp.gmail.com with ESMTPSA id k127sm2071074lfg.10.2017.02.16.15.32.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 15:32:59 -0800 (PST)
From:   Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com,
        Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
Subject: [PATCH v3 0/2] Fix l10n
Date:   Fri, 17 Feb 2017 02:32:47 +0300
Message-Id: <20170216233249.24757-1-franchesko.salias.hudro.pedros@gmail.com>
X-Mailer: git-send-email 2.11.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some places fixed-size buffers can't store formatted string.
If it be happen then git die.

Jonathan Tan, Jeff King thanks a lot for your help.
This is really my first patches. Your help is invaluable.

Maxim Moseychuk (2):
  bisect_next_all(): fix bisect crash when used the gettext translation
  stop_progress_msg(): simplification function

 bisect.c   |  9 +++++----
 progress.c | 11 ++++-------
 2 files changed, 9 insertions(+), 11 deletions(-)

--
2.11.1

