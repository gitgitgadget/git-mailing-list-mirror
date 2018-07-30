Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10EFE1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 21:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbeG3Wim (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 18:38:42 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:34114 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730613AbeG3Wim (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 18:38:42 -0400
Received: by mail-wr1-f52.google.com with SMTP id c13-v6so14309312wrt.1
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 14:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TtMfgmiXvk6y5z9iKOq3eR8YsPV6c4K/WUV4eGOlPDM=;
        b=d7LkPTkYk81x3poQWx2nde72QOpd9VMCa6q4VUfMRnb2slA832GUoYzSn150GiXUNT
         aqjZJnb0mwcTxI7DD+xdktRxWGgiIU6HlZR6x3p35KWb3tRM8arZAh6YqDC00LzA5Vtn
         kns7wDiqy2aQNmc+5dDdaudk8be/+Am97FEzrA3ws3KKry3VaG5O6JoRDvjVb19XA6Zd
         L4C7rj07rr7SLOd9y1V81tXPHt8M8ZDlRJd29l9HEOI/l1hyfsWv1TE6HdXMzr9w/Te8
         UlurCYbH4YGA+FaREEhPgLh1Gc9D+JoKis5KsDLkqSGPbsst81uC4OGcklRjktGBoaSp
         P/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TtMfgmiXvk6y5z9iKOq3eR8YsPV6c4K/WUV4eGOlPDM=;
        b=gU9DBtXsYonywxJkuNN1xeIQJNs4Fxw4HZRaLaYWiHGYyyVpJDPeHfTCLtfxZYOfsL
         SBDbAtHv/5YXpwFXs3jjRAxDhuo0UiDJavHNjglifbTKzuCFz0IXIOc3Lwyo/hC7LSb6
         B3juujykL8e8yGF7ffXUVv8HKw9071yrWrZDFNbszCLDYmFAtHXXe9WDNN3CKFqTuPTT
         7Ipi69l6Ax2XM2ZNnaUBJ/TY/ifwe9tnmTcPUNi3By+r4pDTNeWERM4G4ZRTpjbp2Qhc
         oC0MXBxIMWo182UXm9JHB9c/1EE/euewp10HuDrzjL3YIrDfFvcPaCFuJ7oZKHyEREvF
         UGIQ==
X-Gm-Message-State: AOUpUlFifluKBLGD2v6VN1Gt7JfrOGB5WYceDpQiAhNlcg16YCFQb+l2
        ToipC3mihbs2qIem25/IxGU=
X-Google-Smtp-Source: AAOMgpeqLog8s2q7nsvKtW52NbjhQncXJdtveBCvi8rlNxuCTylCu5uCqFlCH8MM9D/jzSVyqAYDyg==
X-Received: by 2002:adf:a197:: with SMTP id u23-v6mr19907553wru.50.1532984512527;
        Mon, 30 Jul 2018 14:01:52 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b13-v6sm20497093wrn.17.2018.07.30.14.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 14:01:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>, Chen Bin <chenbin.sh@gmail.com>
Subject: Re: [PATCH 1/1] Add the `p4-pre-submit` hook
References: <xmqq36w6rlh7.fsf@gitster-ct.c.googlers.com>
        <20180727112222.19061-1-chenbin.sh@gmail.com>
        <xmqqlg9sfvgr.fsf@gitster-ct.c.googlers.com>
        <CAE5ih7_-Bd6fUhTL-Yxopc-kaUq0jY9ydx_COqDdN02aXz69Sg@mail.gmail.com>
Date:   Mon, 30 Jul 2018 14:01:51 -0700
In-Reply-To: <CAE5ih7_-Bd6fUhTL-Yxopc-kaUq0jY9ydx_COqDdN02aXz69Sg@mail.gmail.com>
        (Luke Diamand's message of "Mon, 30 Jul 2018 20:48:48 +0200")
Message-ID: <xmqq1sbkfneo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> Possibly it should say "it takes no parameters" rather than "it takes
> no parameter"; it is confusing that in English, zero takes the plural
> rather than the singular. There's a PhD in linguistics there for
> someone!

I count three instances.  Will squash in the following while queuing
with your Reviewed-by.

Thanks.

 Documentation/git-p4.txt   | 2 +-
 Documentation/githooks.txt | 2 +-
 git-p4.py                  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index a7aac1b920..41780a5aa9 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -377,7 +377,7 @@ These options can be used to modify 'git p4 submit' behavior.
 Hook for submit
 ~~~~~~~~~~~~~~~
 The `p4-pre-submit` hook is executed if it exists and is executable.
-The hook takes no parameter and nothing from standard input. Exiting with
+The hook takes no parameters and nothing from standard input. Exiting with
 non-zero status from this script prevents `git-p4 submit` from launching.
 
 One usage scenario is to run unit tests in the hook.
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 22fcabbe21..959044347e 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -488,7 +488,7 @@ all files and folders.
 p4-pre-submit
 ~~~~~~~~~~~~~
 
-This hook is invoked by `git-p4 submit`. It takes no parameter and nothing
+This hook is invoked by `git-p4 submit`. It takes no parameters and nothing
 from standard input. Exiting with non-zero status from this script prevent
 `git-p4 submit` from launching. Run `git-p4 submit --help` for details.
 
diff --git a/git-p4.py b/git-p4.py
index 879abfd2b1..7fab255584 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1496,7 +1496,7 @@ def __init__(self):
         ]
         self.description = """Submit changes from git to the perforce depot.\n
     The `p4-pre-submit` hook is executed if it exists and is executable.
-    The hook takes no parameter and nothing from standard input. Exiting with
+    The hook takes no parameters and nothing from standard input. Exiting with
     non-zero status from this script prevents `git-p4 submit` from launching.
 
     One usage scenario is to run unit tests in the hook."""
