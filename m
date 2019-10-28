Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 254681F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 05:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbfJ1F6t (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 01:58:49 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:34978 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfJ1F6t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 01:58:49 -0400
Received: by mail-pf1-f180.google.com with SMTP id d13so5093120pfq.2
        for <git@vger.kernel.org>; Sun, 27 Oct 2019 22:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FK83Q01sgz6POJt+ag5/aATygdh304LLdL2ztDOyRiE=;
        b=qmKUYqUo1I7/0tBv0Ezqmo+CY4BrDaU667EeBQSkTKclOMTtVL/5RNOFocg9iYx2/L
         nZJBASyAr2W0lT/oNYgi83GMk2LLhhchSd90JgKOjoYr9IHN9g6QB+QfYI/yZ5afR4mB
         7Jqkrhi8fC0Wtgx20gJFq5qlrx2ud7DnvwHiv86QphSxwzxeemTOw46uyOZRPJqCXN00
         YYXBOKkr87T0jVRzalVrpLCzsNBHuxI9jHBafY0SRSNauzF+6dQVY96+mpvzhAoiexve
         O8ijo3kMjAm4SIwLTyqlwHzu/2qUGXZVA0nVEWsdEKmV+VTq8V2VbKR3CD+ywzG7A8Rr
         lmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FK83Q01sgz6POJt+ag5/aATygdh304LLdL2ztDOyRiE=;
        b=m8hAVMMuW6yRMEgpM68RNmmCApCma7xpcQxziSopTSOtNzAnvDCkEKv6wd6UYZwGw+
         NyYiM2Ph/kz7F74i2onqgPTdrHxD+Azp5SVuyUZmODyA2hY8N1G/ahkPpgGIZFrRYN1B
         mH/BNQw+ssZDszKhYEDwyZPG2QUWKpIlExbeAxneaGdL4NjrC4Oo4Na4cwW3Qho7M994
         0ceapLuTtuaEWegtjfSg064wwKntHVIvV2hs8G1LcGjRc40OL7pX2iZhwScQpeQ5g2id
         CW+Q8j8CFxiMjb/qrYAekWXTlTeeBrXEaD3KugbZ7NYqNRbNkAehJDggEs59M0TLskfh
         QrmA==
X-Gm-Message-State: APjAAAUVs90v+C7ZOJDXySACK8T6Vjs/XzcxwJ3ZFita6Fq+fep14jQf
        ltK5YnWF8CCZjzeR3najWMBC1FcwbbGUsw==
X-Google-Smtp-Source: APXvYqzYad/unasiymyzBv9hCbmWTwa5aYm/UMsBx2w44om7hIe5j3nEljFAB30QWqoYZqeB7rFOlg==
X-Received: by 2002:a63:d651:: with SMTP id d17mr19846753pgj.106.1572242328694;
        Sun, 27 Oct 2019 22:58:48 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.4])
        by smtp.gmail.com with ESMTPSA id a23sm9428518pfl.65.2019.10.27.22.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 22:58:47 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
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
Subject: [L10N] Kickoff for Git 2.24.0 round #2
Date:   Mon, 28 Oct 2019 13:58:34 +0800
Message-Id: <20191028055834.96746-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.23.0.3.g72fac68ab1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <worldhello.net@gmail.com>

Hi,

Git v2.24.0-rc1 has been released, and it's time to start new round of git l10n.
This time there is 1 updated message need to be translated since last update:

    l10n: git.pot: v2.24.0 round 2 (1 new)
    
    Generate po/git.pot from v2.24.0-rc1 for git v2.24.0 l10n round 2.
    
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin
