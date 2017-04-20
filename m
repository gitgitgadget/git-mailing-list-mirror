Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F6AD1FA26
	for <e@80x24.org>; Thu, 20 Apr 2017 17:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971384AbdDTRC2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 13:02:28 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33159 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970143AbdDTRC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 13:02:26 -0400
Received: by mail-oi0-f49.google.com with SMTP id y11so26959327oie.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 10:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vYhyVCw8D6m3TXp8WTJa35pUUdLG7Dn/GA7xQBHTkt4=;
        b=lQBua0zwgqvo+PNMJjfSD4pIhJC8uPOVUIFQqqJohjmygPBmWKIZXffogdvNjJ3OZi
         pX8rUSVx/4Fz/9fTJ0My7uQGEbpMNQ5cWptEIdQ4NSfJ69LqPiBvgKNHDrneFM3sjfct
         yieXJX2mLaqpA5Ho0TMakOizYhm0Dg0P58JK37xro+4z/jlRsw+P6DGlV1ULD7zbtpfm
         /zECmjjCaEE/IWci1YVFe0Mn7KTL/hZSL3bOopG6L9amVz7PbrE5UXzpmrV61XSN0JEr
         2Ye96geWdtJKiAO2ToL7zjIVXac5NsSaIRELz1ylo8jkX93yxaLv9fz+6QG1bmuTjThy
         T4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vYhyVCw8D6m3TXp8WTJa35pUUdLG7Dn/GA7xQBHTkt4=;
        b=h42j25JkrDahbVdKyuxNTeNYbR6r+hcL4Wz0oHZ5OgYe3fn4NMzDQUzUi/BrTU/JLZ
         BIszP7zXQ6xHRYORaeZgJQcDr1zAf5TNWXBRdC3gBf/yZsjlFi5GwSHmGI3adgICttGH
         ecgIC074iEBS3PHlD9IMT2naMlZ/6rWBsFlVA2j6HEVvK9dGfK2B1woNxCatYCNBCtf5
         cTfDvR9qlyZyrV1MTWheDk+cUiv0ZH9dSi/8Vo23m1lTQcZxHDKLLdGR5e6BT5ak3G1w
         LSc7qrmxGijjDGx/c4IR9Z31U/nMD0lqiKXSoJoNfwCdXyaKGXRY2Y+mrdb68++vSgU0
         K9pQ==
X-Gm-Message-State: AN3rC/6tw+7CbpcD+jENWeMkewdqCtM5IjIfSToGww5qYtztTHiTjS3R
        qgPFyhNyW2JmjYP+
X-Received: by 10.99.106.71 with SMTP id f68mr8812977pgc.227.1492707745367;
        Thu, 20 Apr 2017 10:02:25 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:90d3:adf:57a8:ebdc])
        by smtp.gmail.com with ESMTPSA id 21sm11536587pfl.129.2017.04.20.10.02.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Apr 2017 10:02:24 -0700 (PDT)
Date:   Thu, 20 Apr 2017 10:02:23 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org, e@80x24.org,
        jrnieder@gmail.com
Subject: Re: [PATCH v5 02/11] t0061: run_command executes scripts without a
 #! line
Message-ID: <20170420170223.GE142567@google.com>
References: <20170417220818.44917-1-bmwill@google.com>
 <20170418231805.61835-1-bmwill@google.com>
 <20170418231805.61835-3-bmwill@google.com>
 <12add885-b56d-4707-57c1-1073fbb7786c@kdbg.org>
 <9c562827-78f5-ab8f-bf04-5f403672a32d@kdbg.org>
 <20170419155659.GA132229@google.com>
 <alpine.DEB.2.20.1704201245420.3480@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1704201245420.3480@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/20, Johannes Schindelin wrote:
> Hi Brandon,
> 
> On Wed, 19 Apr 2017, Brandon Williams wrote:
> 
> > On 04/19, Johannes Sixt wrote:
> > > Am 19.04.2017 um 07:43 schrieb Johannes Sixt:
> > > >Am 19.04.2017 um 01:17 schrieb Brandon Williams:
> > > >>Add a test to 't0061-run-command.sh' to ensure that run_command can
> > > >>continue to execute scripts which don't include a '#!' line.
> > > >
> > > >Why is this necessary? I am pretty certain that our emulation layer
> > > >on Windows can only run scripts with a shbang line.
> > 
> > Out of curiosity how did you have t5550 passing on windows then?
> 
> This is the reason:
> 
> 	1..0 # SKIP no web server found at '/usr/sbin/apache2'

Hmm, that's interesting.  So do any of the http tests get run on windows
then?  I wonder if that lack of coverage could be an issue at some
point in the future.

> As predicted by Hannes, your new test fails miserably on Windows:

Isn't 'miserably' just a bit harsh ;P haha

-- 
Brandon Williams
