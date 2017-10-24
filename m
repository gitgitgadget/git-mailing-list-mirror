Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8E7D1FAED
	for <e@80x24.org>; Tue, 24 Oct 2017 23:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751608AbdJXXmp (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 19:42:45 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:44476 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbdJXXmp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 19:42:45 -0400
Received: by mail-io0-f179.google.com with SMTP id m16so25758451iod.1
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 16:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D88Ywt9R9WMnmXj6yBRSfPPv/bjrpTcWunmAHVySuU8=;
        b=jEFSwer1ZXz+GNUHq/OqDEolRuktmjVLbZgBIC6tmjo9rBYuthk7lKn0PFKao7bUfg
         VfQKS9qVuuSryJBnyTQDGkcRIvCcYsGRdBmVQs+D+q3OdDZxi6QXAYHN3ezlp9mRJ8AB
         A6i/7YDS3FXC5iSdOY33v+1ByBt/NWSrO1dlyJhNGIWyixLKvAoJpEc1UlFIxrPRCFkM
         cL/mw/1abW8qqz0dylZ733hNZzg9p/tZgbTqBPrt2nLcg0+qSn6KLQCG+msTuudgB46v
         j+a/X4/nrEEPi9HYHgpbgzQIldmfeZWLLWhcT1NC+22DcDzOYsewgVLrURpSnrsEBpzN
         FSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D88Ywt9R9WMnmXj6yBRSfPPv/bjrpTcWunmAHVySuU8=;
        b=l4hGE47BsCR2KmESa81hu2zIFpLkIlwiE7/MPGcWavdt07swl17i3JZ4bxI+Av26OU
         tIwxVnpAGRsaO9gRBPQWR3n8Lf9HaEQ4/zKaVwnENMGgp1FlfNjo8GPlu5bhRW4yyZtz
         zmSKpcsrnYBzq/gfX0GNHg5nANmteZokPLC7QtxSMA01jU+obW1V5eWRR96h1v5SPvOA
         +gVkqxpFtHveG3FFaEGDaRMQ5qBRTOUXBVMcOoJu6XEEesi9oA9CyhCZ1mkE2gRxrXhY
         SR6FzaHwG1BZ4eD5/P5En9T9RVB1W1xehtIXUKsnsR9AHX6XJlsqzWRThNDGMh+l7Yb2
         W9EQ==
X-Gm-Message-State: AMCzsaXp5wC9w0qnvw0bzYRNoTKw7IX/KUM88Xa/lGLW4MicRlRqO0rI
        N7uDKpmWuLZbjZ66WE9I2qbVwQ==
X-Google-Smtp-Source: ABhQp+QvFQFbu6kMH/yZ1KxO9qSAYnzrIZq+vrNrXfkiormqLCRrL3djmmEwJjdtbov4LZZ/bGgnEQ==
X-Received: by 10.107.129.166 with SMTP id l38mr24268009ioi.244.1508888564373;
        Tue, 24 Oct 2017 16:42:44 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:24db:446:6fc5:b25b])
        by smtp.gmail.com with ESMTPSA id v5sm588243iog.78.2017.10.24.16.42.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Oct 2017 16:42:43 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        l.s.r@web.de
Subject: [PATCHv2 0/2] (x)diff cleanup: remove duplicate code
Date:   Tue, 24 Oct 2017 16:42:32 -0700
Message-Id: <20171024234234.10944-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.6.g953226eb5f
In-Reply-To: <CAGZ79kZftQoP-Ht+VRakCZsQxh1tjfu=4DFJn_R6fiKD2MmzMA@mail.gmail.com>
References: <CAGZ79kZftQoP-Ht+VRakCZsQxh1tjfu=4DFJn_R6fiKD2MmzMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
* I realized that we don't have to change the hashing function of xdiff;
  we can rather change the hashing function for the move detection,
  which is less fundamental.
  (That way I can shrink the series down to 2 patches)
* commented and renamed function parameters in the exposed xdiff functions.
* applies on top of jk/diff-color-moved-fix.

Thanks,
Stefan

v1:
Junio wrote:

>  * I was hoping that the next_byte() and string_hash() thing, once
>    they are cleaned up, will eventually be shared with the xdiff/
>    code at the lower layer, which needs to do pretty much the same
>    in order to implement various whitespace ignoring options.  I am
>    not sure how well the approach taken by the WIP patch meshes with
>    the needs of the lower layer.

This series does exactly this; although I chose to reuse the code in
xdiff/xutils.c instead of the new fancy next_byte/string_hash, as that
code has seen more exercise already (hence I assume it has fewer bugs
if any as well as its performance implications are well understood).

However to do so, we need to pollute xdiff/xutils.c and include
hashmap.h there (which also requires cache.h as that header has
an inline function using BUG()), which I find a bit unfortunate but
worth the trade off of using better tested code.

Thanks,
Stefan


Stefan Beller (2):
  xdiff-interface: export comparing and hashing strings
  diff.c: get rid of duplicate implementation

 diff.c            | 82 +++----------------------------------------------------
 xdiff-interface.c | 11 ++++++++
 xdiff-interface.h | 16 +++++++++++
 3 files changed, 31 insertions(+), 78 deletions(-)

-- 
2.15.0.rc2.6.g953226eb5f

