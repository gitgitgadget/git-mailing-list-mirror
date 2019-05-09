Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FA9E1F45F
	for <e@80x24.org>; Thu,  9 May 2019 11:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfEILsn (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 07:48:43 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:36421 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfEILsn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 07:48:43 -0400
Received: by mail-wr1-f50.google.com with SMTP id o4so2632167wra.3
        for <git@vger.kernel.org>; Thu, 09 May 2019 04:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3LSZ1hIrLVlRdMmoZSkLQeYd1WQcZAG4PQTaYAAmUtk=;
        b=PKdX5JIv4MUSMUSfmGBxcsJWMQ2sfFWg6wD876PPV9jN9tT35bsuW5GJWdTYQgLZ6h
         9Jaz2OYMCo8TvUWvFqHbCOGkjbd6MSzVksfRJ7WO5EOfbMMnZVehYMoNv4h2HglCZS5b
         oPbcpgxyAPQVZ6Qk8F2GzrWVrg6Y/5XmIqOGjk4BYg0HZhL9AISFCwjHp5tOJxSiHaEH
         EPj3wmN5/Zi72lh57HVH2JO8sJJc+FLlqZpRHQs2w3uDLyXDTgYCVplzM/D9wsKS4yf2
         Bh63z0xbmIufJGADNgLUdgijbe1hK5/fkkbpuvxDuxsjac2oU8wkd92Lx71pJ2fJoLqt
         5eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3LSZ1hIrLVlRdMmoZSkLQeYd1WQcZAG4PQTaYAAmUtk=;
        b=Dj9AwdsTWeMGARctOeZAw5b9i0vH9sTcNTsTsXxAsab+AedHmZW+S9Qx3+phT7TKCV
         ATFTiABlKnaN/eIS1pmm018ZtoaB6MpyzMug1/Cro8+Ltn0dQiFS24xj2hV1z8W5ZZj2
         2RPJTWtjCF8aPWeM/mlcTvP4qLGH9jXayrgiuNSG5RlM16CA1Y5TK6ZieCF4OirFz9WE
         WhUqlxADQa1t5YlBAOyfTvQc7ghT1fljiSXXvnFnpoqW4kQO+D3RT7JtVL/ULDhlgb9v
         SpDYNyonf8j3kuPHJ7aKztGIXLMdyKwbUgvGt31BjtD0m73+zDmcxnpdFAAZsEwHfJty
         3/Tg==
X-Gm-Message-State: APjAAAUbQm7kXz+9jYBs8SnWknfPi0sJqFexXRv+ufuTKW3ylcQB0EQn
        dDM00CrbWM5DwjvSlEo3xaDmYcMB
X-Google-Smtp-Source: APXvYqyy8A2NrYVlnmrpH+ukvpbePZ+XoUhfTofVPShuHdzlJLV1Y32U259jgGJRhWS/+SEnEamH7g==
X-Received: by 2002:adf:978b:: with SMTP id s11mr2645530wrb.169.1557402521214;
        Thu, 09 May 2019 04:48:41 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f1sm1610807wrc.93.2019.05.09.04.48.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 09 May 2019 04:48:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Brian M Carlson <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/3] send-email: fix cli->config parsing crazyness
Date:   Thu,  9 May 2019 13:48:27 +0200
Message-Id: <20190509114830.29647-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <20190508105607.178244-1-gitster@pobox.com>
References: <20190508105607.178244-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a proposed replacement for Junio's version of the
sendemail.transferencoding bugfix. As explained in 3/3 I think the
root cause is that we're needlessly doing the config->cli parsing in
the wrong order, so let's just fix that.

It fixes the bug at hand, and makes the coge less fragile for future
maintenance.

Ævar Arnfjörð Bjarmason (3):
  send-email: move the read_config() function above getopts
  send-email: rename the @bcclist variable for consistency
  send-email: do defaults -> config -> getopt in that order

 git-send-email.perl   | 179 ++++++++++++++++++++++--------------------
 t/t9001-send-email.sh |  13 ++-
 2 files changed, 105 insertions(+), 87 deletions(-)

-- 
2.21.0.1020.gf2820cf01a

