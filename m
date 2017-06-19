Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3D501FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 17:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbdFSRtp (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 13:49:45 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33849 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbdFSRtm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 13:49:42 -0400
Received: by mail-pg0-f45.google.com with SMTP id 22so23445588pgc.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 10:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4X2tYSQHwCYryl/hvvv6BXl/h7ySl2knqAvy1Fa6PA4=;
        b=Y1LM17MxNy8pUy/AZAvu3fNGPwPY2icLAVj5Tv1bASxz3zU7jYZ/eAJzBFZ+NqbM1Z
         ZEpORwV/AtBT7L0IkT4FhLDp0HA9PsA+iImgR85jYe7j/3a3g5rwID+JlkLe87Y7Btuw
         Jr21gBlZ0/LRVpgquykGx3U5jNYtMTcCY7OcqnkG5Vlnudl8dd47RRIwvFqPuJnFosbE
         U7Rj5HbHT5TEMETOSlCdMQLvFClXZ38PSJwBO1/3aljKScY5+KQORj/E3mtAtJp9TwLM
         Lt7GJsRXxtDBiY5kGS+Zfybh7l9KoNWmhZmltSc2j0swkvmspoHmWbgXvgArBjaTLZ89
         aFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4X2tYSQHwCYryl/hvvv6BXl/h7ySl2knqAvy1Fa6PA4=;
        b=i2G/ZAgvzomp/0Yu/qe4OisvP0z/oVCP9mw6O/YDhTVgl5Jp5GsfY/dkAkY1DgCkkm
         69aOeVAo74GbXlXb91Bgrd1Mr+KkPejDzO0FeBI5vXBszkhBxOg5cLJDYL0me1L12vAS
         Oot437kNsMBvD7xWmieVZwG6/y/z2mSGWc5nod6b6Lc81rVZj+7ZzQitQ7JFaCPOfhCu
         FfXczZZGepS4lJp+Cuw0XxZu68GDjIQAm1fXVAo9YB7cdMtGYmYsoBY/O7nxbZSVZofg
         wcm78dBKXJ9jjpvNvG4c8fWtYDFHBAsxnEhVdNFMbZJRvdN3rcGZSk9KzKKRbEnKc/9B
         tjmg==
X-Gm-Message-State: AKS2vOyso9eViQyMkuG/I/NMsYaOTNiPlH2snrGskJPpoHzN1+03r++Q
        z5yIYWxnhTcIDXP9WiiKoQ==
X-Received: by 10.98.56.6 with SMTP id f6mr26305430pfa.199.1497894581025;
        Mon, 19 Jun 2017 10:49:41 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:9b4:2c5a:b9fa:688d])
        by smtp.gmail.com with ESMTPSA id f72sm22448886pfe.4.2017.06.19.10.49.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 10:49:40 -0700 (PDT)
Date:   Mon, 19 Jun 2017 10:49:36 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     <eero.aaltonen@vaisala.com>
Cc:     <git@vger.kernel.org>
Subject: Re: Behavior of 'git fetch' for commit hashes
Message-ID: <20170619104936.706eff69@twelve2.svl.corp.google.com>
In-Reply-To: <14e804c6-0798-8bbd-b182-66c3cd2b870c@vaisala.com>
References: <14e804c6-0798-8bbd-b182-66c3cd2b870c@vaisala.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 19 Jun 2017 12:09:28 +0000
<eero.aaltonen@vaisala.com> wrote:

> For version 2.7.4
> =================
> Git exits with exit code 1.
> 
> However, if I first do 'git fetch <branch>', then 'git fetch <sha1> will
> also work
> 
>  * branch   <sha1> -> FETCH_HEAD

I suspect that what is happening is that 'git fetch <branch>' also
downloads the commit referenced by <sha1>, so the subsequent 'git fetch
<sha1>' is a no-op (except setting FETCH_HEAD).

> For version 2.13.3
> ==================
> Git exits with exit code 128 and message
> fatal: Couldn't find remote ref
> 
> However, the workaround for descbibed abot for git version 2.7.4 no
> longer works. The result is always
> fatal: Couldn't find remote ref

I'll take a look into this.

> Desired result
> ==============
> Commit is in .git/FETCH_HEAD and can be checked out.
> 
> 
> I want to checkout a specific commit without creating any extra named
> remotes in the local git clone.
> 
> Finally,
> What is the expected behavior for 'git fetch' in this case?
> Is there some other way I can achieve my goals?

I'll take a look into the expected behavior, but if my assumptions are
correct, you should be able to just checkout the commit you want after
fetching the branch:

  git fetch <forkUrl> <branch>
  git checkout <sha1>
