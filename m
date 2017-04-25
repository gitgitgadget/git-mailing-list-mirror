Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD4F2207E2
	for <e@80x24.org>; Tue, 25 Apr 2017 18:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971632AbdDYSip (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 14:38:45 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:32922 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2993142AbdDYSic (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 14:38:32 -0400
Received: by mail-pg0-f48.google.com with SMTP id 63so32392911pgh.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 11:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=czODtwObgTxhD7cc/52JXthnLDuu14oNDZe316Gavvk=;
        b=hI+4gsixYzq6rFeDA7KhxSEsHFzjvH/VLz1Mrm8W1ex9Mk0t5T5Oiy0mAUDtgnDyaS
         eLmJ3954dRmqStVCpkXigUq3djw2AbZDr/uQOwLy6zaVraUNK3waDCiLsAa9+kRJMsEb
         a1KCXJQYh3eGn/a3Tr1lDiMePNFhnLp34h9+37H9BnVOZ7qUwW7h/goLXBEB/d8vO1l1
         cmloSgohea0m6vnoDYzTFqN+KysgfsFlqJZRkDGtq99tFe9tQp0jHEklfYPuZDssW0XV
         kypAXsHUtalTxN1cHkc9YFcRxBdREZXlAaJWe5sAnVUFh16nwIjudey5vydbrdz09Rrq
         BZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=czODtwObgTxhD7cc/52JXthnLDuu14oNDZe316Gavvk=;
        b=RRosmaqxymBPVTKjzF7OqT0MbhMt7vAE/4An2v0eiX33fzqqLa5Hw5EXPpEXlQmhFt
         H81dQiVomw6tK4654aWUNANlx0tRWljbGbJtg7P0XTzmYDorW45JkLl3zGM5qq3vHggd
         wpUG6HuDNwftT6+/L1uDC0eAdQSanPW3p479+snW/u3Duwm1akjxCN6TadGonzo5Cu0G
         w3Pz+FiJPlcLX6PmIbC6BrS1JskJlj9qwoSZWaZbo3p3NTDmZ09FnRWbYcbxRrad9Fns
         NJjfV2R7ymXDMbjFiJtV0EdtFa8NGrwo7qECwQDen17gJJM3TTfF4g95798A/siYv1bl
         wUXw==
X-Gm-Message-State: AN3rC/5eVBlFq+i5GLooMc66t7IdAAjUI/qEPwtafxQOUlQ/icQCXUzt
        nmqlb4Ilav45y2/k
X-Received: by 10.99.24.86 with SMTP id 22mr29325025pgy.238.1493145511928;
        Tue, 25 Apr 2017 11:38:31 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:3165:1f91:2c02:1f0c])
        by smtp.gmail.com with ESMTPSA id z21sm37821072pfk.95.2017.04.25.11.38.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 11:38:30 -0700 (PDT)
Date:   Tue, 25 Apr 2017 11:38:29 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        e@80x24.org, jrnieder@gmail.com, peff@peff.net
Subject: Re: [PATCH v7 1/2] exec_cmd: expose is_executable function
Message-ID: <20170425183829.GC105623@google.com>
References: <20170424235042.26627-1-bmwill@google.com>
 <20170425175446.113553-1-bmwill@google.com>
 <73f07d3e-b2a2-0073-8fba-6f7f51f64a7d@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73f07d3e-b2a2-0073-8fba-6f7f51f64a7d@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/25, Johannes Sixt wrote:
> Am 25.04.2017 um 19:54 schrieb Brandon Williams:
> >Move the logic for 'is_executable()' from help.c to exec_cmd.c and
> >expose it so that callers from outside help.c can access the function.
> 
> The function is quite low-level. IMO, run-command.[ch] would be a
> better home for it. Additionally, that would reduce the number of
> files that contain #ifdef GIT_WINDOWS_NATIVE.

Fair enough, Jonathan suggested the same so I'll move it to
run-command in a re-roll.

-- 
Brandon Williams
