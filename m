Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9717202DD
	for <e@80x24.org>; Wed, 25 Oct 2017 16:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbdJYQdB (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 12:33:01 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:50012 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751513AbdJYQdA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 12:33:00 -0400
Received: by mail-io0-f196.google.com with SMTP id n137so1639758iod.6
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 09:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+8jbSCafbDWZtYTgLyjQclke+4ddOtuwurIoBJZteJg=;
        b=lUzriSbAe9cDybmWG/GhdS8C43xvJRlEF6+EVncfDRuoet+3/WzKpqKIxGDoyFKiww
         zitQJ9VKugrR8b4rVDg827lg/auU0649YyyrWFBXb7wI48lGGjEdSBitIygaSbQodD8s
         XGbGrGMaZRu7ajsGroSTkoKYltp1QlnO1g5NQnk1El1rmlRjhrLnW5LYytiUeMyMlSEP
         Ejkt4/PUyyYIuSf7F+m50axFyWyh4bZiG+svAzlU7o70YHOZ0dMGcZojUjuxNFDniadI
         P08zsyCBUALTKilcQz6Oz3HG1DdYHEwq6SBTzWcwVtLUdZtcV/sG8An0FkHpUkQecriM
         EA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+8jbSCafbDWZtYTgLyjQclke+4ddOtuwurIoBJZteJg=;
        b=EvfG4+58uWhSmmChDXv79I+8CvKU/YKsl62Huftk33hNYjkJXicg2TfEeoi2fwYEq0
         eVUGxTXC28Gk7sEEUvaCnRqIANpcZ7UFEymJD498rEI3GW3jZ1QqXz3RZ819mmEpN3lV
         OFosmP+XJhv+HXF0rUbf2aAMwLz2OKVKdaljCDDewNrIbNd1sU6b+PDinCtWXQawb7hE
         t0WNbxzfVJ12Z2Ft1Tjz0i2SCqQOa1xo/OH8wpwJsxaGGX0HJNoAyP30AJ60O2N07/SX
         wGJ9fyBIdNzZ+mXo2PDZFgIRMCxKyIoCgMrbDsVfX3SQSEMx15T9EfeTVz3b9JMdtssk
         kYUw==
X-Gm-Message-State: AMCzsaVO7SCx03jlRZI6hZ9ZOk5fahRKyRldMrE3I4XO3yIHj9vDFxkQ
        TbT0G2vEU9IV+qP3PHaXi0QcJv37
X-Google-Smtp-Source: ABhQp+Qlujk1+3nJaZNLi6yqiDN/Jg9gkLCrIodq4ypwZxgDLQNOH8LwAHszzBJdWulS9bnAoQAT2A==
X-Received: by 10.107.112.11 with SMTP id l11mr24720384ioc.214.1508949179797;
        Wed, 25 Oct 2017 09:32:59 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id p190sm1475804itp.36.2017.10.25.09.32.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Oct 2017 09:32:59 -0700 (PDT)
Date:   Wed, 25 Oct 2017 09:32:43 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Bryan Turner <bturner@atlassian.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, William Yan <wyan@google.com>
Subject: Re: [PATCH 3/5] ssh: 'auto' variant to select between 'ssh' and
 'simple'
Message-ID: <20171025163243.xmm7szrkwgblpgcc@aiede.mtv.corp.google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-11-bmwill@google.com>
 <20171003214206.GY19555@aiede.mtv.corp.google.com>
 <20171016171812.GA4487@google.com>
 <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
 <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1710251437090.6482@virtualbox>
 <CAGZ79kYTYg09A7UbhvyiT0QmRQG5ZJV6v1iaQBNCZY8RTj300A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYTYg09A7UbhvyiT0QmRQG5ZJV6v1iaQBNCZY8RTj300A@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:
> On Wed, Oct 25, 2017 at 5:51 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:

>> This breaks on Windows. And it is not immediately obvious how so, so let
>> me explain:
[nice explanation snipped]
>> As a consequence, the test fails. Could you please squash in this, to fix
>> the test on Windows?
>
> This explanation is in detail and would even make a good commit message
> for a follow up commit. (Squashing just that line would loose the explanation
> as I suspect the original commit will not dedicate so much text to
> this single line)

I have other changes to make when rerolling anyway (from Junio's
review), so no need for a followup patch.  Will fix this in the
reroll today.

Thanks for catching and diagnosing this, Dscho!

Jonathan
