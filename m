Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6E611F453
	for <e@80x24.org>; Fri, 25 Jan 2019 22:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbfAYWVb (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 17:21:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36319 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAYWVb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 17:21:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so11907453wrp.3
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 14:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZZ1kxl3/+hTF0rOmW9CIQ4xiNThIJv6/glSMkufvwTs=;
        b=JCzZbuyey73pDTrWecK9DL43OiWkLB4sFVZBcaemnZPYKKftWE9D9UgM2XdcRG+dyc
         ho97l5KKklYPiBmXdsNUeAxyiqBSLCEbAbXt3l4VZiKN8sN8FVZ9g5aTucVRVL5WGVbf
         HjsJF+byK4mLmKaux7uqVGHbt1BRZoUmuTbJz0i7dtw0CNAmvkVKYLUvDcCl8quZkFhi
         wWa3T74nsHBJQ9TDEM/pVr3hL+vRyBGIJuAoBa5WFSirmkJn3szCU0GWN+XME/qEF+N/
         1PH3shZz75Mrs64ifJfgY5C/ZKIEYYZkLT+2zRYlFRlJF9WTqqjSTL5RJ+JvuGNWCcJq
         K9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZZ1kxl3/+hTF0rOmW9CIQ4xiNThIJv6/glSMkufvwTs=;
        b=OFQiswWZQTqTpF6LVCVHmEr/IKuL2tiyOb4QeypGn9HSiS1E7Ws+Qt6IPagv28Rm6h
         +5dK9fa5Ix8mTqKwjBXtvGQBNMd2q8OKEHbXsILEniJoK2HyslzQpnHhT/+gBPVNtcW1
         Yn2t5kDZq1P98KytGSNYt2jhLao849o91L1wuJDdbk4Z7AcTfNqKFL22DKq/CAg+7hM8
         cfCB1GNi1NCLyiP3+HVj98o6mgFWajxnkYNMy3TFDHBvnIg4LiDjOz/U0cOCe6ApDnMO
         Of5J76Z7gzZU/IdpnvlNRcodXBI1HWfbVhFcX8C6e+WOZHByL2iZUALQgDfQwlzhBrlH
         rflA==
X-Gm-Message-State: AJcUukc+m5o9DsCC8qFZvQTd9MvNcjdR863GBddl7A/g0e+4DFkTfn0+
        dA3NLMe2g6rRmdtwfzz8rCM=
X-Google-Smtp-Source: ALg8bN74j9sZvfRP/if/VbOT3lgojJLVYXfIYs+YDr6acEwAljC25pCsF6MhjZyMwq6GMiZ+vQw6Rg==
X-Received: by 2002:a5d:6aca:: with SMTP id u10mr12702130wrw.310.1548454889130;
        Fri, 25 Jan 2019 14:21:29 -0800 (PST)
Received: from szeder.dev (x4db9b7c2.dyn.telefonica.de. [77.185.183.194])
        by smtp.gmail.com with ESMTPSA id g188sm82559028wmf.32.2019.01.25.14.21.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 14:21:28 -0800 (PST)
Date:   Fri, 25 Jan 2019 23:21:26 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Regression in: [PATCH on sb/more-repo-in-api] revision: use
 commit graph in get_reference()
Message-ID: <20190125222126.GH6702@szeder.dev>
References: <20181204224238.50966-1-jonathantanmy@google.com>
 <20190125153348.GF6702@szeder.dev>
 <CAGZ79kZRnuTU3ukP1UdBUZD1x+nubYSwLxYgJse1mcj8JUOa2g@mail.gmail.com>
 <20190125221414.GG6702@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190125221414.GG6702@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 25, 2019 at 11:14:14PM +0100, SZEDER Gábor wrote:
> On Fri, Jan 25, 2019 at 11:56:38AM -0800, Stefan Beller wrote:
> > > Have fun! :)
> > 
> > $ git gc
> > ...
> > Computing commit graph generation numbers: 100% (164264/164264), done.
> > $ ./git version
> > git version 2.20.1.775.g2313a6b87fe.dirty
> > # pu + one commit addressing
> > # https://public-inbox.org/git/CAGZ79kaUg3NTRPRi5mLk6ag87iDB_Ltq_kEiLwZ2HGZ+-Vsd8w@mail.gmail.com/
> > 
> > $ ./git -c core.commitGraph=false describe --dirty --all
> > remotes/gitgitgadget/pu-1-g03745a36e6
> > $ ./git -c core.commitGraph=true describe --dirty --all
> > remotes/gitgitgadget/pu-1-g03745a36e6
> > $ ./git -c core.commitGraph=true describe --dirty
> > v2.20.1-776-g03745a36e6
> > $ ./git -c core.commitGraph=false describe --dirty
> > v2.20.1-776-g03745a36e6
> > 
> > it looks like it is working correctly here?
> > Or did I miss some hint as in how to setup the reproduction properly?
> 
> How many refs are pointing to the commits you tried to describe?  In
> the git repo, with an all-encompassing commit-graph it seems to be
> important that more than one refs point there.

