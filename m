Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 872921F597
	for <e@80x24.org>; Fri,  3 Aug 2018 06:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeHCIjL (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 04:39:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40097 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbeHCIjL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 04:39:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id x5-v6so2380303pgp.7
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 23:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5yktNIPCp9zynvnIeS/LOV9rzzmUACZiAbBvtgKB9F8=;
        b=pCyZipX4B5Rm1jUUAXHq3YavsB/7kNz4mBQlYVrj+TOP6YWlwCLsFmH32afPS2Nvmv
         6t2SLp10Gkp+WxvmQlSnmH5lg63Oj6t8VOFH3b36m//piM10/r2s12LpBf9Yg2FHRcYx
         QL4ewG68hslY/C7wUOAdhKi0bWZ4PTkAexFBk2MEebrgUI+61c9N2gk+9s5ImEzwGpLq
         w6s0Pj13h54TTYOEZKCXfDXwg8MFdhnsIMncsEk2LAnaGPZKfPQSXwzcAps49eKl4fF4
         SgaVIwhx777Tpr49w3CgwOxMl8gt2juoVJ8qJhaXzObXgBglrgk0fT+cJqqlQlGVlDg4
         oGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5yktNIPCp9zynvnIeS/LOV9rzzmUACZiAbBvtgKB9F8=;
        b=Wsi41FfdqWq3JrOkq+rC3z13gN9OiyoACXCu3U3pWuH9z0stZ2RPlcNLA0GB5sy1xR
         7GlpXrRMvu/oTC0qYxcP4AhxcPo4RXj5VSH2wbdfyHQYT1i6Ju6uVhFxwecRh4GQ4VeB
         c6ZWBINT5yTHSO0MkJskMQSLKbklF3ABYzpFWgkOZLJcIXK8KEtb1O2UoMZdcXBO9Xz/
         6r8E0aAaT/GaDWU3fTE3A4IuMAhapqnNTM/PLr7H+jHi6iWdRbdYkDtkmfaX+woao7qF
         z/ru0dJCQT72zgU5Un6BazaxUTVBaVhMssvSN5m64cD+JsrmOoqHhdN6F12EVa9KMWDM
         HhOg==
X-Gm-Message-State: AOUpUlEp+UZLpt3DDVVa2a6RnMpRULxy9mqRd/7TD3vViEbXiQTyw/Wk
        fx6JW4ApWoRGmE0sE7/1OfE=
X-Google-Smtp-Source: AAOMgpdMmqoUXV+LSE5n9ZXYHHu8l1zCLYayNIPz2nF05VJ52SC4xXAywY0q+KDBcOoB6lGkFbQiaw==
X-Received: by 2002:a62:3856:: with SMTP id f83-v6mr3028070pfa.48.1533278661815;
        Thu, 02 Aug 2018 23:44:21 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id l71-v6sm4653341pgd.70.2018.08.02.23.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 23:44:21 -0700 (PDT)
Date:   Thu, 2 Aug 2018 23:44:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        nicolas.palix@univ-grenoble-alpes.fr,
        yamada.masahiro@socionext.com, cocci@systeme.lip6.fr,
        nicolas.palix@imag.fr
Subject: Re: [PoC] coccinelle: make Coccinelle-related make targets more
 fine-grained
Message-ID: <20180803064419.GC237521@aiede.svl.corp.google.com>
References: <20180723135100.24288-1-szeder.dev@gmail.com>
 <20180802115522.16107-1-szeder.dev@gmail.com>
 <20180802180155.GD15984@sigill.intra.peff.net>
 <87bmaktpbt.fsf@evledraar.gmail.com>
 <alpine.DEB.2.20.1808030755350.2446@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1808030755350.2446@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Julia Lawall wrote:

> This was already possible.  Make coccicheck is not supposed to be used
> with -j, but rather with J=n.  That tells Coccinelle to parallelize the
> treatment of the files internally.  In this case, the semantic patch is
> only parsed once, and then n worker processes are forked to treat the
> different files.

Thanks for this hint.

I wonder if we can make this happen automatically under suitable
conditions.  We can parse -j<num> out of MAKEFLAGS and convert it into a
J=<num> argument, but that only solves half the problem: the "make"
parent process would think that the coccinelle run only deserves to
occupy one job slot.

Technically we could do all this using a wrapper that pretends to be a
submake <https://www.gnu.org/software/make/manual/html_node/Job-Slots.html>
(prefixing the command with '+', parsing jobserver options from the
MAKEFLAGS envvar) but it gets ugly.

It's likely that the best we can do is just to advertise J more
prominently.

[...]
>> On Thu, Aug 02 2018, Jeff King wrote:

>>>   cat contrib/coccinelle/*.cocci >mega.cocci
>>>   make -j40 coccicheck COCCI_SEM_PATCHES=mega.cocci
>
> There was already a COCCI=foo.cocci argument to focus on a single semantic
> patch.
>
> I'm surprised that the above cat command would work.  Semantic patch rules
> have names, and Coccinelle will not be happy isf two rules have the same
> name.

Yes, Git's semantic patches (in contrib/coccinelle) tend to be
relatively undemanding.

>       Some may also have variables declared in initializers, although
> perhaps the ones in the kernel don't do this.  Causing these variables to
> be shared would not have a good effect.

... oh!  You're thinking of the Linux kernel.

It looks like Linux's scripts/coccicheck has a lot we can crib from.
That's where the J envvar and automatic parallelism you mentioned are
implemented, too.

So it sounds to me like at a minimum we should use all of that. ;-)

Thanks again for the pointers.

Sincerely,
Jonathan
