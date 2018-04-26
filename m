Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9883E1F424
	for <e@80x24.org>; Thu, 26 Apr 2018 04:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751040AbeDZEZV (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 00:25:21 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:43753 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbeDZEZV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 00:25:21 -0400
Received: by mail-pg0-f54.google.com with SMTP id f132so14917750pgc.10
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 21:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=V50SaxPTMUtNQoOghmg1N8ysp0vZnOW/Atr41IM07Pk=;
        b=TAZuUZegVhhPpjW4/UkLFxy4Nl4m1H3jJYO4vuH8CfgWDOGx1ZHy13JVP50Qi7IIxQ
         hiN16GY90Q01FVuLNDB9ODbE9Ovn5uPWp13YP4vyX5iX0bow1N7KZjNkMmqPh9DlVWil
         OWkGwkDau/qO789+GRZfuyQl4Zpsr5VISOmw66/z1Q1AZa/DRo+Q/fvDOIQinkLisIka
         /hyEl18PnNjcdIQWElNvGvhfumHpv11Hw9RTL769TniVb4pJ8Jsuoakoi8msBy1qZCCb
         n31fD7VoCXZyDdvafNV2llTXij+IrRh160e26Fx2EKR6B+DZYjwBmqpYMU8HpSqWyO44
         JPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=V50SaxPTMUtNQoOghmg1N8ysp0vZnOW/Atr41IM07Pk=;
        b=GxVYjQHh05BCfKflRTdQwJ+Hh5dn91UbB1uYlk4t29BwxVLVknsUYtWAt5FT3FaT+6
         eTFok8HrYi6xqjeyCeHpb+KGS4MThC+3xWYt1wHYtMk/eQpAijfvcvW4/5ZzW5/RlMFi
         zbE0X5m5M0tTYV6+mLMBWxmeqRqfVD2svbfWTp7NR8MsTj84mider94v657JqZfEZejw
         9zq6WfvfLeWlNQeR8Y1fB7V6/AD0HDaTsHG5K7Pco3IHne5UwEVIkDIsoVgHAiMu8XnL
         oqNwQe1di0cqHqCUj+4h3nqadIa7OK9aQYm+y+NGQvuH/hOmFja1VCx+k1n9nCMfV1xq
         hr7Q==
X-Gm-Message-State: ALQs6tC6sdGIACnGU3RdJiQo6wMyRVHkXckdNBvTDRvqEjYLWFCGE9cj
        fs2zTcMoDCCStKhWWpdBs1ymVlGvIuM=
X-Google-Smtp-Source: AIpwx4/jL/Yo+c/7wEfD3BEbIp+KC7A+AvKi2gGJmEa6708dEg85QluY+vHpGGG0c1dO9R0iuuIBwQ==
X-Received: by 2002:a17:902:784c:: with SMTP id e12-v6mr32140631pln.60.1524716719786;
        Wed, 25 Apr 2018 21:25:19 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:b5ff:86d4:d359:c7bd])
        by smtp.gmail.com with ESMTPSA id x2sm719744pfk.113.2018.04.25.21.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 21:25:18 -0700 (PDT)
Date:   Wed, 25 Apr 2018 21:25:17 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH 0/5] builtin/config.c: combined series '--type', '--default'
Message-ID: <cover.1524716420.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is a combination of my two series to add [--type=<type>] and
[--default=<valu>] to 'git-config(1)'.

I have not changed anything in these patches since their last review in
[1], [2], other than to:

  * Ensure that they merge cleanly into 'master' and,

  * Incorporate the patch that I sent to Junio in [3], to remove any
    decl-after-statement's.

My intention is that these patches will be easier to queue together and
at the same time, rather than individually. This was suggested to me by
Eric in [4].


Thanks,
Taylor

[1]: https://public-inbox.org/git/xmqq8t9jgbe1.fsf@gitster-ct.c.googlers.com
[2]: https://public-inbox.org/git/xmqqk1tf4yhl.fsf@gitster-ct.c.googlers.com
[3]: https://public-inbox.org/git/20180419030142.GA28273@syl.local
[4]: https://public-inbox.org/git/CAPig+cSr744Y293qvgLG8jLHdNsGypkHU6QUQ-AcOyk=-JAbDw@mail.gmail.com

Taylor Blau (5):
  builtin/config.c: treat type specifiers singularly
  builtin/config.c: support `--type=<type>` as preferred alias for
    `--type`
  builtin/config: introduce `--default`
  config.c: introduce 'git_config_color' to parse ANSI colors
  builtin/config: introduce `color` type specifier

 Documentation/git-config.txt |  81 ++++++++++++--------
 builtin/config.c             | 143 ++++++++++++++++++++++++++++-------
 config.c                     |  10 +++
 config.h                     |   1 +
 t/t1300-repo-config.sh       |  93 +++++++++++++++++++++++
 t/t1310-config-default.sh    |  36 +++++++++
 6 files changed, 305 insertions(+), 59 deletions(-)
 create mode 100755 t/t1310-config-default.sh

--
2.17.0
