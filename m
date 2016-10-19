Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05CCB20986
	for <e@80x24.org>; Wed, 19 Oct 2016 20:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761633AbcJSUZI (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 16:25:08 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35649 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761622AbcJSUZF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 16:25:05 -0400
Received: by mail-lf0-f66.google.com with SMTP id x79so3898967lff.2
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 13:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K0ttJtuYz+06LfD4eyAfSB4lPMbUnOFlww9riDPs5f0=;
        b=Bb8YJdJTp9O0jia1/bcOF524TYgRo+Gw01QHybda4glgxaMjRzuxn4BTAdoseKlRU4
         9XrusGmsdBaaexSVZa1tVJJ9YKSNp8jQh9nqn0eMTC5fMQk1bztJR+b7XBmYwfqKoY7w
         LgsGK3+6q7IuzK8FB4xDVY/B97EOWyaOvYbcaugXYUpQ+J4faO8dFN38837UBQ/sEzdE
         Pj9mAkeQSnkSkyAN8yS1CsztlpUYcC1iAlUNHjnNyAirvUNx7PHKfPAPqTNOxNwIT6Ru
         /A8aMVcG1uq2Vm6A1GTvIiM8NZfq/oavZXgkc46QBluONOrX2nR/OwOVpWNlpJbwLm64
         lmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K0ttJtuYz+06LfD4eyAfSB4lPMbUnOFlww9riDPs5f0=;
        b=hLMteX7bZC049f9onXT0hkXbGevIz5OrCEkWY48Wdxb6/u1TYPjvZEweOAH0dwHSLM
         ADi8zRaWG/BqgKA+cZK6czltZDlNBxLXzxp/SQW5CzVmVw/P1uAswQPFcxTOFYzV26ii
         nUEStRX/ORGL2r/fKbTS8J2J6V+D61kBTIqLvNBnFWNvuVDuhX6To6pWto20DhwORKja
         YylI9A7KN61RHr0z12xzsVatFEfiehVax36gFXbLKyTaoGVKQjej8g8utZweGQz/Vrlu
         7S/40YE4EswURGvrZGAqfnCahe51WXWDy/WGfTVWPMVJJaryKbgWDLsFFFquEHc/iV87
         HKrw==
X-Gm-Message-State: AA6/9Rk3T75Kz9KHo4ctgUHAKPs45jkmWeCb9CCj1YwigcjUEDX8xGm661022E7IhL4wog==
X-Received: by 10.28.47.214 with SMTP id v205mr6555956wmv.76.1476908701295;
        Wed, 19 Oct 2016 13:25:01 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id xq9sm2036669wjb.35.2016.10.19.13.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Oct 2016 13:25:00 -0700 (PDT)
Message-ID: <1476908699.26043.9.camel@kaarsemaker.net>
Subject: Re: [PATCH v12 3/8] graph: add support for --line-prefix on all
 graph-aware output
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 19 Oct 2016 22:24:59 +0200
In-Reply-To: <20160831232725.28205-4-jacob.e.keller@intel.com>
References: <20160831232725.28205-1-jacob.e.keller@intel.com>
         <20160831232725.28205-4-jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.0-2ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2016-08-31 at 16:27 -0700, Jacob Keller wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
> 
> Add an extension to git-diff and git-log (and any other graph-aware
> displayable output) such that "--line-prefix=<string>" will print the
> additional line-prefix on every line of output.

This patch breaks git rev-list --header, also breaking gitweb.

The NUL between commits has gone missing, causing gitweb to interpret
the output of git rev-list as one commit.

Sorry for not catching this earlier, I actually encountered this early
september but thought it was caused by us running an ancient gitweb
with a modern git. Finally managed to upgrade gitweb today, and the bug
didn't go away. git bisect says 660e113ce is the culprit. Checking out
'next' and reverting this single patch makes the problem disappear.

Haven't yet tried to fix the bug, but this hunk looks suspicious:

-                       if (revs->commit_format != CMIT_FMT_USERFORMAT ||
-                           buf.len) {
-                               fwrite(buf.buf, 1, buf.len, stdout);
-                               putchar(info->hdr_termination);
-                       }
+                       /*
+                        * If the message buffer is empty, just show
+                        * the rest of the graph output for this
+                        * commit.
+                        */
+                       if (graph_show_remainder(revs->graph))
+                               putchar('\n');
+                       if (revs->commit_format == CMIT_FMT_ONELINE)
+                          

D.
