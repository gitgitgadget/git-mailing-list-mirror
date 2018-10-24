Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD6211F453
	for <e@80x24.org>; Wed, 24 Oct 2018 20:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbeJYEcP (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 00:32:15 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:45342 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbeJYEcP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 00:32:15 -0400
Received: by mail-wr1-f41.google.com with SMTP id n5-v6so3116924wrw.12
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 13:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cHsanoso4d2anQz7zIYHLcYM86Aatun5aG6FE5Tagvw=;
        b=Izb/MmCYnYuc1qHac0DUhWMWjcKlI5hy7cDLtElQv2Mnvd9U6TD6wqj30qyyhTo32b
         E37xB6cPMthV8JR+zOhTHWeSC9/RWcmdstDBJAu6zjLB3MzTbVCzJDqOSO7EGJ26G3sC
         7Ior9xMoZRvAYD/ijfE5A04zwO56ajchjFLIoz1LSgAgEnrRnzqHhq5Etm33pWkgQDzm
         2BZHcaWGK5KFYddtQe38ObvUR9Tl+1ryIR9fO2bNpKqvCtMQvpI+qMoKbCw1ZE2scQ2/
         TYzJ2Czfb+fxcrDPRbif/YciBc1LYNUP9wtniHuR8j7Dshya1a8hKHe/i9Bk01wtrwBA
         ZOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHsanoso4d2anQz7zIYHLcYM86Aatun5aG6FE5Tagvw=;
        b=af7+8MCKmkTSj+J8sz6MwocIL6T3ZxtVGyM8v/K2GNSnlEjj4uENVMdAZK0kXXH9Iv
         afP/o6zCZUhMUUhAFZlUfKSX0/Oijk6fqz9iMwdsCzpek3IuBr64tkBMpLxa0c6OA6ZJ
         zXXvcuZea/XOc+pyKSXw3eu/YVESUXJdPJzFypa67y4qsQAlF114C4sYyhrl399r61RX
         +o4vREZmSXdiaTM+cYUs27gxe+qgF5S9o2dRK6UW3u3ojFBd5TH+S/W9iki8onPBl5y1
         QG85O1dbbTzcOQYERON/mjB90AOe6CMBA86yNSmhlKjz/pVE2+8TxST05qPIFpOe6HA5
         qUxA==
X-Gm-Message-State: AGRZ1gLfbp+4RQvHfPeBEhmzyheUzasJEc7J936M0KT77BAX3MS2QSYf
        Hh4QpSslYf2nphYUGIPEB10=
X-Google-Smtp-Source: AJdET5dQpvGtElPaiTefizMbxp0PwrOGsO928u/7yYFAqTFhzLZHlVPgtBmAkxU9PpOvODsPKw3qcg==
X-Received: by 2002:a5d:448a:: with SMTP id j10-v6mr668920wrq.236.1540411367615;
        Wed, 24 Oct 2018 13:02:47 -0700 (PDT)
Received: from localhost.localdomain ([31.223.156.197])
        by smtp.gmail.com with ESMTPSA id 11-v6sm156438wmw.31.2018.10.24.13.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 13:02:46 -0700 (PDT)
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
X-Google-Original-From: Slavica Djukic <slawica92@hotmail.com>
To:     slavicadj.ip2018@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        Slavica Djukic <slawica92@hotmail.com>
Subject: [PATCH v2 1/3]  [Outreachy] t3903-stash: test without configured user name
Date:   Wed, 24 Oct 2018 22:01:55 +0200
Message-Id: <cover.1540410925.git.slawica92@hotmail.com>
X-Mailer: git-send-email 2.19.1.windows.1
In-Reply-To: <20181023162941.3840-1-slawica92@hotmail.com>
References: <20181023162941.3840-1-slawica92@hotmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1:

    *changed test title
    *removed subshell and HOME override
    *fixed weird identation
    *unset() replaced with sane_unset()

Slavica (1):
  [Outreachy] t3903-stash: test without configured user name

 t/t3903-stash.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
2.19.1.windows.1

