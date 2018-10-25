Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC7131F453
	for <e@80x24.org>; Thu, 25 Oct 2018 09:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbeJYRqC (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 13:46:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34054 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeJYRqC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 13:46:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id w19-v6so7764062eds.1
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 02:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0OZg0RgL4cSee3JgppbG6qLkFWpnuOj2SeiWP97XxTs=;
        b=Yb5msNq8bdBM5yn6v5CfRwqH5mq47Vmk5KoYggHTjOk+gYzwka3zspKinXG2+sJbLz
         qLX2l6ZJD96pDfgAPTCLDFV6jJ6sQr5Qmjfy71jC+rCn3trQc6KSK16Bd4ECb7/bTJBT
         PGRPTLEunrCi0frTdhovV5hPK85EtZXwdxaXyZf5OAG2l387BSjJoKfjbZcWKisEvRM6
         ns1P5Mcfz25/2SyvuBCNQBZHC40qjWH9gWqbWonuik6JjlIGfMgZ933l7kP5XAZU+fHL
         D9DWiA+2EMeDJr/MG8VU1j+4Ig6YFEATeTH4VA7annRhcV0Dp9qfp1n04R6a8Afpv3AQ
         Mmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0OZg0RgL4cSee3JgppbG6qLkFWpnuOj2SeiWP97XxTs=;
        b=bdyuz2aEHoxBxLUmfUOvYpzz9JwW2JPAxzl6tgmY4zRGQkNnUtHsApTreGUgdu+lJl
         sekDQ7FLE7cR7etNhpmkdE4Cnc1KQdZastBKHI803dSaVS+2A8NmY5tvPNkcH5t4V0qq
         gjYRiK79wjnArVfHXI/at6017wzmrIgPE7ltbZDsd9cvPCkyLUniwluBe/gFwymPH88j
         swJ1WEkzJ7P3Cj7vMUxWFbZ4ka2kIXA4UzXJK0HqvqOoPpwz6AjOU2OI+bPCa/cqG9gA
         yYPIO0LFZeLekdojzXl+Fpj3n9oH7iAHEtafWpJrdH3OttSzKQLuKqt69Gju/4ASozO6
         ZCIg==
X-Gm-Message-State: AGRZ1gJPhO9QVnju3H4M1l24NXGoZcEZrmR06GaJOWRB/xAnW4sPKkZE
        kH54Sc+JQyQDq73LjLP/7WQVKpda
X-Google-Smtp-Source: AJdET5fUNPX4OFaK7xMExEF4bGem39eWnODqKBAG3djzPaThfS8mpIT5ONA5S2Ur/NwWerrk50ZINw==
X-Received: by 2002:a50:b877:: with SMTP id k52-v6mr903718ede.37.1540458849463;
        Thu, 25 Oct 2018 02:14:09 -0700 (PDT)
Received: from szeder.dev (x4db0730d.dyn.telefonica.de. [77.176.115.13])
        by smtp.gmail.com with ESMTPSA id i38-v6sm3831717ede.83.2018.10.25.02.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 02:14:08 -0700 (PDT)
Date:   Thu, 25 Oct 2018 11:14:06 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        jonathantanmy@google.com
Subject: Re: [PATCH 18/19] submodule: use submodule repos for object lookup
Message-ID: <20181025091406.GK30222@szeder.dev>
References: <20181016233550.251311-1-sbeller@google.com>
 <20181016233550.251311-19-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181016233550.251311-19-sbeller@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 16, 2018 at 04:35:49PM -0700, Stefan Beller wrote:
> This converts the 'show_submodule_header' function to use
> the repository API properly, such that the submodule objects
> are not added to the main object store.

This patch breaks the test suite with 'GIT_TEST_COMMIT_GRAPH=1', in
particular 't4041-diff-submodule-option.sh' fails with:

  expecting success:
          git diff-index -p --submodule=log HEAD >actual &&
          cat >expected <<-EOF &&
          Submodule sm1 $head2..$head3 (rewind):
            < Add foo3 ($added foo3)
            < Add foo2 ($added foo2)
          EOF
          test_cmp expected actual
  
  + git diff-index -p --submodule=log HEAD
  + cat
  + test_cmp expected actual
  + diff -u expected actual
  --- expected    2018-10-25 09:10:00.541610016 +0000
  +++ actual      2018-10-25 09:10:00.537609885 +0000
  @@ -1,3 +1,5 @@
  -Submodule sm1 30b9670..dafb207 (rewind):
  +Submodule sm1 30b9670...dafb207:
     < Add foo3 (hinzugefügt foo3)
     < Add foo2 (hinzugefügt foo2)
  +  > Add foo1 (hinzugefügt foo1)
  +  < Add foo1 (hinzugefügt foo1)
  error: last command exited with $?=1
  not ok 9 - modified submodule(backward)

and 't4060-diff-submodule-option-diff-format.sh' fails with:

  expecting success:
          git diff-index -p --submodule=diff HEAD >actual &&
          cat >expected <<-EOF &&
          Submodule sm1 $head2..$head3 (rewind):
          diff --git a/sm1/foo2 b/sm1/foo2
          deleted file mode 100644
          index 54b060e..0000000
          --- a/sm1/foo2
          +++ /dev/null
          @@ -1 +0,0 @@
          -foo2
          diff --git a/sm1/foo3 b/sm1/foo3
          deleted file mode 100644
          index c1ec6c6..0000000
          --- a/sm1/foo3
          +++ /dev/null
          @@ -1 +0,0 @@
          -foo3
          EOF
          test_cmp expected actual
  
  + git diff-index -p --submodule=diff HEAD
  + cat
  + test_cmp expected actual
  + diff -u expected actual
  --- expected    2018-10-25 09:10:38.854868800 +0000
  +++ actual      2018-10-25 09:10:38.854868800 +0000
  @@ -1,4 +1,4 @@
  -Submodule sm1 30b9670..dafb207 (rewind):
  +Submodule sm1 30b9670...dafb207:
   diff --git a/sm1/foo2 b/sm1/foo2
   deleted file mode 100644
   index 54b060e..0000000
  error: last command exited with $?=1
  not ok 10 - modified submodule(backward)


