Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B71922022D
	for <e@80x24.org>; Thu, 23 Feb 2017 12:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751112AbdBWMbP (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 07:31:15 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32780 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbdBWMbO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 07:31:14 -0500
Received: by mail-pg0-f66.google.com with SMTP id 5so4450889pgj.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 04:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CJ6dGR/wZEQZ8RJUTO/382NfJ/844DhADW78+/N46pU=;
        b=oTbHwseMvsd9y2m620KmXI4XTzWMqNl2I63sgUTs9uHooNQC86d3m2LYLN3VRuL1sY
         eIBTOH62fs78pL22nRvKO8Nv+iR7iCnX1t+aDQgR2AM41SlORgJYktAVtYZaxK8LQtF8
         3t4v8RZikvM/AMJH1YHmeIua1M0qT4jK311femS9XQvhFHb5PoFnHAt/FBr5R6y/MmYB
         e65I5CaFik/Ob/q6aIlUBWpOO3HOP+dFL0vJCsX43CoxASSyVKBlBe+B9U9EM6tuEYrw
         Gpd+B+VJcjumNUbZTtp8tptJ52wa39k6gkRfrv6dx1Wk8aaxZLj+/edtHaorLyu4rENs
         Zzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CJ6dGR/wZEQZ8RJUTO/382NfJ/844DhADW78+/N46pU=;
        b=aSryN8DSlxXJ8aRdUw2ObvcoW8T6s3GeDN0Wxkia3PYVHayEg+y2mRb33Q5moLFUSj
         Gg0dH7Pj5ILZqo1OnCafepkWAtlu6/2c2zNOcMbpux4fzUW4s5dca1qXsfZkT1JQI7E4
         lN4k2BwxLpIrm57NNAc/tW345DYf/G/FVRNaQ/rRK2OH8CR2gBAstclnPdDp6qkQkIvJ
         6gWOb0FWSjAjqII4G7zi3vPa9beuvZRhVhbCBoI46sPfcybh958iHbEDss97K8ElEgUv
         DNtTudezqJ9JrkjGtdGn6ugdg5CBhKqKvo7weNmjGqmHnnPjANSWarp9ehOd97c794Q4
         4G9g==
X-Gm-Message-State: AMke39mgfi218zbiExre+ddepu5LdlxxKHN1UT6IcmEPvAgf+LAvxbyxQoBuW9kngeFo2w==
X-Received: by 10.99.213.81 with SMTP id v17mr47431291pgi.130.1487852635786;
        Thu, 23 Feb 2017 04:23:55 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id u24sm9667668pfi.25.2017.02.23.04.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Feb 2017 04:23:54 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 23 Feb 2017 19:23:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        sschuberth@gmail.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 0/1] Conditional config include
Date:   Thu, 23 Feb 2017 19:23:45 +0700
Message-Id: <20170223122346.12222-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's try this again. v4 and before can be found in the original
thread [1]. The remaining issues of v4 were

On Fri, Aug 19, 2016 at 8:54 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Aug 13, 2016 at 03:40:59PM +0700, Duy Nguyen wrote:
>
>> Ping..
>
> There was some discussion after v4. I think the open issues are:
>
>   - the commit message is rather terse (it should describe motivation,
>     and can refer to the docs for the "how")

Fixed

>
>   - the syntax might be more clear as:
>
>        [include-if "gitdir:..."]
>
>     or
>
>        [include "gitdir-is:..."]

I'll go with include-if. It feels a bit awkward to add -is to every
new type of condition.

>   - there is an open question of whether we would like to go this route,
>     maintaining backwards compatibility syntactically (and thus having
>     these includes quietly skipped in older versions), or introduce a
>     breaking syntax that could be more convenient, like:
>
>       [if-gitdir(...):section]
>       conditional-but-no-include-necessary = true
>
>     I do not have a strong opinion myself, though I had written the
>     original [include] assuming syntactic compatibility, and I think it
>     has worked out (e.g., you can manipulate include.path via "git
>     config" just as you would any other key).

I'll go with the what we have done, at least it's proven not provoking
too bad effects. So no breaking syntax.

[1] http://public-inbox.org/git/20160714153311.2166-1-pclouds@gmail.com/

Nguyễn Thái Ngọc Duy (1):
  config: add conditional include

 Documentation/config.txt  |  54 +++++++++++++++++++++++++
 config.c                  | 100 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t1305-config-include.sh |  56 ++++++++++++++++++++++++++
 3 files changed, 210 insertions(+)

-- 
2.11.0.157.gd943d85

