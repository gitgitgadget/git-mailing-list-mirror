Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ECB81F404
	for <e@80x24.org>; Mon,  2 Apr 2018 02:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754092AbeDBC46 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Apr 2018 22:56:58 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:46366 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754074AbeDBC45 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Apr 2018 22:56:57 -0400
Received: by mail-wr0-f175.google.com with SMTP id d1so12222594wrj.13
        for <git@vger.kernel.org>; Sun, 01 Apr 2018 19:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yAX+D3Gcty6laLK3wJumdLtIr3pczSJ/zznUYy5FVXE=;
        b=fjb0L+ytHuwavb9/aGJtxNlw/N4cG1eDF4YdVoCWlCyku0ewJ10AHPpuseqwQslCLj
         BWzkQzex9rJ7bSCCiFm7g9RWXNweyLtm4eB6sbtSyBFSUBk3L5jEzsXHDlpSzsaI4J39
         CFasEpBEqWVd3T7s2nzvtawMltHITXYS/82JqRs1M+N6EUUPz5q7Q1Y/QnEfIxT4lsNe
         f09ywp1O6NiU4RfCIkv7pTRFn5TgZ26x9AM2bJk9GELUjlokO2qcCpfMv5VqLcaFDrq4
         WuQIgFxHaudZNf26LlHQQSxy2MFjVyXEJ6FlDolg1UAiUny73WEo65IcunoQZunPNUBX
         l75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yAX+D3Gcty6laLK3wJumdLtIr3pczSJ/zznUYy5FVXE=;
        b=LZ1+9vlfTlIzY5aRH3h77A7a6TgnuCl1bwUoeieudyLHp/OlkU6m0Y8tHUTXE1hpOp
         X7i0PkhR3whHWj44O0iB8/Li3PB/7oN4jyGt8FtGu/hDyQbhGkYSruemBjECAKvQpHIH
         ijTp19zPAFF/h+UhXJDLNtb+IDQVUUz/Hmhr5emIstoiOE3sGtEuhHVcLW8Fr36tlk5W
         +l3IADB0PCRg8npVDJ5Fm/YgYvnT1QYPX3Tu3OzMPrm2GaKRSzj58vZHLioCQMEQHlHb
         kO6GSfbeM7wobVQvdk5wiGnux69ITm3DWPrfM9s0x7yvb89tQSxuAPRwVB2TObfndLfE
         O2TA==
X-Gm-Message-State: AElRT7FdcJA/RoSBBl6gOyCchF6C1dNLKX3Bq1BTnDgSvK1VMWAgdBMK
        pGZsofC7/+NBiFrHA5+e1hI=
X-Google-Smtp-Source: AIpwx4+OkgUaV/D9HGLOcvoss3deC1tmaN4wbMehgpU3FETI1ywuwQnGUsxZ8dvxV9KO3CbGE2vBQA==
X-Received: by 10.223.161.135 with SMTP id u7mr5450672wru.184.1522637816216;
        Sun, 01 Apr 2018 19:56:56 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k184sm8089624wmk.45.2018.04.01.19.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Apr 2018 19:56:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yubin Ruan <ablacktshirt@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] git clone add option to track all remote branches
References: <20180402015035.mzgye6apwn3igch5@HP>
Date:   Sun, 01 Apr 2018 19:56:53 -0700
In-Reply-To: <20180402015035.mzgye6apwn3igch5@HP> (Yubin Ruan's message of
        "Mon, 2 Apr 2018 09:50:35 +0800")
Message-ID: <xmqqwoxqz56y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yubin Ruan <ablacktshirt@gmail.com> writes:

> I am writing to ask that whether or not you think will be appropriate to add
> an option to "git clone" so that whenever a repo is cloned, branches are
> created automatically to track corresponding remote branches. (or is there any
> equivelant option?)
>
> You can obviously do this by a bash command like this
>
>     git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
>
> but it will be better if we can have an option in "git clone".

I am not sure how it will be more useful than what you already have.
In short, you are getting "all of the remote branches" but with a
twist.  You get them "on demand".

With your hypothetical "clone" command that makes copies of each and
every remote branch to a local one, you can ask "git branch<Enter>"
to show all of them (i.e. "please list what is happening at the
central repository").  With the current system, you would instead
need to ask "git branch -r<Enter>", which may be a bit more to type.

Also when you want to look at or work on top of a remote branch, say
"frotz", you do not have to do "git checkout -b frotz origin/frotz"
to create one, as your hypothetical "clone" would have already
created it when you cloned.  But I think "git checkout frotz" in
such a situation would create a local "frotz" branch out of the
"origin/frotz" remote-tracking branch with the current system, so
I do not think your hypothetical "clone" is all that more useful.

And there certainly is a huge downside.

If you are really doing your own development, then you would have
some topic branches of your own, with forks of some (but most likely
not all, especiallyi when there are many branches at the upstream)
branches you got from the upstream, and "git branch --list" that
shows only your own and what you are interested in (i.e. those that
you actually bothered to "git checkout <branchname>") without
showing random other branches that exist at the remote but do not
interest you is a feature.  Your hypothetical "clone" that
indiscriminatedly forks all branches at remote locally will destroy
the usefulness of it.
