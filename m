Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CA811F461
	for <e@80x24.org>; Tue, 14 May 2019 09:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfENJ2y (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 05:28:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38522 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfENJ2x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 05:28:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so8327324pgl.5
        for <git@vger.kernel.org>; Tue, 14 May 2019 02:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8MD+9ut2P39ROOiWKRzpieBySvREfORAbqU4Qn4T6tM=;
        b=limd2ymaTikBZMbK1WXZs9Wzm/YliTki1TnlIrfh7L7YmXFs+gGofAnpv+Hvr/HrUN
         7jRlmekx+4KI/WLbGvKsLqZ0ejuC6j7HuFPBdrN2hVIZPjbPq+VMSHGdDj8WcQ2a4OZQ
         CkwKZC1bAfZBXTJQWr6Z4xsp76hUzk83Bjx1nBz90cVWVDicpto7c7qQfrQLWK3feLev
         fR90NKkmyW/FfNki+fv4l87YS8cK/hU/s5/rdh2ZA1CMg8D1cugRyKkI255Z6p0OQsIz
         cMjZvmoCMDUWRtf2XvCVkYp8NX/jg0WHtJD8fs9pXd7tUcXHLBTsjSmI08oIWt7n2Y65
         9fNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8MD+9ut2P39ROOiWKRzpieBySvREfORAbqU4Qn4T6tM=;
        b=KxjSBohLTXKCltWfMb6hT4QCGJAajIwXg4vhNIRSG5YkuwSurQX4zKg0ZRa8U1+3wO
         /UsnI4U/mbQlmmL1etKQdA6T7KJ21d7j3egG/3DoHB1dJh3I5SWyLQfNZJ/o+CbpS7JR
         RWCGvx2/CxLD2P4sHI0mGvGAO/bViWa0BC83WenjlUsKLXLrKWF9MhYSrQeQgqHkwqfX
         Vas1ZudSpswGqifr1lQQTtKMhhZtwPvZWYzVwqMKm9HYQjZaaLCiNRHO23IaUxhQxyZy
         //mF6OqCQkG0cxvfeJemDZ3mWkcVkkoZ5h9KjF2m72VdBbvW40bjJKlTau08ohLpkC0Y
         IjAw==
X-Gm-Message-State: APjAAAV33QNQURZyanfOnXlShyipxTXWY+neeGVVkWK28jRF81vELh4V
        cWWO0RlbhBcjO0gCxxtPD80eeq4n1yoX10dy
X-Google-Smtp-Source: APXvYqx6L0RIZjVFPqpbezfCgfHWDNI0KsZtGtEYJK7bIEuhBYwT90exS1a5FYCbzcLntsU0m/z8bA==
X-Received: by 2002:aa7:8296:: with SMTP id s22mr40385815pfm.52.1557826133056;
        Tue, 14 May 2019 02:28:53 -0700 (PDT)
Received: from localhost.localdomain ([2408:84e1:44:1b22:8d25:6fb1:5ad2:92c0])
        by smtp.gmail.com with ESMTPSA id i12sm18347940pgb.61.2019.05.14.02.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 02:28:52 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
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
Subject: [L10N] Kickoff for Git 2.22.0 round #1
Date:   Tue, 14 May 2019 17:28:34 +0800
Message-Id: <20190514092834.2003-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.21.0.3.g3ece05c5f4
In-Reply-To: <y>
References: <y>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.22.0-rc0 has been released, and it's time to start new round of git l10n.
This time there are 270 updated messages need to be translated since last
update.  Let's start new round of git l10n based on the following commit:


    l10n: git.pot: v2.22.0 round 1 (270 new, 56 removed)
    
    Generate po/git.pot from v2.22.0-rc0 for git v2.22.0 l10n round 1.
    
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin
