Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F9511F404
	for <e@80x24.org>; Wed, 14 Feb 2018 22:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031700AbeBNWWF (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 17:22:05 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:52641 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031527AbeBNWWE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 17:22:04 -0500
Received: by mail-wm0-f42.google.com with SMTP id j199so13389932wmj.2
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 14:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TA+uyhqot2cQzY4WRWHHLVaRtdnrSbKzEP387R83vzo=;
        b=cF6xsNSOVgudQO2LMTvJFmi82VuDZAQnefbDsqfArO9ZuH+aTBr/d4L2c+iZDOq45H
         0jPsHiVvPSq2lF09qvxtz54lH4OPt+Tbv78h4dUCU0/BXFJxDKl/UUrNmF7Sw9uMVjih
         Um7oCwIrAnWtj6uWxzl2Iz/jFkt39LwDbIkc+W6uV2ZZpQ+8O1Z3kpmbFrdHL28jA/o4
         D1TpqqCs7FZh93/nChaktSZYbEdS5S45VEiYROo2HVwWx1R4drw8xkODR+RGrl6glweS
         u9uqN4wLilXYHTKz7VprERIp0W4gkrYrawsj3aYf39208pfB4OhSFlT6fRFUYapC+y6R
         ZoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TA+uyhqot2cQzY4WRWHHLVaRtdnrSbKzEP387R83vzo=;
        b=d1RDjdvpAnZJnSMucEexCSlCCGnOpaLpmS3KeVPTU09U7RoAe4OzhkgN0swxGUkZwT
         u06pEURpg/clP4z1Zq8Fkq54H30cz/aPxEt5dZCIjSh9ylADmAiECQRVmEaA8rrN6jn6
         oh85jS2P07DZF7TZ6hELmzzHe6jbP/mT1JgP+MpmMAZUI6hQXEgrQ4HmikaloMrVbRXT
         ivOik5OzyFGUL5jN6sIJRuXaSJXqMqpKiVTovhg6GzSkoQBqGt3XPYj9cy45rdImUGbM
         qQbgj5UTUxJ//0n0Y3g69/NPqwGWXcLw24GldirlH4Gfl6p38eeDmeE56u+GLoK0NQ7E
         e1Ag==
X-Gm-Message-State: APf1xPCMVVIh/PEUUtHDL3ZNTUqcwWXNTXBQqvAuSBXKy2GX9nBxX88D
        gyXUbvCiUy+uOTS+W0KsMaPI0G85
X-Google-Smtp-Source: AH8x2272LDoazwoswCiLn87dtXlaKQQs/Z2Sde7y2VN43gY76fGQaJ8k5CGpHahzbn+4j27f9ZCmhA==
X-Received: by 10.28.48.11 with SMTP id w11mr448859wmw.59.1518646922485;
        Wed, 14 Feb 2018 14:22:02 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a14sm13191356wrf.22.2018.02.14.14.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2018 14:22:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/8] various perl fixes
Date:   Wed, 14 Feb 2018 22:21:38 +0000
Message-Id: <20180214222146.10655-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'd been meaning to submit 3/* once my Makefile.PL removal landed in
master, but noticed a few more things along the way, including the
issue fixed in 1/* which I just noted in
<CACBZZX7xC37W5+MLtYSrBaPawh+QfOSqci_rFOp_ukVi4fp6Gg@mail.gmail.com>,
and while I was at it resolved some of my long-standing TODOs noted in
<87d13jd4fd.fsf@evledraar.gmail.com>, and more.

If you're CC'd on this series it's because one of the commit messages
mentions a commit you authored.

[45]/* do not cleanly pass the default --check, so they have
.gitattributes files to make them pass, as noted in 4/* it's much
easier if we can just use this upstream code as-is, and not accumulate
our own typo/whitespace etc. fixes along the way, which just makes
subsequent updates harder.

Ævar Arnfjörð Bjarmason (8):
  perl: *.pm files should not have the executable bit
  perl: move CPAN loader wrappers to another namespace
  perl: generalize the Git::LoadCPAN facility
  perl: update our ancient copy of Error.pm
  perl: update our copy of Mail::Address
  git-send-email: unconditionally use Net::{SMTP,Domain}
  gitweb: hard-depend on the Digest::MD5 5.8 module
  perl: hard-depend on the File::{Temp,Spec} modules

 contrib/examples/git-difftool.perl    |   2 +-
 git-send-email.perl                   |  28 +--
 gitweb/INSTALL                        |   3 +-
 gitweb/gitweb.perl                    |  17 +-
 perl/Git.pm                           |   7 +-
 perl/Git/Error.pm                     |  46 ----
 perl/Git/FromCPAN/.gitattributes      |   1 +
 perl/Git/FromCPAN/Error.pm            | 296 +++++++++++++++++++----
 perl/Git/FromCPAN/Mail/.gitattributes |   1 +
 perl/Git/FromCPAN/Mail/Address.pm     | 436 +++++++++++++---------------------
 perl/Git/LoadCPAN.pm                  |  74 ++++++
 perl/Git/LoadCPAN/Error.pm            |  10 +
 perl/Git/LoadCPAN/Mail/Address.pm     |  10 +
 perl/Git/Mail/Address.pm              |  24 --
 14 files changed, 537 insertions(+), 418 deletions(-)
 delete mode 100644 perl/Git/Error.pm
 create mode 100644 perl/Git/FromCPAN/.gitattributes
 create mode 100644 perl/Git/FromCPAN/Mail/.gitattributes
 create mode 100644 perl/Git/LoadCPAN.pm
 create mode 100644 perl/Git/LoadCPAN/Error.pm
 create mode 100644 perl/Git/LoadCPAN/Mail/Address.pm
 delete mode 100755 perl/Git/Mail/Address.pm

-- 
2.15.1.424.g9478a66081

