Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86DE21F404
	for <e@80x24.org>; Fri, 14 Sep 2018 20:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeIOB76 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 21:59:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45117 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeIOB76 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 21:59:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id x26-v6so4903759pge.12
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 13:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QEqLhOsqjJ0SHh7JCp9+1zmBfeDv2/HkGO/QfIEZT2w=;
        b=gvkVy6UnVl7jrMvNsRASZLCv2QqizD52ILq1/klmMyFcnnsnwzFvIVKW5RXGbYJSLp
         VT/fR9LJIP2EC4bkzwHaJoTBGIekHiIV6OrDS0xdTFJBH2yqYp49qg2JTIdPAucnz6SE
         eLVeW9ojXxR2RoiR7x3BRZCG+Zgx7HAHpR1HUd82RbHkih9ws29EVtOujEmC3WHIpv+c
         MY/qzwp+2e0TjQaua5IQrtbziFBItlAUwXoTSnDx7MVreTMefO7ei1lA/fUSJfOYB0yx
         2df8UbHSKPr2URPMAwbROUuHRVRmzrIicrljFCs0P5LRGu8cFu62PUrcLcJ1TnuAmW8R
         WIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QEqLhOsqjJ0SHh7JCp9+1zmBfeDv2/HkGO/QfIEZT2w=;
        b=lbLf8v/iVRb0SrheVX7hQC9i0UYVFNKVDrKdYm9kPwoxBssiRkJOhWwwG5O/TdHr5e
         CJea1SMwT3jTYIOcTkXWJ72kzPATIPSpt+iDVa6ho17jif11OtSpuWLJenC/YdVY+fC3
         s2glioVGqaozUivUQxk1a5m542Z685+/QPpLd8zK+KduvSnYqp9u8PyryYS7nPM7kY3J
         7pIl/30qot2TYYRUr1fer0R1T1SsmRGgf+4fCWb380StBhgodphnvBlmSVQMRzkB8uUd
         9mKAIqLO8w/N+y+UplXcw3IH4rE1yvSIPk1EvNVUbafc7oYCn2ukA3Q2nMeQfI6ruHgQ
         9W3w==
X-Gm-Message-State: APzg51AOf18ZRQ4xXML6a0TXLM8Z2VDfa/dRwT7Rbf3v9/bZ05QZbnxk
        0Yf7lMRh+9bA1I4gD+zBp7Y=
X-Google-Smtp-Source: ANB0Vda7b6Hv+IQk9Gaf0DQRsDWRba+fuDnR6PYuo2x6sCarANHu2w7Vda+pa7/nF+L+VrVVY/hIIg==
X-Received: by 2002:a63:25c4:: with SMTP id l187-v6mr13430004pgl.29.1536957831244;
        Fri, 14 Sep 2018 13:43:51 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id x23-v6sm10395703pge.61.2018.09.14.13.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 13:43:50 -0700 (PDT)
Date:   Fri, 14 Sep 2018 13:43:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     "peartben@gmail.com" <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "t.gummerer@gmail.com" <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 1/5] correct typo/spelling error in t/README
Message-ID: <20180914204348.GB133420@aiede.svl.corp.google.com>
References: <80988727-085f-cdd9-e5bb-a90a55e97024@gmail.com>
 <20180914201340.37400-1-benpeart@microsoft.com>
 <20180914201340.37400-2-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914201340.37400-2-benpeart@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ben Peart wrote:

> Subject: correct typo/spelling error in t/README

nit: what is the difference between a typo/spelling error and another
kind of spelling error?  Maybe this could be something like

	t/README: correct spelling of "uncommon"

which makes it crystal clear what the patch will do.

> Correct a spelling error in the documentation for GIT_TEST_OE_DELTA_SIZE

The commit message should consist of complete sentences, so this is
missing a period.  Alternatively, I think it would be fine to omit the
sentence altogether.

> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
> ---
>  t/README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This appears to be the only usage of uncomon in the code base.  Thanks
for fixing it.

With or without the commit message tweaks mentioned above,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
