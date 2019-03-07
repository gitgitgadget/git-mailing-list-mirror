Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C639920248
	for <e@80x24.org>; Thu,  7 Mar 2019 08:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfCGIZ3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 03:25:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39825 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfCGIZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 03:25:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id h8so10680474pgp.6
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 00:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s5yVnb2GMeyzC5xP2YU1Usy7h2AyRrAiiuMTwpsTGzY=;
        b=QiGQ96bDzkgm8iVMnP84MOlI3t9W4ZeO7HdeuZ+T1L8xYVpefDHzz4NZSiOIUR+rZX
         4vSm8hpk1qvOzEr5IX/JOVF3qQ0VQAD1qOmy9DTc+m9Kjtsl7lPxHlDeqOOVt17qa1vf
         2M9Ohe3GGfSw1T2jfT9JeXq8zyH7Q4AXnxON+e5CbLKRtpJ21S3A/Cl/X/qkOU+OKEhg
         DSwJulBQ4QYt8P0Cp/O1HusHPsGBZHaMkLtJCkw3tju3PqWQ+DRC+kaWG6YHEt2IVGDf
         5S0ss0IDP/LNFRtlUwRN+UUOlRI63aUMWVQk1oS+/CPk6JRcABumggM7KySrnEPgR9Id
         KkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s5yVnb2GMeyzC5xP2YU1Usy7h2AyRrAiiuMTwpsTGzY=;
        b=KBG41gpFW3XKeWUFRmmTcSbGhD4QubkrQShzMkstrvSt1t0g5uOCbLciCTN4X/KQLK
         BacLvS9iagiYqh9XiVHTeU87JvnD2z+5INxCZy15CogiVEPUGO53CnuhEe35VZ7VAs7D
         DlGpdXqC0v1rpRea+TPCzwqpYb5AigQEFb04JFriEu2etyIrWiaI9D9LbPd+ywHr1hG2
         HkSmL02yqVbCHQqQzzJqjY+FLJqbGWqXnkk0MRbwgye7fWNFyHa+jonNzYZlYTh9749H
         V7vLSpE1HGusNvUpTDk2uf4DOAwP55LyPvyBOoGkAuKqUz2uVwVoqIOaeqaNkZkI2TTG
         BCLQ==
X-Gm-Message-State: APjAAAWdNAMT+z45D0V2prpppeUEMbtvaLbGmEzF5QkQwPI+W9t4aTPw
        s1jomJpROWVZpInSazyI+934YH15
X-Google-Smtp-Source: APXvYqxNbYDznQOc6cQJgN4kOXEl8W77rF1rLCq4kuTm+gsyuYTK15wHqM1nmEIPj+p61Rrv9q5Izg==
X-Received: by 2002:a63:2a89:: with SMTP id q131mr10365716pgq.193.1551947128315;
        Thu, 07 Mar 2019 00:25:28 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id j14sm7111308pfn.77.2019.03.07.00.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 00:25:27 -0800 (PST)
Date:   Thu, 7 Mar 2019 00:25:25 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/2] consolidate core.excludesFile docs
Message-ID: <cover.1551947030.git.liu.denton@gmail.com>
References: <cover.1551938421.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1551938421.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert reported that core.excludesFile was not mentioned in the
git-clean docs[1]. This cleans that up by mentioning that in the docs.

[1]: https://public-inbox.org/git/alpine.LFD.2.21.1902231328560.2222@localhost.localdomain/

Changes since v1:

* Use Martin's suggestions of referencing the gitignore(5) instead of
  writing an exhaustive list. Also, sprinkle in some backticks ;)

Changes since v2:

* Use Junio's suggestion for rephrasing the text in git-clean.txt

* Move core.excludesFile specific documentation out of git-add.txt and into
  gitignore.txt


Denton Liu (2):
  git-clean.txt: clarify ignore pattern files
  Docs: move core.excludesFile from git-add to gitignore

 Documentation/git-add.txt   |  9 ---------
 Documentation/git-clean.txt | 11 +++++------
 Documentation/gitignore.txt |  8 ++++++++
 3 files changed, 13 insertions(+), 15 deletions(-)

-- 
2.21.0.368.gbf248417d7

