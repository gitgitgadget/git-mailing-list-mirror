Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E8701F45F
	for <e@80x24.org>; Sun,  5 May 2019 16:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfEEQHB (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 12:07:01 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:43011 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfEEQHB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 12:07:01 -0400
Received: by mail-io1-f46.google.com with SMTP id v7so2754746iob.10
        for <git@vger.kernel.org>; Sun, 05 May 2019 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K3+xrGnGApHM2D060/djArFY0Oya1AKWWraz2ti7XRM=;
        b=kqYvWxun83AnwdRYkLaP3AFXKbs2lgw8Re+CBMXJ4RjC8iPr6aDxIPKV5ho/O3uYR8
         05tRW13dAlmth2MUM7aRqKQRxFuaS23j+c756AZuPBqZLWzVAg+Exr2I+9wwfzdTqp3z
         i7IlALmb/64DiWHJgNvEEq7I4CJXGSKPsYpQJ8zH1vMZY4WR6lKQCUGoD5YFrMTEF4cR
         qEgOLMNe7Ir8d7ur+Pbcw+uR+iaw2oYsdQmK8e7ive2SXlBXZ6RWR+loV0be8lwbFd5C
         G+X84DGxKLtMhmImsrM8p3XZIvJPh8opRjY1dbUmkU8gEzC94/fk5l0N0t+H1KKWnasB
         gRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K3+xrGnGApHM2D060/djArFY0Oya1AKWWraz2ti7XRM=;
        b=Dn7Ymzj1vPUsD+StpLUWEdtGOH/NzKsS5KjBLgN6Bpg/tx1TcpxU7bmkv1HzSO3Lnn
         lK1Awv8cEVOsSJmYuh3y+rf8SoXeShWmhfgqLkTA71R/IM9MlXu1mXZVktzj61JkJ9UP
         ZZ5oUvKrP75ZULftrBgp3kTAF6yYX5jZlPcSwnTz97aMe9TbiW0h7xVVIW9OBHBN4ZhA
         pzk54G7Z42qhUQGabSRje3FzwtV5yvALMzdMshsgV6SF9/lVUX2pvUoG5+d92+sSV3tC
         jynEJEumq4V6GF+HVan8OPC9IRn+oOqjdE4V8sY/YWrIzDK4PPSzxT0zwIIf884eJ0tL
         L7eQ==
X-Gm-Message-State: APjAAAW4LUHoMQlMyJoFqvWA/8bK/iKJjJsa3PYgmBBO4UO/vmQkWp5W
        JZCcMbhjOxHjv8XShwBR2ovEleSu
X-Google-Smtp-Source: APXvYqwSieUy+8rwyHB8ekK6vD3tMvzbTayXD7m6OLdTKqRTht46MoEvSNy6HXgcIbI6h7c4GWdIcA==
X-Received: by 2002:a05:6602:48:: with SMTP id z8mr15290426ioz.166.1557072419793;
        Sun, 05 May 2019 09:06:59 -0700 (PDT)
Received: from archbookpro.localdomain ([199.119.233.193])
        by smtp.gmail.com with ESMTPSA id j5sm3712704ita.16.2019.05.05.09.06.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 05 May 2019 09:06:58 -0700 (PDT)
Date:   Sun, 5 May 2019 12:06:54 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/4] cleanup revisions.txt
Message-ID: <cover.1557072286.git.liu.denton@gmail.com>
References: <cover.1557071877.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1557071877.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks again for the comments, Andreas! I've incorporated all of them
into this reroll.

---

Changes since v2:

* Marked more optional arguments with []
* Added Andreas' "revisions.txt: remove ambibuity between <rev>:<path>
  and :<path>" patch

Changes since v1:

* Added patch to fix instances of "rev" to "<rev>"
* Marked all optional rev arguments with []


Andreas Heiduk (1):
  revisions.txt: remove ambibuity between <rev>:<path> and :<path>

Denton Liu (3):
  revisions.txt: change "rev" to "<rev>"
  revisions.txt: mark optional rev arguments with []
  revisions.txt: mention <rev>~ form

 Documentation/revisions.txt | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

-- 
2.21.0.1049.geb646f7864

