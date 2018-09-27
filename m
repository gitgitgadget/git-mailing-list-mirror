Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 872181F453
	for <e@80x24.org>; Thu, 27 Sep 2018 18:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbeI1Atx (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 20:49:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43651 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeI1Atx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 20:49:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id q19-v6so2549220pgn.10
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 11:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JBw7+BC2sjNIS6t5FD4N/yoELHlCbwTqccUn2I5/pcs=;
        b=egqzmsG1M+ORQ0mazc+lO7E2bBvBSD9m7NI+An3fyadF/ChxiwNKUQIN2kuOWSLBxF
         dgN3UcWFRl/4d4+XDQOepg2n2kc+7VmD1kkupRGZ5EF2JjJq2yzJEjIHFNkCk+SbARx8
         oJDFQOijBpkf5z7R/BJmNkYQ+3tHBU89AV4qdQQBoYqYIYpV+eYsjwsZvPSyyPnT1/30
         FYoxFmLOxQYK9SKrRIdBXK+CBw2f7fun78w/7r/FhgcFd0oBNRBPYAxrGWQK9cFbq6JH
         NWzr49GGDSRidtugobW3szRcbFatm9CTG4XVHWaESDnPRF72bTQyeSukC70MUTY3CFco
         9PXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JBw7+BC2sjNIS6t5FD4N/yoELHlCbwTqccUn2I5/pcs=;
        b=fLaO7FqI5qiYGYmNX75YcM/Xe0gjJXYo1UPLWfWCJqURjzAX/d9Yc9MXIDdWAnvi6i
         a5CV0wc90mqafclAAa1ET2TKZno0W7ig5V1EqAEa3FuIsUgHzJ0vgwxpqMVLoS+2NsIz
         l1UQ5nw/69OnEyxUM5OPLrp4UuM52KIbdUn6Cvnsox6QXJQqoRTm8DyRoA4JzkdU9Hsc
         6FqE8BNxyYNbJyg8bhX7gZiKi7hbi4gQkHI89Q/nDuCaD0EFK9Yrsnie2oo+JT9f6TTD
         BHvkDzWCjI/pY474P2hr/Da673XPisMECR31aTl0GzvxJMClkviN1llVI4oRMp9RZZoF
         kHEQ==
X-Gm-Message-State: ABuFfogTooxupC07w/cMDgsTfotTI2RHkIFZrhu7+KK+b3ZyjiAvPdJT
        WP3t9H1GBMv1RCIi3HtzSCE=
X-Google-Smtp-Source: ACcGV60D36U04ienx9M+iTgglgfJ8LLXSEi8Pv2NWirWe4cOEIrS2+8iGi94Ir6HvZux35Z2E/N34A==
X-Received: by 2002:a63:e54d:: with SMTP id z13-v6mr11518648pgj.169.1538073019394;
        Thu, 27 Sep 2018 11:30:19 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 3-v6sm4966962pfq.10.2018.09.27.11.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 11:30:18 -0700 (PDT)
Date:   Thu, 27 Sep 2018 11:30:17 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Josh Steadmon <steadmon@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Add proto v2 archive command with HTTP support
Message-ID: <20180927183017.GD112066@aiede.svl.corp.google.com>
References: <20180912053519.31085-1-steadmon@google.com>
 <20180927012455.234876-1-steadmon@google.com>
 <CAGZ79kaBvHwUUf0rXeAwBY-M+Oi9JjsQnLs4v3FAvx4a9ZRbSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaBvHwUUf0rXeAwBY-M+Oi9JjsQnLs4v3FAvx4a9ZRbSA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:
> On Wed, Sep 26, 2018 at 6:25 PM Josh Steadmon <steadmon@google.com> wrote:

>> I've been discussing workarounds for this with Jonathan Nieder, but
>> please let me know if you have any suggestions for v3 of this series.
>
> Care to open the discussion to the list? What are the different
> approaches, what are the pros/cons?

Do you mean sending video of chatting in the office?

Josh and I discussed that

 1. Clients sending version=2 when they do not, in fact, speak protocol
    v2 for a service is a (serious) bug.  (Separately from this
    series) we should fix it.

 2. That bug is already in the wild, alas.  Fortunately the semantics of
    GIT_PROTOCOL as a list of key/value pairs is well defined.  So we
    have choices of (a) bump version to version=3 (b) pass another
    value 'version=2:yesreallyversion=2' (c) etc.

 3. This is likely to affect push, too.

Thanks and hope that helps,
Jonathan
