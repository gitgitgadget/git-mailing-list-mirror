Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A0361F404
	for <e@80x24.org>; Sat, 24 Mar 2018 05:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750825AbeCXFhS (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 01:37:18 -0400
Received: from mail-pl0-f54.google.com ([209.85.160.54]:40028 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750801AbeCXFhR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 01:37:17 -0400
Received: by mail-pl0-f54.google.com with SMTP id x4-v6so8707120pln.7
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 22:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ZWHUHyZX2tWyP6fQA/H72k3ePxp1bRGCER0iIfxeMPE=;
        b=iu6GN/qNWvGkq1ZVpwYEPyd6OI6CUU9IYURTacy/sP1KDAm14hTWJWUFht41zP/kYz
         RIJHhxV+QUb6THQIctfoCnS3tw16+fe/omhD44sTG2azMEqXtgept1Y3gW0IgHtUQXPg
         1JUwfN1S4GFuwM6fLxAOwFSTvFfB6qefkgsv4XLnTPHWqs4mORape2GMzsDWWnaXMSso
         sYTJGiqJuB5XxK5rnQIeG/yVOAbywTbA2Mt0EVCHbfmElfuya/7jWCXIDK2yP3P7qi9w
         3zDp85arKstDHYVUVFG5rNZFwIOMItRP8You6oTQIvDDDzBnE4wu0XRsZjAQA+7Dl0cy
         /l4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZWHUHyZX2tWyP6fQA/H72k3ePxp1bRGCER0iIfxeMPE=;
        b=cqauYjTsnDg6nZT19Y9RYo82CxwtcagqQ1ewFUtOXuoWIOL3rCk2gmtvh++Ec8nh0d
         yX+/ZUgvMobBaf52HNM9Fvy5alzZjW9ao91FVYyOGQh2sZ5CP2TkaeMX43ETTWFpbk8g
         2fCxvZnL7mxTDX9TDkb4UZ/i0wJ1iPivwnIgLA0X6MoB4GU9ZUHddCl5C/n8QMB2rpHU
         6j7xw/RI8l5cWFrtpk2Xk9S6ID4lK2mhTUXjHeNoI76pOORJFpDGiJlxw6Db7WcC+JoY
         e3nHnunk0BUYQ5II7qa787Nng5ygK/4GhucYh72hn1gQCErcy/x2+5ckt3ZMoVlYD4TH
         RJ8A==
X-Gm-Message-State: AElRT7EhUKzUH7gqNDQpPNKDdSxZUqNSJQd8gQAiTU6lQMqlVryOaej6
        GRorlQ90+8VupcMw827j2L1MXSs7npU=
X-Google-Smtp-Source: AG47ELu/tcQu4q1CDpBTszf5+TcRwVedtrnk3xRLCIX3YMKj4HtFNMAc13XI16Gw46DQ44aFhHYZKw==
X-Received: by 2002:a17:902:30a3:: with SMTP id v32-v6mr27096290plb.123.1521869836504;
        Fri, 23 Mar 2018 22:37:16 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id h2sm22691447pfd.119.2018.03.23.22.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 22:37:14 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, gitster@pobox.com,
        jeffhost@microsoft.com
Subject: [RFC PATCH 0/1] json-writer: incorrect format specifier
Date:   Fri, 23 Mar 2018 22:37:10 -0700
Message-Id: <cover.1521868951.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Building the pu branch at commit 8b49f5c076c using Travis-CI all
of the linux builds are green but the two OSX builds are red[1] and
the logs show compile errors:

    CC ident.o
    CC json-writer.o

json-writer.c:123:38:  error:  format specifies type 'uintmax_t' (aka 'unsigned long') but the argument has type 'uint64_t' (aka 'unsigned long long') [-Werror,-Wformat]

        strbuf_addf(&jw->json, ":%"PRIuMAX, value);
                                 ~~         ^~~~~
json-writer.c:228:37:  error:  format specifies type 'uintmax_t' (aka 'unsigned long') but the argument has type 'uint64_t' (aka 'unsigned long long') [-Werror,-Wformat] [0m

        strbuf_addf(&jw->json, "%"PRIuMAX, value);
                                ~~         ^~~~~
2 errors generated.
make: *** [json-writer.o] Error 1
make: *** Waiting for unfinished jobs....

[RFC Patch 1/1] changes the PRIuMax to PRIu64 to correct the compile error
and now Travis-CI is green [2].

[1]: https://travis-ci.org/winksaville/git/builds/357660624
[2]: https://travis-ci.org/winksaville/git/builds/357681929

Wink Saville (1):
  json-writer: incorrect format specifier

 json-writer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.16.2

