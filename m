Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6D481F954
	for <e@80x24.org>; Mon, 20 Aug 2018 19:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeHTWrC (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 18:47:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43554 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTWrC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 18:47:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id v66-v6so5928941pgb.10
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 12:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+Nykqkrusml3VBGOeggg3WmKKfG46MzFRJrP+2NQZO8=;
        b=FJmPfzo/OxYbIyI3dijVXvrPbYlylea2utstb65B2iUYcf+AdUAUfDno3Fjcv3Diw6
         vAXjfH/sj2tM4DfxVhpPHd8fLrlwmi+yBl6Ye+7Hnhc4pOvYDa/XwniMbXiVge19gRM3
         IrMArTy0saPASt7CGKKI06uSGMDj62+H9vwIlirdp1YUt75rri1hq6GK3Z/tPZUQ4IYY
         9iWowu8t7GSp17dSj/yvUosnlnMsBQXzxahoD4JEC/g4TFggNHuK8Jd7iuSvX44aLVwm
         mH1GjlexlMPLyl7BAPl4PI34luuybfvHIBcqAsmXH2K6/N5NeSJ7UZZYk1avPqTh9SuV
         hHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+Nykqkrusml3VBGOeggg3WmKKfG46MzFRJrP+2NQZO8=;
        b=pp87dPpofvuvi5kkxgALPhJK09XxJzaZ+4jzab7EuvDAN9uhBhDiEtywTFPZGGC+pC
         AVjgSdid1t3MpsrqRIU2sBPdTrr9RMV90j5sps1krBBG25pdxN7DCvt515c0aAfCWDoo
         xF5dLgfp0ovslNvJb9SthK2Ic8bToM5SE13N/heRiIR7ZSyCj69qEFxyobFxbi2z5U3i
         1ZrXEpq7Yg3ezZdO7a15BSD8See+9ARNv4+yYWYuXEGj+8V5EiCvDCw74loXW0xYxITQ
         expG4Dz26ApbyCp6pN/lL15aXVvxLiAHCDwQwXLc9fzl25+2/CeKaB0RstRLIeYyz0jp
         QsaQ==
X-Gm-Message-State: AOUpUlGa3FWM6R62BJXnFfqZcufQUWLqqIKWMvDMusPyMLbyb0+onl2i
        yuCle+wnIQCizvpn/LUQttA=
X-Google-Smtp-Source: AA+uWPw+KxvB4qnzpCxD7IjPtSX7qORoG9uOrj4btCMAwStj4fTfao3MYXy8xbKCU/gZS0zDjhSfJg==
X-Received: by 2002:a63:e40d:: with SMTP id a13-v6mr43947263pgi.289.1534793409634;
        Mon, 20 Aug 2018 12:30:09 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id e82-v6sm16818759pfk.87.2018.08.20.12.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 12:30:09 -0700 (PDT)
Date:   Mon, 20 Aug 2018 12:30:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] commit: new option to abort -a something is already
 staged
Message-ID: <20180820193007.GB31020@aiede.svl.corp.google.com>
References: <20180820154120.19297-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180820154120.19297-1-pclouds@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Nguyễn Thái Ngọc Duy wrote:

> So many times I have carefully cherry picked changes to the index with
> `git add -p` then accidentally did `git commit -am ....` (usually by
> retrieving a command from history and pressing Enter too quickly)
> which destroyed beautiful index.
>
> One way to deal with this is some form of `git undo` that allows me to
> retrieve the old index.

Yes, I would love such an undo feature!

How would you imagine that this information would get stored?  We can
start with adding that and a low-level (plumbing) interface to it, to
avoid being blocked on getting the user-facing (porcelain) "git undo"
interface right.  (Or we can go straight for the porcelain.  It's fine
for it to start minimal and gain switches later.)

[...]
> Instead, let's handle just this problem for now. This new option
> commit.preciousDirtyIndex, if set to false, will not allow `commit -a`
> to continue if the final index is different from the existing one. I
> don't think this can be achieved with hooks because the hooks don't
> know about "-a" or different commit modes.

I frequently use "git commit -a" this way intentionally, so I would be
unlikely to turn this config on.  That leads me to suspect it's not a
good candidate for configuration:

- it's not configuration for the sake of a transition period, since some
  people would keep it on forever

- it's not configuration based on different project needs, either

So configuration doesn't feel like a good fit.

It might be that I can switch my muscle memory to "git add -u && git
commit", in which case this could work as a new default without
configuration (or with configuration for a transition period).  A
separate commandline option "git commit -a --no-clobber-index" might
make sense as well, since then I could pass --clobber-index to keep my
current workflow.  That would also follow the usual progression:
introduce commandline option first, then config, then change default.

That said, I lean toward your initial thought, that this is papering
over a missing undo feature.  Can you say more about how you'd imagine
undo working?

Thanks,
Jonathan
