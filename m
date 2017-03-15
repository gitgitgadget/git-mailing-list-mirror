Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD39920951
	for <e@80x24.org>; Wed, 15 Mar 2017 00:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbdCOAmB (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 20:42:01 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36477 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbdCOAmA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 20:42:00 -0400
Received: by mail-pg0-f42.google.com with SMTP id g2so1196859pge.3
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 17:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fXdsE4374cSxgJcgXxmrWMU1IAPv7NZuM00my2s/lAo=;
        b=eH+HyveW2jCJg83bHftzsNa++dnUyRLNtC7aj1L4HBZJ8wajbeplXqI4Z8T/Cpazxl
         6zOL0L3Hi8/1ZufkBIgUcYKo7ZKH+FOXQFIhE8vNSUooxZ+6v0fF6lEzmD+RVFUAX7WQ
         Ozh3dRpt/Xvt5ERIUICbgpUR38VqqVQoyDEF0A2/UuPZTrJINppoc0/rIOBcbg4+AIAt
         PYNF1nBM7caAt+cE314K5cDk39cCFUde/Di8nuo9HlNPJMPK1q6aB94q9DygeP71HmJ5
         num6fp5EXFL8pnpgfccsC7gkbtNkyiBEHmd0cEmJeei9AtHs3jHSdO61NPN5phJR42H0
         U5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fXdsE4374cSxgJcgXxmrWMU1IAPv7NZuM00my2s/lAo=;
        b=pgYgx+dZamZlTJy1CWuKT/LyObZ7mHeNOwv3jmChNCDlGaMnIEXSTEd33IrdyNiRDV
         13AFi2/FEkCKg6l6rajDBn5XBrH26NubAH8M50XpsryU2g+V/xk6yWne6GnncvyN4xxb
         NMHTgbjv3+28FQk49qwatZPO2eDj+JRxmDnOJlC1ySzx8t6DagtkjECh6cECrKH7ItGM
         uqjhA7+uwpQiKAvHNKGL2hGWGbOLt0HieNhiV6j3xLD+ZuiHv2oIiPILSY7A0d7P6lrw
         LEHzCGDX++MbO/9c7FdjH0AfJ3C5BF7/0EzCpw9gTck2XHyHoBQeiXJNJCIzfbJ7H3lh
         EQKg==
X-Gm-Message-State: AFeK/H12FIIjsZZTYw4opJYnKKEqA6XDzD4yD+M96r/DTgdn8yae1H5ntlKtE28FgKdIC9nu
X-Received: by 10.98.2.21 with SMTP id 21mr570362pfc.93.1489538518748;
        Tue, 14 Mar 2017 17:41:58 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:491b:baa8:63f0:3cf1])
        by smtp.gmail.com with ESMTPSA id d199sm231031pfd.107.2017.03.14.17.41.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 17:41:57 -0700 (PDT)
Date:   Tue, 14 Mar 2017 17:41:56 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCHv9 00/19] Checkout aware of Submodules!
Message-ID: <20170315004156.GI168037@google.com>
References: <20170309221543.15897-1-sbeller@google.com>
 <20170314214642.7701-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170314214642.7701-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/14, Stefan Beller wrote:
> previous work:
> https://public-inbox.org/git/20170309221543.15897-1-sbeller@google.com/
> 
> v9:
>  * inderdiff to current origin/sb/checkout-recurse-submodules below
>  * fixed a '\' that was violating the style guide.
>  * reordered the patches, such that
>    -> the first two patches are Valerys series and could go on its own as
>       a cleanup  
>    -> added a new patch "submodule.c: get_super_prefix_or_empty" to
>       have cleaner code.
>  * split up the error conditions in the test lib for readability

Changes looks sensible to me.

-- 
Brandon Williams
