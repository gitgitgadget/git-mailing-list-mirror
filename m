Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEAEC201CF
	for <e@80x24.org>; Thu, 18 May 2017 19:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754280AbdERTAc (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 15:00:32 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34976 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753711AbdERTAb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 15:00:31 -0400
Received: by mail-pg0-f53.google.com with SMTP id q125so26909953pgq.2
        for <git@vger.kernel.org>; Thu, 18 May 2017 12:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q92SDYv+cuXDH03EcQ3aPlgHf87gNEKL8Fzjv7IAHjo=;
        b=DX66IeTwG5PiwJ1c6wE+baZy/WfaEQ4+kUWRlX0rynIBClgmyqMdFN3qti9ZMcE/Dg
         tQelNPtdV9JCypeyjP+tNQ587fGPLh9vTg2bXsDqtmRsqEFWNn+yK2d1xbyHosD5biEY
         4LTNJ+LmXyYxWnjtWAjMOXrVBHjjZ8rEaOjsVEORJrAXpPPqUZsTx/vnlcAa0VjpSOug
         GuGeYFbasrkOA5km1H9j/EUZYuT+FqHQnO+j2ATBFdesHPUHwnjaDQZx8Cv+/o0ZfEYw
         Vv47qnzX4AL6hC9pelJqBW9NfyJhC0dpZsSmj0vO37JcGXO69IqEUvRyRhdTa4SiSkoY
         a4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q92SDYv+cuXDH03EcQ3aPlgHf87gNEKL8Fzjv7IAHjo=;
        b=nIEYJijp7q1IUvEldQPFviqjrKzF41XxIhJe3NFmOQ+B8gfAhsK328E28KsELxSHme
         K9dCEIE9F6QYE9zbE8S0UUaIhXZZ2ZQcHIibk6aI5NKNYYFYp8nsmWAu9bHFilI0S3YA
         XKiFJIxiAgdekJGKxFhjXXzgcR/SmPCjUV8e+Ao3d6bbzdN2R+c3HwwXK5nCpt3Rhv7o
         12N7f9j3PJHs/jeAn3KePhCjD9jJEdMhKk+9jM6nbLHQXcH/8Q21idJmpk/BgzYKTMcx
         hE+0f/pH/MUA4fFeGZ8B2d8vJ7wolNOzRn3CmJyTJal1DlNliu+mwbTHO5WHZdXOVXSq
         UAxQ==
X-Gm-Message-State: AODbwcB++5gXvBPFJ/zAwom/W+t0L6CFYiL0cx3NCc20SauqGAvIhaYA
        Fm58pJkVLjOA2a79w/c2RA==
X-Received: by 10.84.229.78 with SMTP id d14mr6580099pln.15.1495134030531;
        Thu, 18 May 2017 12:00:30 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:98a0:fe87:dfcc:8fe4])
        by smtp.gmail.com with ESMTPSA id r68sm11148555pfd.91.2017.05.18.12.00.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2017 12:00:28 -0700 (PDT)
Date:   Thu, 18 May 2017 12:00:27 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] submodule.c: add has_submodules to check if we have
 any submodules
Message-ID: <20170518190027.GD112091@google.com>
References: <20170517213135.20988-1-sbeller@google.com>
 <20170517213135.20988-2-sbeller@google.com>
 <20170518153508.GA112091@google.com>
 <CAGZ79kZZF7L0Wv5kPO+LxM6_7tA=DrD2RSn9SM708yvnxPnW3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZZF7L0Wv5kPO+LxM6_7tA=DrD2RSn9SM708yvnxPnW3A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/18, Stefan Beller wrote:
> >> +static enum {
> >> +     SUBMODULE_CONFIG_NOT_READ = 0,
> >> +     SUBMODULE_CONFIG_NO_CONFIG,
> >> +     SUBMODULE_CONFIG_EXISTS,
> >> +} submodule_config_reading;
> >
> > Any way we can have this not be a global, but rather a parameter?  You
> > could pass in a pointer to this value via the callback data parameter in
> > the submodule_config function.
> 
> As said in the reply to Junio, this patch has been sitting on my hard drive
> for a while and was written before you started the attempt to de-globalize
> the state of git.
> 
> Ideally this setting would be part of the repository object. For example
> the repository object would have a "submodule_config" pointer, initialized
> to NULL, which can then be set to the read config or a static empty_config
> if no such config exists.

I'm not quite sure I agree, or rather we may be talking about two
different things or I'm misinterpreting the patches.  From these patches
it seems like 'submodule_config' that you are refering to is not the
actual submodule configuration but rather some options that are stored
in .git/config or other various config locations (home, system, etc).
What would need to be part of the repository object (and is in my WIP
that I'll hopefully send out so i can get some feedback) would be the
submodule_cache which is the internal representation of a repository's
.gitmodules files.

-- 
Brandon Williams
