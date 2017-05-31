Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4FB01FD09
	for <e@80x24.org>; Wed, 31 May 2017 23:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751024AbdEaXB0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 19:01:26 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33057 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbdEaXBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 19:01:25 -0400
Received: by mail-pf0-f172.google.com with SMTP id e193so20026310pfh.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 16:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7arfDs9zpyPP3qDcBSLTwBasq+r+BGCsr72+3STfh9U=;
        b=m8XFfBe/4KwHPSnv3vnalVIEHn29j9Nq/AP9e00/23vr4qHfKRY6zQzdg1EQQ35sSX
         mRfIOSVmApnFBOaR1GH/yNA7o1HBOq8YqrRFQiyzUpiwGHNeeSiko7bTAeyNrmjCsI5N
         ZR/fxj7YrGah0tWPA04jFeM/ZGPW3ci/VjFZp5kTVN9cu1knAiS59XpOzd01a0Cbt30N
         1XDV4zirsd8a96GzH2uC3GuZF/xrglse1oy0eDJ7Sr/Fn/+X951azuWUCx8rX2rN7QAx
         zNnG/5AjSK9xrGUii3TDLXtXD3a8P1D26qWox6JG2VIJit7O7GZhqLe4ZyPt5jfUOfPM
         2Kwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7arfDs9zpyPP3qDcBSLTwBasq+r+BGCsr72+3STfh9U=;
        b=UYmADRnnEbpSTrJ144xkcSWXXY0/V5r+t5PWQyHBsrEx2eN9onf+Ey3uKyTAYS+VWc
         L0zRSybaQjL5pv91kW4nRlsuUeVx/HBCPphxP4dBYhlI9crhFHuYqXF/HJTbYDZWqWCF
         EP5gH4rkKjBI5fFQynAltDk/nULDJ0DRAJLSXRog2PN4S6tAG1feftgczEZVB65ZauYn
         5JQXAKTSY4U3bgpw3J9BV9vvB7CIDrijYodYLbDNUr7pBHRv+mDk1Cvexfk/hPR44F7Q
         rxRNMUosLt/1zpdvyxPTIpPl1+q5f0AX5fovBThT7kmWo/mhYV7mZv4sA5eSmCgoF8OC
         iOzA==
X-Gm-Message-State: AODbwcBjVCF9eb+RF2ysnxeqh/2eaTJZkROnjENEZMrzsDCNhK2hn+Ux
        J7yFxKjfHixhuM2n
X-Received: by 10.99.1.88 with SMTP id 85mr36397979pgb.110.1496271684814;
        Wed, 31 May 2017 16:01:24 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:dcdb:b4e5:f1c4:8595])
        by smtp.gmail.com with ESMTPSA id y2sm32115788pfa.65.2017.05.31.16.01.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 16:01:23 -0700 (PDT)
Date:   Wed, 31 May 2017 16:01:22 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/31] repository object
Message-ID: <20170531230122.GA43421@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <CAGZ79kYMs6XS8kcoWVZDes7W_J1B86dYm-8rhkJPzUmoqjyTng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYMs6XS8kcoWVZDes7W_J1B86dYm-8rhkJPzUmoqjyTng@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/31, Stefan Beller wrote:
> On Wed, May 31, 2017 at 2:43 PM, Brandon Williams <bmwill@google.com> wrote:
> > Given the vast interest expressed when I sent out my RFC series I decided it
> > would be worth it to invest more time to making a repository object a reality.
> >
> > This series is an extension of the last series I sent out (in that ls-files is
> > converted to working on submodules in-process using repository objects instead
> > of spawning a child process to do the work).  The big difference from the RFC
> > series is that I went through and did the work to migrate key repository state
> > from global variables in 'environment.c' to being stored in a repository object
> > itself.  I migrated the bits of state that seemed reasonable for this series,
> > there is still a lot of global state which could be migrated in the future.
> >
> > I do think that we need to be slightly cautious about moving global state into
> > the repository object though, I don't want 'struct repo' to simply become a
> > kitchen sink where everything gets dumped.  But this is just a warning for the
> > future.
> 
> Or in other words:
> You want to have another struct e.g. 'the_command_line_arguments',
> which would carry the verbosity/color options for example as they are
> not related to a repo object, but to the current command being run?

Yes exactly.  Library code that needs to operate on a repository would
then be able to take arguments like:

  some_library_function(struct repo *repo, struct lib_opts *ops)

Much like how the grep machinery takes a grep_opts struct.

> 
> > Since this is a v1 I'm fairly certain that it still has a lot of rough edges
> > (like I think I need to write better commit messages, and we should probably
> > have more comments documenting object fields/contract) but I want to get the
> > review process started sooner rather than later since I'm sure people will have
> > opinions (e.g. should it be called 'struct repo' or 'struct repository'?!).
> 
> IMHO this is the most obvious, but bikesheddable part of the series. ;)

I know, that's why I mentioned it ;)

> Keep it short as everyone knows what a 'repo' is.

-- 
Brandon Williams
