Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B760A211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 12:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbeLEMUk (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 07:20:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43318 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbeLEMUk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 07:20:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so19437628wrs.10
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 04:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+dgJxzMP0f0hT/iMWC2pvRyecG8O5J2rtyfIiZeCLU8=;
        b=eyA45KNtogFVncw4S7bO3fOndNuEqKp1YMU5pKcFiyJDUEQAOFdmoThVIlPogttUwh
         if0D+k9zQh+68Ihdz25+d6V7PN4tWvdQe9o6lliOV7xzV6Suto3N89mFATRhZ8ppVvDs
         CM3FA0WOOcCMg1SRtb3g5mgkUaTZHyzLVQ6sBJ8KZbJ5fMMf0dXp4AGCkzKaHooLoLMP
         8gxH0fowZh7ngSUuZxf6fiE49/ipgUOytSX4miTdAnsGw12kEOS2mn6wzBbnf1cfCLsy
         G7wlHqP+5ihl+9tT0lbsPGznLVherAPW/81dQ0eU8w+RsWjEE26R0zISWB8OsdCD8VX3
         AIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+dgJxzMP0f0hT/iMWC2pvRyecG8O5J2rtyfIiZeCLU8=;
        b=iPgNRxwGjTMmeaqneKeoDehpNw93CGQsn9pegYehXXZhVhfBv6Xm23wOIDhqs0PQAv
         m7j5+3Jr0gkpuz4sYXXkdy+S1rE16S7vevW11IDb3kCR10G+7rJrp6YTg3IB6ZVv6vkI
         X/GBrvJhQd2UFs8NpC3oQlIQPyQennq3tCQpZfGxecUJEP/tdmUdlbOVBn5mPQXIP8zH
         Ma5eW8U0j9Om+BSFaIj9W28+fHQpVwDVlo0/DAFN3lT09zYUsVYbTGTxKDyknH6YsWzz
         waEpePy1M6XcRW5FJAputQM0QTLdzm+lsVej7/PdxFRlW36V5+xz/mSiARbrBGC4WNH6
         DPNA==
X-Gm-Message-State: AA+aEWZHFv67aQx0u0Zr5GpQroeaSeBBfDqh5LY2F0J5A4Sko1pl8N80
        Ybw8RjLPFyg8PRDzntCiBbK1rT5e
X-Google-Smtp-Source: AFSGD/VveDwh6z2x07HHKUTDpnQ2o7bmKUCA2LReTbAQxsnbiuWUxEiMNY+dUSKPJBDqbjKMoDzvpQ==
X-Received: by 2002:adf:80cf:: with SMTP id 73mr21460836wrl.57.1544012438644;
        Wed, 05 Dec 2018 04:20:38 -0800 (PST)
Received: from szeder.dev (x4dbd715c.dyn.telefonica.de. [77.189.113.92])
        by smtp.gmail.com with ESMTPSA id o17sm10863370wmg.35.2018.12.05.04.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 04:20:38 -0800 (PST)
Date:   Wed, 5 Dec 2018 13:20:35 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 2/3] test-lib-functions: introduce the 'test_set_port'
 helper function
Message-ID: <20181205122035.GL30222@szeder.dev>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181204163457.15717-3-szeder.dev@gmail.com>
 <20181205051709.GD12284@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181205051709.GD12284@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 05, 2018 at 12:17:09AM -0500, Jeff King wrote:
> On Tue, Dec 04, 2018 at 05:34:56PM +0100, SZEDER Gábor wrote:
> 
> > Several test scripts run daemons like 'git-daemon' or Apache, and
> > communicate with them through TCP sockets.  To have unique ports where
> > these daemons are accessible, the ports are usually the number of the
> > corresponding test scripts, unless the user overrides them via
> > environment variables, and thus all those tests and test libs contain
> > more or less the same bit of one-liner boilerplate code to find out
> > the port.  The last patch in this series will make this a bit more
> > complicated.
> > 
> > Factor out finding the port for a daemon into the common helper
> > function 'test_set_port' to avoid repeating ourselves.
> 
> OK. Looks like this should keep the same port numbers for all of the
> existing tests, which I think is good.

Not for all existing tests, though: t0410 and the 'git p4' tests do
get different ports.


Hrm, speaking of affecting 'git p4' tests...  I should have put Luke
on Cc, so doing it now.

