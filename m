Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D8851FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 20:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbdLHUI4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 15:08:56 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44010 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752350AbdLHUIx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 15:08:53 -0500
Received: by mail-pg0-f66.google.com with SMTP id b18so7540954pgv.10
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 12:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SGfnHMfUL0tv9O+mZy57WWMf20XwKQory6X8nbv4YRs=;
        b=q82Q0jUSLd9xlRt3cAWGVI9lt6CzhvbiAPFJV7OTp2Mj8RKnpUfSs1xf1GyaZHuSnB
         hd1amYoxNoJKntHyyJFb8Qialt1TfMIM54tXVJJv5FUjCoemL0j7U9qYZ6z+2Jp5FglV
         42f1ktwY3NYHCq26udNIHrs2Fi2xN3L9VHkVWCEaJPGTBr1xVs7TomkNxql4wlRnBgg7
         dflSrKAXGV5NeOQuvkjFD91p0+3RE9TPg4y/YkEQPkVM785Vt7NBsmPLHMZXwg4kaMim
         Nylb1qogMACYO8YO6mn4V+BN7BDub0IcAQdMiSRfykB69eYgEcSBcOijiZ+MLi4zJ2ah
         WdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SGfnHMfUL0tv9O+mZy57WWMf20XwKQory6X8nbv4YRs=;
        b=rxT02MCiMxG7vt0jT+Yf5/Wa1o3RaTjoUAWlfe4kNmZ3PmfY0DRdscXL8CiR6hSdFS
         sDpv7u+BCIqC3vtyg29+5Deb/4Py6WcSfZMPo+50ulJwUtbinQYw4gCtSf92itt7FNmA
         F4BmFB7PJq9eFOZ+tLJyi8SN/TUepuWoiI/kCdu0A61YG6QRyHzd2NE3xcq6mm1siJqy
         I5wMjSr0dtTM5LRnhnZrfbT0RDl4PkzKMDLRIONmcISAQ4nT3plBPwrU18E+/T9lVK4P
         SWlPo9maKVcLYVrrxJ432fpQZGD8osMEkoc8zz5XCEGwNJSClfSeBRNERlDWtz9401Qa
         +nuQ==
X-Gm-Message-State: AJaThX5QUpTDqUXKxgFpxjD9MjTpRk//5FvXJJ0lSEG439hgMyO/vXet
        wuTiCQUuTUo8YhOBQNQdvd05UA==
X-Google-Smtp-Source: AGs4zMaEjcqZZEYk6UOq/T2J0e1f6ECWdv2mKmljfEWY1zk+fHN87a2/siUJ9U6whNo2EGkZnv1fYQ==
X-Received: by 10.101.96.213 with SMTP id r21mr30200225pgv.395.1512763732612;
        Fri, 08 Dec 2017 12:08:52 -0800 (PST)
Received: from google.com ([2620:0:100e:422:e4f1:b67a:70f2:4fbe])
        by smtp.gmail.com with ESMTPSA id h69sm15390404pfe.107.2017.12.08.12.08.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 08 Dec 2017 12:08:51 -0800 (PST)
Date:   Fri, 8 Dec 2017 12:08:50 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [WIP 03/15] pkt-line: add delim packet support
Message-ID: <20171208200850.GA140529@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <20171204235823.63299-1-bmwill@google.com>
 <20171204235823.63299-4-bmwill@google.com>
 <CAGZ79kYw3y3grehEbFeoA2r7pEra079M7zVpcVwxcoK5BPN1Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYw3y3grehEbFeoA2r7pEra079M7zVpcVwxcoK5BPN1Dw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07, Stefan Beller wrote:
> On Mon, Dec 4, 2017 at 3:58 PM, Brandon Williams <bmwill@google.com> wrote:
> > One of the design goals of protocol-v2 is to improve the semantics of
> > flush packets.  Currently in protocol-v1, flush packets are used both to
> > indicate a break in a list of packet lines as well as an indication that
> > one side has finished speaking.  This makes it particularly difficult
> > to implement proxies as a proxy would need to completely understand git
> > protocol instead of simply looking for a flush packet.
> >
> > To do this, introduce the special deliminator packet '0001'.  A delim
> > packet can then be used as a deliminator between lists of packet lines
> > while flush packets can be reserved to indicate the end of a response.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> 
> I presume the update for Documentation/technical/* comes at a later patch in the
> series, clarifying the exact semantic difference between the packet types?

Yeah, currently there isn't a use for the delim packet but there will be
one when v2 is introduced.

-- 
Brandon Williams
