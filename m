Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 563501F404
	for <e@80x24.org>; Sun, 25 Feb 2018 19:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbeBYTqw (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 14:46:52 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:40395 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeBYTqu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 14:46:50 -0500
Received: by mail-wr0-f177.google.com with SMTP id o76so19090843wrb.7
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 11:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qUb6lIZUZhI/MXZHNl9CnxuNdVaWyoaOLUvRNi9CXpQ=;
        b=XMFF1rSE6vx+X2hh+lQcXpdFbmP05owHmDyUo1G52r2vSDhfwLbIBUlyqPo9HA4vBg
         hFL27iRh8C3F3VKYSDz4YiY3j4IEaQg3Hb4eIC2s5JkqlJLqHGMTVWJ6LsTZLCBA7zsr
         Xc1tWVdppqfNv2lZhqLU88njISLOfseRS2qzvJ/NxIib95sdLyI2JI/Nqx9obr6oeHm2
         OSTnTRx7rMYjIYOghef7p/1FuDVSzfej6oSxUaKEPj3pvDzX4Dis/NTQCtZJa/O8TnMA
         dcfbfCro09gqsOc4bugTVZg8ST9EhzOj680WiYzBng6UqTySUcdBQ14Pv8UewJw1A/Lc
         G6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qUb6lIZUZhI/MXZHNl9CnxuNdVaWyoaOLUvRNi9CXpQ=;
        b=O05P0ZoFdzXD+OPW9yxxQG4bIVZqofUrqv/xw9eoEwknT0Wmpb4+xjVgWG1MsUaNcl
         AEF8XKZ9Vb9++KWy8QJ+fFKVapStyUhJp6lF0O7HZVTqdE1OQr6EFggva2pDPevjNGDz
         uQzsweuTmORHk9L6P0HQFaygeExVcIIAJ4Drv5vi8HLyxaUBVhZ8zH1W6+AzN8pBKW2b
         wsuVg7gYydciSdXWmdJSJp5w2A8pJo/tznRiKB2f+reFal2MCobghgwhPdUCX39tlIe1
         yUHHIgDJ2WFw0XOzuC45TnphIdDS1I/pfpY7AkHjhy7Agn8f6fbfTD75JVJzoXJ0VIdT
         QSbA==
X-Gm-Message-State: APf1xPC6WZVpWg8IWrNMuGSSn92pMx4Q9vOMrDCuXF3ocR+rjYt33888
        bi5IAEtQxe+l5WF1l4mw+s/jY49C
X-Google-Smtp-Source: AH8x2248thf3aozjuWroJg8k1oPBUqSzoTLk4jdUZLEYUirRhyKZPu7Ca8UDD7X/hoYqV3firf140A==
X-Received: by 10.223.201.11 with SMTP id m11mr7967042wrh.146.1519588009059;
        Sun, 25 Feb 2018 11:46:49 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b66sm4394003wmg.28.2018.02.25.11.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2018 11:46:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/13] various perl fixes
Date:   Sun, 25 Feb 2018 19:46:24 +0000
Message-Id: <20180225194637.18630-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180214222146.10655-1-avarab@gmail.com>
References: <20180214222146.10655-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Addresses comments against v1, and ships with a new
NO_PERL_CPAN_FALLBACKS knob (thanks Todd!) which distributions can
turn on to not get our FromCPAN copies. Details below.

Todd Zullinger (1):
  Makefile: add NO_PERL_CPAN_FALLBACKS knob

Some of this was split off into into my "perl: move the
perl/Git/FromCPAN tree to perl/FromCPAN", and I added "This option is
intended[...]" to the Makefile documentation.

Ævar Arnfjörð Bjarmason (12):
  perl: *.pm files should not have the executable bit

JN: Rephrased commit message.

  Git.pm: remove redundant "use strict" from sub-package
  Git.pm: add the "use warnings" pragma

These are both new, something I noticed and seems sensible to fix
while we're at it.

  gitweb: hard-depend on the Digest::MD5 5.8 module
  Git.pm: hard-depend on the File::{Temp,Spec} modules
  git-send-email: unconditionally use Net::{SMTP,Domain}

These all "use" the modules now, instead of using "require".

JN: Removed a comment from the gitweb code that isn't needed anymore.

Clarifications / fixes to the commit messages. 

  perl: update our ancient copy of Error.pm

Rephrased commit message.

  perl: update our copy of Mail::Address

Actually ships with the working version of Mail::Address now (oops!),
which makes the patch much smaller, and requires less explanation.

  perl: move CPAN loader wrappers to another namespace

JN: Commit message phrasing.

  perl: generalize the Git::LoadCPAN facility

JN: Commit message phrasing, and s/    /\t/g.

  perl: move the perl/Git/FromCPAN tree to perl/FromCPAN
  perl Git::LoadCPAN: emit better errors under NO_PERL_CPAN_FALLBACKS

These are both new. There's now a NO_PERL_CPAN_FALLBACKS option for
distributors to turn on to stop us from installing these CPAN
fallbacks.

13/13 updates the docs, and emits a better error than what we emit now
in master if the CPAN module we expect from the OS isn't installed.

 INSTALL                                 |  11 +-
 Makefile                                |  16 +-
 contrib/examples/git-difftool.perl      |   2 +-
 git-send-email.perl                     |  28 ++-
 gitweb/INSTALL                          |   3 +-
 gitweb/gitweb.perl                      |  17 +-
 perl/FromCPAN/.gitattributes            |   1 +
 perl/{Git => }/FromCPAN/Error.pm        | 296 +++++++++++++++++++++++++++-----
 perl/{Git => }/FromCPAN/Mail/Address.pm |   8 +-
 perl/Git.pm                             |  14 +-
 perl/Git/Error.pm                       |  46 -----
 perl/Git/LoadCPAN.pm                    | 104 +++++++++++
 perl/Git/LoadCPAN/Error.pm              |  10 ++
 perl/Git/LoadCPAN/Mail/Address.pm       |  10 ++
 perl/Git/Mail/Address.pm                |  24 ---
 15 files changed, 432 insertions(+), 158 deletions(-)
 create mode 100644 perl/FromCPAN/.gitattributes
 rename perl/{Git => }/FromCPAN/Error.pm (72%)
 rename perl/{Git => }/FromCPAN/Mail/Address.pm (96%)
 delete mode 100644 perl/Git/Error.pm
 create mode 100644 perl/Git/LoadCPAN.pm
 create mode 100644 perl/Git/LoadCPAN/Error.pm
 create mode 100644 perl/Git/LoadCPAN/Mail/Address.pm
 delete mode 100755 perl/Git/Mail/Address.pm

-- 
2.15.1.424.g9478a66081

