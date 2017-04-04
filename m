Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9A0620964
	for <e@80x24.org>; Tue,  4 Apr 2017 23:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754900AbdDDXDI (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 19:03:08 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36062 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752997AbdDDXDH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 19:03:07 -0400
Received: by mail-pf0-f175.google.com with SMTP id o126so24942094pfb.3
        for <git@vger.kernel.org>; Tue, 04 Apr 2017 16:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OC3BOA8jTaBU21a26bpM7XkgGd5i2EL7LikWv380oHw=;
        b=sf7cx0LzJvYIpmsAYxaQ5ZSZbXpzjZHUXDsEE4CC7LdDw+4UtD+NRYm0PAkH4ELrgr
         4rbYnk4bJ/F1u8iYAXchGJWhai1xItpgb8vLzKoLYZxfWaLXuWcoSvdiidNye3i5QBeK
         rqqYqHDchsULKIXLMHlkGihpHD5z/Hq+h09c8bTn7XP2pVliNWk+sFmFKFbMjzS6mQmY
         +SSv07eeK9dfpT7gTy1Tavq3qR9X4KhWC0uhnU+GNwet5jfHsKZsf+YNnPgDvcaBgKmi
         +IPP881vWmsfGC3st8B3qTg5uaXRJhOyIyVi3tRmZH3YyMaKSIFs3JeBLBotnLYP2TFM
         wa8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OC3BOA8jTaBU21a26bpM7XkgGd5i2EL7LikWv380oHw=;
        b=RB5Wg4uNBH7u8mbu6rhhwQ9sOsSyd545x30EESLbLKSd2UHxmC6VxFw1RA9aEA2H8A
         n1uXLAICIGRqwrSR7F/WdztT+FDfiEEA+HahjI9bs5pJzkMast45OWXwFPYM9ENmNlUx
         EaDuePHn244Wm65/7oq8n6FtYCDZFQYPu+0C+WFwLnHz50lB3eDPhlz1TbVaqT3rtGTH
         jsHQsBiLX6lovT779Q9c0P9xMoxlwzlF7etMqO5rM1sE4RMAAYwn8dJlTsaRdrcjcTJz
         JpSJOCww07Q52jyQKZOpk8j7YOOS7COQ04LpJVB2Adum8BJBmFvpcZxdqJmf7lbu8Xzn
         zjVw==
X-Gm-Message-State: AFeK/H1XB6wdua4Bn3bbyU69z0uG9hypwGJKZA1X+GZ8kTMjSomiz48wK9+O3hidSDrnwNUO
X-Received: by 10.84.236.5 with SMTP id q5mr31967491plk.2.1491346986683;
        Tue, 04 Apr 2017 16:03:06 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:c58e:393:23cb:53be])
        by smtp.gmail.com with ESMTPSA id e76sm33546625pfk.75.2017.04.04.16.03.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 04 Apr 2017 16:03:05 -0700 (PDT)
Date:   Tue, 4 Apr 2017 16:03:04 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>, frank@gevaerts.be
Subject: Re: [RFC] dropping support for ancient versions of curl
Message-ID: <20170404230304.GE189807@google.com>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
 <CACBZZX78oKU5HuBEqb9qLy7--wcwhC_mW6x7Q+tB4suxohSCsQ@mail.gmail.com>
 <20170404083341.uajswm3qdzyvzxsp@sigill.intra.peff.net>
 <CACBZZX5D2cYf0-ob_Da0EsxRtZHfegezPtCGA10-sjfi0A+AoQ@mail.gmail.com>
 <alpine.DEB.2.20.1704041351350.4268@virtualbox>
 <CACBZZX6W+fbCg7xXKuM=iqnSYFENBYxYT1WJmoOvYYCBEkX=hQ@mail.gmail.com>
 <20170404165321.GC189807@google.com>
 <alpine.DEB.2.20.1704050043370.4268@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1704050043370.4268@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/05, Johannes Schindelin wrote:
> Hi Brandon,
> 
> On Tue, 4 Apr 2017, Brandon Williams wrote:
> 
> > I'm all for seeing a patch like this applied.  I agree that we can't
> > expect the world to be running the most up-to-date version of curl but
> > we should be able to select some "oldest" version we will support which
> > can be bumped up every couple of years.  
> > 
> > I mean, ensuring that you are running with an up-to-date version of curl
> > is really important when it comes to all of the security fixes that have
> > been made in each revision.
> 
> I am not in the business of dictating to others what software they have to
> run. I am in the business of maintaining Git for Windows. And part of that
> job is to drag along code that is maybe not the most elegant, but works.
> 
> The patch in question resolves such a wart. Sure, it would be a cleanup.
> Is it a huge maintenance burden to keep those few #ifdef's, though?
> Absolutely not.

haha, very true.  Of course I'm stating my opinion based on my limited
experience and work environment.

-- 
Brandon Williams
