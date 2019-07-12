Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B0F61F461
	for <e@80x24.org>; Fri, 12 Jul 2019 15:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfGLP7K (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 11:59:10 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44003 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfGLP7K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 11:59:10 -0400
Received: by mail-oi1-f194.google.com with SMTP id w79so7637620oif.10
        for <git@vger.kernel.org>; Fri, 12 Jul 2019 08:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=XlOIBvKIWPohVup3X+dQPnmcmRRzzrh9zKOg00QzFYM=;
        b=FuzUQvyxMt0oouAfF2PMjOfBGLqzHaLkHM1Zhhck42mU8hUhSmDOSYB9NVEuy0gvLI
         T0d/UJIqejcYnpwvp/bmvmnn3w5la6YjghfWEeq05O27n8wmLRRsERt214R/3yfCK8wE
         Cb/NO/sPTSiIAYHtEy8MHdan7VA0ij1Ebxk7SlOqOzgTYOeXkgvHVclvuqtnJY5V1bbO
         6K9WfAz19/BEP/U6AO138Zo7ozh4H+gd8MZ9/iJwNgx9cXm5ij5oEInJQmi7O48iDmgn
         ZqddlAz+sawQGhatWlE+Kjt/Jj1aVlO3izInq9yX2DMr2uO+ADdXJxlFw5kbKWPzBFAc
         zWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XlOIBvKIWPohVup3X+dQPnmcmRRzzrh9zKOg00QzFYM=;
        b=T0LZIC67sKUy+eT59pQ0MZeMVUtEmSLUrbR76p5JnUnPHj3L9C2bAiN6aGp2Cdl9EA
         rEQ8JaPtICu4ENH2VSq7ITFypCMA2fIugSn31VpHYkMfU3mrW/3uyHHBM5lietfr0dFL
         2JrUixmANh/jx4BGdVGQoWJ+avH99kmq19nkBpRlmNWxEg7TbOviyf5y/fk9CBnY01St
         qm8GQSKnVnEJF/9iAXSljqjsubR65LIpoMzfwMbj+N09pkdOeUqkWdWRPi7DfIvgvaU3
         Gxsi+kU+IRDYtqxdL+/80R7ije+srK5KbuVnlrAuHVkU6CmXwQOaGOS25+/9IQuNvkzB
         H05Q==
X-Gm-Message-State: APjAAAUEjX/VDFdv7ssMyEVFh/7y3Qr/QPnHPZvcNgKtuOouJ8wScH+y
        WMJwPIpuQl+dtqK/0+ZCYhgfRMjJ
X-Google-Smtp-Source: APXvYqw7g+7S064HirWVucB0caZRUMDfmgvAPy1evdWb2aklbRfduWTq0k3W3N91Na3udJIK+IWCBg==
X-Received: by 2002:aca:1e1a:: with SMTP id m26mr3692453oic.19.1562947149062;
        Fri, 12 Jul 2019 08:59:09 -0700 (PDT)
Received: from nanabozho.attlocal.net ([2600:1700:8660:6160:c055:b92a:b249:c6a6])
        by smtp.gmail.com with ESMTPSA id w13sm2920583oih.17.2019.07.12.08.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 08:59:08 -0700 (PDT)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     git@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH v1 0/2] document deprecation of log.mailmap=false default
Date:   Fri, 12 Jul 2019 10:58:59 -0500
Message-Id: <20190712155901.19210-1-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.17.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Based on the discussion of the previous patches, we concluded that
changing the default will require a transitional period.

As such, I have introduced a deprecation warning that is printed when
the log builtin commands are used.

Thanks to Junio and everyone else for providing feedback on how to
proceed.

Ariadne Conill (2):
  log: add warning for unspecified log.mailmap setting
  documentation: mention --no-use-mailmap and log.mailmap false setting

 Documentation/config/log.txt |  3 ++-
 Documentation/git-log.txt    |  2 +-
 builtin/log.c                | 17 ++++++++++++++++-
 3 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.17.1