Erm, let me try to clarify this sentence.

In general it seems to be important that more than one refs point to
the described HEAD.  In the git repo (and in other non-toy repos) I
could reproduce the issue with a commit-graph file containing all
commits, but in a minimal repo only when the described HEAD was not in
the commit-graph.

> I could reproduce the
> issue in a fresh git.git clone with Git built from commit 2313a6b87fe:
> 
>   $ git clone https://github.com/git/git
>   Cloning into 'git'...
>   <...>
>   $ git commit-graph write --reachable
>   Computing commit graph generation numbers: 100% (56722/56722), done.
>   # 'HOME=.' makes sure that this command doesn't read my global
>   # gitconfig.
>   $ HOME=. ~/src/git/git describe --all --dirty
>   heads/master-dirty
>   $ git checkout origin/pu 
>   HEAD is now at cb3b9e7ee3 Merge branch 'jh/trace2' into pu
>   $ HOME=. ~/src/git/git -c core.commitGraph=true describe --all --dirty
>   remotes/origin/pu
>   $ git branch a-second-ref-pointing-at-pu buzz ~/src/tmp/git
>   $ HOME=. ~/src/git/git -c core.commitGraph=true describe --all --dirty
>   heads/a-second-ref-pointing-at-pu-dirty
> 
> I could also reproduce it in other repositories lying around here, but
> could not manage to reproduce it in a minimal repository.
> 
> The smallest I could get is the test script below, where the last test
> fails, i.e. the clean worktree is described as '-dirty', when the
> to-be-described HEAD is not in the commit-graph.  I suspect this is
> the same issue, because it bisects down to this same commit.
> 
>   --- >8 ---
> 
> Subject: [PATCH] test
> 
> ---
>  t/t9999-test.sh | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100755 t/t9999-test.sh
> 
> diff --git a/t/t9999-test.sh b/t/t9999-test.sh
> new file mode 100755
> index 0000000000..cd1286e157
> --- /dev/null
> +++ b/t/t9999-test.sh
> @@ -0,0 +1,26 @@
> +#!/bin/sh
> +
> +test_description='test'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	test_commit one &&
> +	test_commit two &&
> +	# Two refs point there.
> +	git for-each-ref --points-at=two &&
> +	git config core.commitGraph true
> +'
> +
> +test_expect_success 'full commit-graph' '
> +	git commit-graph write --reachable &&
> +	verbose test "$(git describe --all --dirty)" = tags/two
> +'
> +
> +test_expect_success 'partial commit-graph, described HEAD is not in C-G' '
> +	git rev-parse one | git commit-graph write --stdin-commits &&
> +	git status &&
> +	verbose test "$(git describe --all --dirty)" = tags/two
> +'
> +
> +test_done
> -- 
> 2.20.1.642.gc55a771460
> 
