Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F13C20373
	for <e@80x24.org>; Tue, 14 Mar 2017 00:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752748AbdCNAdL (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 20:33:11 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:32800 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdCNAdK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 20:33:10 -0400
Received: by mail-qk0-f193.google.com with SMTP id j127so39441466qke.0
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 17:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IjJsiaGQfEAzl5+dyarBFTS15soaMQLNpAz2oK6LNvw=;
        b=c4bpGm6l6eMbqHpO/x2HjWXra2xQFIpkSbPDxTJL1qB3yEQcMfRFdXweH8GclFM9PU
         Vo1pIqtTFH4wGSfvzPhWwsM9ELK7eQiHsRqHiNe6zILbwrlUXn9VFwMn27l7/4931vTP
         siMoUzu54x6DJ4kMuztEVST42v4tE/2M00AF1fnmP7RZUe1W4ywifm6TbrHUEikMMb3Z
         IykLE/ZLtDretlIRM41nass4No2hyL0epHLKOuTNbbuaZlyHnVUtR0ki+cdVbWyE6+I2
         +3+s6ksBAY9GDYDEMFrKfuVJ2yosmMrdWB9B72A9uXSxM2mgU2IORiyJ0b8ZEbzzITo3
         V9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IjJsiaGQfEAzl5+dyarBFTS15soaMQLNpAz2oK6LNvw=;
        b=jBKUHCt2uFptZJFYkmZuLPrCMfjObkDOF1gIGDBU+7yZ3DBiCNzERyyszt9AUox4J9
         Kmwlbh9X8lJsgC76LIKFhjdIafTkkpXeMdlwxr+NN00EHRb0oBwaRhjjz/sjqGEs0/hF
         Ri0oGVK5c1ceLuED2+oCujRCPutvZeZdu4FvoNZKqL8e5FPymYqA2igB14IJcBtb/SIz
         Gbi+ERq27BRwtPQkYIa3D2M7/M1fMFXmlVoNVoFX4TAj4eTjRGf3l57AZ5E5rxljoqyP
         RAeeiu4rW0ZpzqxAa0ktVwIDE32+uS5zkBTywSDoMnPC2hvHuV76541gYDttmASscRBS
         3kww==
X-Gm-Message-State: AMke39l37hSnFYCFRByPsGCqZucLislX4QzuI8nhjPhqWLlzU4sWXdn613PL1ssZyPC5hQ==
X-Received: by 10.55.64.74 with SMTP id n71mr32833292qka.250.1489451588969;
        Mon, 13 Mar 2017 17:33:08 -0700 (PDT)
Received: from mango1.eduroam.cornell.edu (nat-128-84-124-0-329.cit.cornell.edu. [128.84.125.73])
        by smtp.googlemail.com with ESMTPSA id z196sm13327954qkb.11.2017.03.13.17.33.08
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 17:33:08 -0700 (PDT)
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     lehmacdj@gmail.com, gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [GSoC][PATCH/RFC v3 0/3] Fix commit messages, check if socket is socket
Date:   Mon, 13 Mar 2017 20:32:43 -0400
Message-Id: <20170314003246.71586-1-lehmacdj@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <xmqqa88orgjd.fsf@gitster.mtv.corp.google.com>
References: <xmqqa88orgjd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I fixed all of the commit messages and the weird indentation.
I also now check that the socket is actually a socket.

What do you think of the function is_socket? Is it general enough to be put
in dir.h or unix_socket.h for use in other files? Or should it be left as is?

- Devin
