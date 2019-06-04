Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B76601F462
	for <e@80x24.org>; Tue,  4 Jun 2019 00:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfFDArN (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 20:47:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32772 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfFDArN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 20:47:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id x15so1785164pfq.0
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 17:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Wq3QWNxkrjtri+Ck1osloZQpiPMlTnXZskidJKZaJCc=;
        b=AJWlXl5QRzkn0WTXkATMBe2V7d4uLKyO8cae09iUTmAaq7vUHJPK5LizNVHsDB1eEP
         CfuoPqS/J8wx17PVfwcdhNjTurDkyAN9npJbUuHWht3eEMuMWntbTRzD8oqAw8ko0IoE
         ZA5h5kCrzPceV9CXzWSD0xhX0TmKaOsXmWTvG6dhxmVN8wBxEt5jwSmjE9UCBClHlswe
         Z4rjir7eWRBCPhK78HKQRrSG5ghD5tqmI1C1ViAWLtTeoMBEnexaaEmjmcdd2I15SG9I
         /b0tc94mUxx2FlcrYIGz8oMabzL2o0slyBm4zTUBPV9Y0n8mWb3oxaOvO4tjeDsWoayh
         /Ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wq3QWNxkrjtri+Ck1osloZQpiPMlTnXZskidJKZaJCc=;
        b=OUwBUBNFg9d1T4/1wVVycJlpBnyZajTQwCTJG8Lqj2PDW2kjdiZiSiIWIMbxrfFcXe
         ECBKJHtqcM+cum7rJIMGLQYrLsPb6pngkdIzTpqwxg7zTwXVk1AT3O9aoIjwwKvk2WHB
         ArDj3sdhPEtJDl4I85pn0leEkcV7msiYmhRzKjTOAAYPDHa1QM793IB6Eh/e70PEYLSY
         CgTRprozfESBSc5j+l0ZdQUDianC47NY/FrPlqgGLATCvOu/jgIv2MjKQQExM0l/E6y1
         65v6BNng6iySQDKWhqaeZoCF5vRfUsB1j6nGMevxk4c2aXWShylZm6RtyI4gZIp23rqg
         26Sg==
X-Gm-Message-State: APjAAAUPerjUK5VTlo25WDyrrfRtDhVu5GjD2CXhc44LZ2PMo4h++flQ
        WsKAVi+A9Sz0N0GQDnoHGybAr7GNttq2NaeV
X-Google-Smtp-Source: APXvYqxUTohZaqgXKooHPG/WETvpYvJXomp8pBsixENaVIAj3Ylu87V3s6pavj+q++zsdvKv4Kkb/A==
X-Received: by 2002:a62:fb10:: with SMTP id x16mr35257472pfm.112.1559609232345;
        Mon, 03 Jun 2019 17:47:12 -0700 (PDT)
Received: from localhost.localdomain ([2408:84e1:124:6b0d:65c5:bc73:cd52:9a5c])
        by smtp.gmail.com with ESMTPSA id b18sm29928429pfp.32.2019.06.03.17.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 17:47:11 -0700 (PDT)
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
Subject: [L10N] Kickoff for Git 2.22.0 round #3
Date:   Tue,  4 Jun 2019 08:46:40 +0800
Message-Id: <20190604004640.3935-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.22.0.rc2.14.g03eb6640cb.dirty
In-Reply-To: <2609655.nBnP9L6vNR@cayenne>
References: <20190602151122.7512-1-worldhello.net@gmail.com> <2609655.nBnP9L6vNR@cayenne>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.22.0-rc3 has been released, and there are 3 new localizable strings.
Let's start new round of git l10n based on the following commit:

    l10n: git.pot: v2.22.0 round 3 (3 new, 2 removed)
    
    Generate po/git.pot from v2.22.0-rc3 for git v2.22.0 l10n round 3.
    
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin
