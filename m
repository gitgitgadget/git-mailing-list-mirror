Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B8020401
	for <e@80x24.org>; Tue, 27 Jun 2017 12:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752853AbdF0MRc (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 08:17:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33551 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752605AbdF0MRb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 08:17:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id j85so5467425wmj.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 05:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ssWunR0tW4ukapucY2DZT3xdJPI5Z8SeX9A2YC8rT2U=;
        b=tGhND043Xk9hDr3xOVMEogjd8aSuLS4Ab8Bnrkowo98enVT0eDDQh+8VKwQ5VVlAJy
         w6rnSxnP7N5m5AxoMh8slTezQdHeLpGUZSPiTgqN7Kg4X9ozEIw4QpEGUnuTvZLBNOUt
         g/OChSNAnvVN4w2YKlruTbgXvXhRJj/lbu8RK7p4fnfhxalcONUaZjBEBUETb9Z2nX+o
         C3n8hAwiQP18FD25ks7Co0p5qt7yQsL58fl6CW7ZES3dbw/PJgYSe7diEeeeWIbTgI/e
         UtqCS8bGXYDyPUpZOW7YWp2wbgESn2eCjKD7q4sRQo4JfJMg6xO26HQRPIezy1ltN9G9
         ERJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ssWunR0tW4ukapucY2DZT3xdJPI5Z8SeX9A2YC8rT2U=;
        b=bf2bfdvF5ha4qAxkcV670ndmAqH0q7JnM66DVGQ23Jn+1ikM0mExculUY3TE1FAEsM
         Iuohv9FuxbW45ifsym48ivzLXK5MwEByENb5UrD1Fil+ZruOOQt6oKigvwOJJ/emvBQx
         b1Z6lm7G6ZmwwiDzZP6mYJSoo7JpMUL6B3Rt92o9KsivqgCb2w7maasv8eyZ74no6dra
         bhRl4JND70pLoDrzSz/DPvCHoU6xJaUQVNdLyPrtPgvwaZ5J6c4v9nsXBtHgEIHnm/Gp
         erFtVuffPxZYoaxz/kgsCxYBm/IhPX7lJ2+wE2UQ9ddtqIrATFZYV5zZ0jAffgFE5v5s
         bhPw==
X-Gm-Message-State: AKS2vOxpOcqIx0h69P5W7oLVr0a5YEimudpmCdKLNff/KAZnVfefnmS1
        NF9GxySJZh2+V48Y6Zc=
X-Received: by 10.80.145.174 with SMTP id g43mr3741531eda.179.1498565849096;
        Tue, 27 Jun 2017 05:17:29 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l17sm1510926edc.39.2017.06.27.05.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 05:17:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] update sha1dc from PR #36
Date:   Tue, 27 Jun 2017 12:17:15 +0000
Message-Id: <20170627121718.12078-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
References: <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This hopefully fixes the Solaris SPARC issue & doesn't cause
regressions elsewhere, e.g. on Cygwin. Adam, it would be great if you
could test that platform.

I've already confirmed with Michael Kebe + another SPARC user
(CosmicDJ on Freenode #Solaris) that it works on Solaris SPARC. The
question is whether it breaks anything else.

Per the upstream pull request:
https://github.com/cr-marcstevens/sha1collisiondetection/pull/36

Marc would (understandably) like some wider testing of this before
merging it into the upstream project.

WRT the submodule URL & branch changing: I have no idea how
git-submodule handles this in the general case, but it Just Works with
GitHub because it allows fetching arbitrary SHA1s that any ref
(including pull req refs) point to. So on top of pu just doing "git
submodule update" works to update to the new copy.

Junio C Hamano (1):
  sha1collisiondetection: automatically enable when submodule is
    populated

Ævar Arnfjörð Bjarmason (2):
  sha1dc: update from my PR #36
  sha1dc: optionally use sha1collisiondetection as a submodule

 .gitmodules            |  4 +++
 Makefile               | 16 ++++++++++
 hash.h                 |  4 +++
 sha1collisiondetection |  1 +
 sha1dc/sha1.c          | 80 ++++++++++++++++++++++++++++++++++++++------------
 5 files changed, 86 insertions(+), 19 deletions(-)
 create mode 100644 .gitmodules
 create mode 160000 sha1collisiondetection

-- 
2.13.1.611.g7e3b11ae1

