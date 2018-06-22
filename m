Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 995781F516
	for <e@80x24.org>; Fri, 22 Jun 2018 17:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932892AbeFVRNO (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 13:13:14 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38016 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754264AbeFVRNN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 13:13:13 -0400
Received: by mail-pf0-f193.google.com with SMTP id b74-v6so3512564pfl.5
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 10:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t8QiVlpn0q0p7SJhvrxnuZszcKiMx5xqRixsno3UBOo=;
        b=IGtAywFk/SWeTUU9z9RYNqcl2u9/K+ujK4fbTC240oSKPmL79cpvPoYwj0oVgHN81/
         cPReJ2mWbeeoWV44UycyyDJwgWrn+PRYfh5b5JNsUbP/LIcI6sHZVlYOuuiyosJyBO65
         GACtWHqkW++SPNojhVtfYEzUDY5u+tCjsqOJZu0D4zXnvqoBqYr5jE1JTrhvVSsKTW5l
         LdZOyEmH6bETfWIG2RANRP078AVbBhgmuRP1dFxGJoXy+DsAAHBKxbaQyu6P6iGlWZlr
         sJCdqcyxMgIwDC8xM/0+Bm4MhsIHPbjcEWT4AnJv5oo80d1N4O5tuLb0Yh9G2jRu9dLs
         peJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t8QiVlpn0q0p7SJhvrxnuZszcKiMx5xqRixsno3UBOo=;
        b=NQ1VhG1N1aD9R1zaUlsggB4R8hE7jskNMVaVYWcpSjWYeQRLhS34uc/G00lJuONIoE
         ASaeckCflZsZerLh+ynz2yJMuSd6M/R7Kd2HUxXx5tJo5Ny/8x7f+DnjhSGi2GZUgY+Z
         6F3VzDCC/qlkeKTdp2fqrwPFrhlO0m1DcvzYRT/UzteAc46DKlfjRjGx45OKQkS30LCf
         s/btQUyB7t2shRhgautt7mZj7AoReHm7shmLdlfcHQXHOfEXP1pU8dam4+gepR3gqFIQ
         5K4A+7P8tjXOMKApbb3gXjXCvFp+ZtMszhIu0lASDyJl4pxd2espA9H9Le7/Gm9uw8qU
         sv3A==
X-Gm-Message-State: APt69E2Fyiqyyds/pXKafJt1z2kH48jsqDSZRItWPEAsDCqSI3Qxr9WE
        53bNtO+JF3Yw4tN94VY6udlyG9qaopc=
X-Google-Smtp-Source: ADUXVKIw8dObLgXMVzVIYMZGlJ6ssa+hFn+fLF0ygp02lrY/jW/sM7MRKysUtOZXjAifMFkhyU+drA==
X-Received: by 2002:a62:e506:: with SMTP id n6-v6mr2643851pff.116.1529687592788;
        Fri, 22 Jun 2018 10:13:12 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id h10-v6sm11043041pgc.28.2018.06.22.10.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 10:13:11 -0700 (PDT)
Date:   Fri, 22 Jun 2018 10:13:10 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/7] Restrict the usage of config_from_gitmodules()
Message-ID: <20180622171310.GE244185@google.com>
References: <20180622162656.19338-1-ao2@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622162656.19338-1-ao2@ao2.it>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/22, Antonio Ospite wrote:
> Hi,
> 
> when I tried to reuse and extend 'config_from_gitmodules' in
> https://public-inbox.org/git/20180514105823.8378-2-ao2@ao2.it/ it was
> pointed out to me that special care is needed to make sure that this
> function does not get abused to bring in arbitrary configuration stored
> in the .gitmodules file, as the latter is meant only for submodule
> specific configuration.
> 
> So I thought that the function could be made private to better
> communicate that.
> 
> This is what this series is about.
> 
> Patch 1 moves 'config_from_gitmodules' to submodule-config.c
> 
> Patches 2 and 3 add helpers to handle special cases and avoid calling
> 'config_from_gitmodules' directly, which might set a bad example for
> future code.
> 
> Patch 4 makes the symbol private to discourage its use in code not
> related to submodules.
> 
> Patches 5 and 6 enable reusing 'config_from_gitmodules' when it's safe
> to do so.
> 
> Patches 7 is just a cleanup and I am not even sure it is worth it, so we
> might as well just drop it.
> 
> The series can be seen as a continuation of the changes from
> https://public-inbox.org/git/20170802194923.88239-1-bmwill@google.com/
> 
> Even though the helper functions may be less elegant than what was done
> back then, they should better protect from misuse of
> config_from_gitmodules.
> 
> A further change could be to print warning messages when the backward
> compatibility helpers find configuration in .gitmodules that should not
> belong there, but I'll leave that to someone else.
> 
> Thanks,
>    Antonio
> 
> P.S. I added Jeff King to CC as he has done some work related to
> .gitmodules recently, and I removed the vcsh poeple on this one.
> 

Thanks for working on this.  I think its a good approach and the end
result makes it much harder for arbitrary config to sneak back in to the
.gitmodules file.  And after this series it looks like you should be in
a good place to read the .gitmodules file from other places (not just in
the worktree).

As you've mentioned here I also agree we could do without the last patch
but I'll leave that up to you.  Other than a couple typos I found I
think this series looks good!  Thanks again for revisiting this.

-- 
Brandon Williams
