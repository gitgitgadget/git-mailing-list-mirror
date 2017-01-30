Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 571721FF1E
	for <e@80x24.org>; Mon, 30 Jan 2017 21:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754564AbdA3Vnp (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 16:43:45 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35436 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754541AbdA3Vnn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 16:43:43 -0500
Received: by mail-pf0-f172.google.com with SMTP id f144so93722804pfa.2
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 13:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gtsL/AFToeO7xy4GDCPzEcKuBY/6ec9ToQXTTfnZ3PY=;
        b=j9HjYHufF2xGU7c5Xm3ZBclHbVE/cacQsQTYBlzt27aV6b8ey1RNANYE9waroDCPGO
         hH9yfZ2Rx03mx0ONfuYqG/+Bv8w8un1wv/hpK9p1LntMxfQC++3e5nV4iCMCK+lKkhDH
         J4U24aCj86oQMIxzYF8uOwT5jBuVITyua1xzTRod0xhZ8DA7Dd0zScGd2isSSOgoHscd
         uCosDnngfgvES5LYz3BrneEgvvnGDYWSNzoB/jj8aaNvlLrj6EUDHQ9IwJ2AmuIdZMLu
         gxsPcpTS9NQ6lBsWxLfwRDkDFSgX0TSlSS+dOitmQTF8ix+QfeGYaix8WdKIRwbznpdF
         ZeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gtsL/AFToeO7xy4GDCPzEcKuBY/6ec9ToQXTTfnZ3PY=;
        b=OEO8iS6QfhoNS4aB7DvqFKsCtqqRJVgAWNU+S/btxQxWZ4JPmkH6gEcpkc+OSdaXCZ
         U3XVfX1ushfGKG3HZj/ASLaGg4cJbqkTV61c3i/+I5IS21CDuqJXbmunqKbwJ73uqS1o
         DtSKHJ8olTxkQghtsC6ait85NMrhhi4bS+XyKqcaQA7v8kPngik8S0PijsVLuNLK47fO
         +ndumkVMYZAvJqLmKNs+a2Q8szEzZ75ufjdwJCjhY+XVNrktaAi4HCBlNgwtUxAVRyEt
         A/ujtBWAlrhYkCWQd0MVeglxkxk84Itw5PboHTUgviUg1S0jrEKif7tleVGh5iZklkIr
         svGQ==
X-Gm-Message-State: AIkVDXI0VcpAN6AcyQWSm1grlyslTyv8lPpsloNbhCCKYwp21Zv6DwngSlaL7hcNQGM3fGHc
X-Received: by 10.99.122.94 with SMTP id j30mr10764654pgn.112.1485812594488;
        Mon, 30 Jan 2017 13:43:14 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:64a9:79a2:c65f:35e9])
        by smtp.gmail.com with ESMTPSA id r78sm34969271pfl.63.2017.01.30.13.43.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jan 2017 13:43:13 -0800 (PST)
Date:   Mon, 30 Jan 2017 13:43:12 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Peter Law <peterjclaw@gmail.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, szeder@ira.uka.de
Subject: Re: [PATCH] Completion: Add support for --submodule=diff
Message-ID: <20170130214312.GB35626@google.com>
References: <20161204144127.28452-1-peterjclaw@gmail.com>
 <CAKoneT+Bn+MdbeNnPJsu23rbLCZ=jxADNVtpNefw9zNYMq26dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKoneT+Bn+MdbeNnPJsu23rbLCZ=jxADNVtpNefw9zNYMq26dA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/30, Peter Law wrote:
> Hi,
> 
> > Teach git-completion.bash about the 'diff' option to 'git diff
> > --submodule=', which was added in Git 2.11.
> 
> I posted this patch back in December, but I've not heard anything. I'm
> sure as maintainers you're all quite busy, but I was wondering how
> long it usually takes to get a response to patches? (also whether I'd
> gotten some part of the submission process wrong?)
> 
> Thanks,
> Peter

It looks like this must have just fallen through the cracks.  Your patch
looks good to me and works when I test it locally.

-- 
Brandon Williams
