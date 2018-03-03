Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53A291FAE2
	for <e@80x24.org>; Sat,  3 Mar 2018 15:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbeCCPic (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 10:38:32 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33869 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeCCPia (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 10:38:30 -0500
Received: by mail-wm0-f50.google.com with SMTP id a20so6982663wmd.1
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 07:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k020N21PUFfh1ydbieQHgj8PlDKLSG+vosseRcmMBa8=;
        b=N0ntUIMy3yvKSiRwJIAzkUYwdZNx3Kbv3i9TK1wmgUQJtZushXKKxg/WGhS8Yqkfn9
         vuXsT1Rc/399o6aQGXNpNBBpcNB//sJYBXrHirvp6r9ckgJoATr9aqYpA2rrD5lQbeSr
         6UuCPKgLldMvVH8Rd8bC40TVgABwEXnFi4FrhO/DMTI/YTI2ZioETsBOI8Rl2zcJyIRE
         NixQJOe95wbU3MQ1YZU+p6iGKaK6LGzMvKY+FTtXqiC6HsxJiHyMU174FQ1D+MS3LISz
         HmGEoxDqY9E8+WKCnrKDEpJjiTM1WwALISS9oYTx317/CVP7YRm6GZpwhrlHOdRx+y/F
         NtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k020N21PUFfh1ydbieQHgj8PlDKLSG+vosseRcmMBa8=;
        b=K/T6xH35Gx+V2v5Ld9I6ipID0X062C0f+waR7raPyifk8k5ezDmGTUJ+gYap/DgMgP
         j2ufoErDccN2qaN/jqLPYUTzd5tU1nXb2enE64VkU+F6bh8V3Y/gQKnbeQioGjozu2fr
         oH1GDjjcaJ96IpVv5IsPiGcRw9IgyhMPUfUKzyTYloaC1K5fVQOBu8F/WRpv9DWx5fY5
         aGl/8XfZWHbOAi1TujPAuHVbpyHB3yBq0hkRgPK3wClBlg3lmsJIu1GDXCnWQ8BWQhL9
         NSfT4ZmGncmITwErTr3CsDFHN2ob/ShC+FI6UEvLF3HqxHSPnzqmNQOPvuJxwh3FTvmC
         z7PA==
X-Gm-Message-State: AElRT7F2W7TzSa/PjZ521L2NsQPANOOwZ+Tr7Hg4qr3QGXlCYsLGu45r
        ja0FpCIRK8Vx/F2VdEgRFPGLNBwz
X-Google-Smtp-Source: AG47ELtmoDAjgJO++CwZSNGGUttvWdXvsC2y3cbJLSTZT4etuSR3NT4fUmdw2wbiNge450qbaLumTA==
X-Received: by 10.28.8.201 with SMTP id 192mr4048670wmi.47.1520091508918;
        Sat, 03 Mar 2018 07:38:28 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y1sm6899379wrh.80.2018.03.03.07.38.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 07:38:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/13] various perl fixes
Date:   Sat,  3 Mar 2018 15:38:04 +0000
Message-Id: <20180303153817.20270-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180225194637.18630-1-avarab@gmail.com>
References: <20180225194637.18630-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Same as v2 except rebased on master & a couple of commit message
fixes, thanks to Eric Sunshine (thanks!). tbdiff with v2:

 4: 0d67af28fb !  4: 8ad874c944 gitweb: hard-depend on the Digest::MD5 5.8 module
    @@ -14,9 +14,6 @@
         always be run on at least 5.8, so there's no need to mention
         Digest::MD5 as a required module in the documentation, let's instead
         say that we require perl 5.8.
    -    
    -    As with the preceding Net::{SMTP,Domain} change we now unconditionally
    -    "use" the module instead.
         
         1. $ corelist Digest::MD5
            Data for 2015-02-14
 [...]
 6: 92429af3a3 !  6: 3f44312821 git-send-email: unconditionally use Net::{SMTP,Domain}
    @@ -5,7 +5,7 @@
         The Net::SMTP and Net::Domain were both first released with perl
         v5.7.3[1], since my d48b284183 ("perl: bump the required Perl version
         to 5.8 from 5.6.[21]", 2010-09-24) we've depended on 5.8, so there's
    -    no reason to conditionally require this anymore.
    +    no reason to conditionally require them anymore.
         
         This conditional loading was initially added in
         87840620fd ("send-email: only 'require' instead of 'use' Net::SMTP",

Todd Zullinger (1):
  Makefile: add NO_PERL_CPAN_FALLBACKS knob

Ævar Arnfjörð Bjarmason (12):
  perl: *.pm files should not have the executable bit
  Git.pm: remove redundant "use strict" from sub-package
  Git.pm: add the "use warnings" pragma
  gitweb: hard-depend on the Digest::MD5 5.8 module
  Git.pm: hard-depend on the File::{Temp,Spec} modules
  git-send-email: unconditionally use Net::{SMTP,Domain}
  perl: update our ancient copy of Error.pm
  perl: update our copy of Mail::Address
  perl: move CPAN loader wrappers to another namespace
  perl: generalize the Git::LoadCPAN facility
  perl: move the perl/Git/FromCPAN tree to perl/FromCPAN
  perl Git::LoadCPAN: emit better errors under NO_PERL_CPAN_FALLBACKS

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

