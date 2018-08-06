Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E3C5208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 14:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbeHFQyb (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 12:54:31 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42605 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbeHFQyb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 12:54:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id f1-v6so10797474ljc.9
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 07:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=q1LqQ25+PE+KV7ghhumHKMcE+AETHhbHXdnEoBJ8VWs=;
        b=Ik6S61vHDzfr7oO0AhQUTAE4hOVpokhp6psil/YLPQRcIBH5pHQQntWr3s3S2xq9im
         AUxwObWDmuNZc8yTNMSWMttpYkJ2cboPU1ppj+x43FAThzzsrx0bxub7W4KBsWiOgJO3
         X4FQwRhN6J+Jzrb9DkjkN4CvSbyKl6D2fDq0gMg/gHRGDjE2qM364SvAFb0dYBLq5byI
         wOMWAak5Q7s40at6KuXTReIP8cCLjyJBogDOAj4a3m+LqMR+cNs08z6p8BYUNDG1oVJO
         7q5euV0O8/6YiRh89qMrATDL8sbWzKv5pZGYDVrxUIKXI5iMT00KcrLGiHtCDE5BWuq3
         wA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=q1LqQ25+PE+KV7ghhumHKMcE+AETHhbHXdnEoBJ8VWs=;
        b=ZN2RGdWkhS7Q4R78X5ZQkeX2g5B9IxZUdxRQp+01lxheJuqNxjENmsS9MdPH5t4lr3
         oOfFmOYR6ii+LT9CxpsvSK2TfoHigtLU+XMtvDat/7B2VXBplvnUkykRPw7BaOKD+U/X
         RhJaka1ZjMAns2yoSJ9aTutG5BuSOS3n85RKdKEFN+dgvwX4n7F+bqzK5YLgGbbRvu3h
         fDHhQ1rwwFe0QFixBOmkatakdPjzB2sSvifH4lsftJcCpJczwWgER7iD4icox2td8fL4
         DhdluYbc5OHdvmh1KEuCBhlPWIvPBiFVUNxJzxg+Y2/DQPfUkfHY1il0mlCe1tgA5LpE
         yT9A==
X-Gm-Message-State: AOUpUlGHEd63tpIWSDZBbRy6YiIi0adToD3c4vekaPLPGBrxJOG8szaE
        iIPEt+cMPHuirq2c2/LitgJJv+Te1v7qrolIlxY=
X-Google-Smtp-Source: AAOMgpe1Rk9dc9ZGYLcRKgbMTt/JkGACVVaU9qc3wjk2+fHxWHMqoKAZ14Ev18uJkmzVlmiF9bh0MhqUw6FPplYxSgg=
X-Received: by 2002:a2e:8457:: with SMTP id u23-v6mr3560410ljh.95.1533566701710;
 Mon, 06 Aug 2018 07:45:01 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 2002:a2e:5ce:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 07:45:01 -0700 (PDT)
In-Reply-To: <20180802060842.GB10757@aiede.svl.corp.google.com>
References: <CAHd499B2VingKU-+7idv9FROYgCmOAzZ7YAQgWdwY1YUeTUVHA@mail.gmail.com>
 <20180802060842.GB10757@aiede.svl.corp.google.com>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Mon, 6 Aug 2018 09:45:01 -0500
X-Google-Sender-Auth: aEZCZbDtXCNQpU_6pDarjetcGDY
Message-ID: <CAHd499CFHUwpNdYp2sMjChi_WWzSihi5VRzLMQbKsGrKf_Ktcg@mail.gmail.com>
Subject: Re: Fetch on submodule update
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 2, 2018 at 1:08 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> I think I misread this the first time.  I got distracted by your
> mention of the --remote option, but you mentioned you want to use the
> SHA-1 of the submodule listed, so that was silly of me.
>
> I think you'll find that "git fetch --no-recurse-submodules" and "git
> submodule update" do exactly what you want.  "git submodule update"
> does perform a fetch (unless you pass --no-fetch).
>
> Let me know how it goes. :)
>
> I'd still be interested in hearing more about the nature of the
> submodules involved --- maybe `submodule.fetchJobs` would help, or
> maybe this is a workflow where a tool that transparently fetches
> submodules on demand like
> https://gerrit.googlesource.com/gitfs/+/master/docs/design.md would be
> useful (I'm not recommending using slothfs for this today, since it's
> read-only, but it illustrates the idea).

Hi thanks for your response, sorry I am a bit late getting back with you.

Maybe my workflow is dated, because I'm still used to treating
submodules as distinctly separated and independent things. I realize
submodule recursion is becoming more inherent in many high level git
commands, but outside of git there are separation issues that make
this workflow doomed to be non-seamless. For example, pull requests
will never offer the same uniformity: You will still have 1 pull
request per submodule. There's also the issue of log audits: You
cannot use blame, log, bisect, or other "diagnostic" commands to
introspect into submodules "as if" they were subtree or something of
the like (i.e. truly part of the DAG). A more realistic example of one
of the common questions I still can't answer easily is: "How do you
determine which commit in a submodule made it into which release of
the software?" In the case where the parent repository has the
annotated tags (representing software release milestones), and the
submodule is just a common library (which does not have those tags and
has no release cycle). Anyway, none of these issues are particularly
related but they do contribute to the answer to your question
regarding my workflow and use cases. The list goes on but I hope you
get the idea.

Some of the more functional issues are performance related: I am aware
enough, at times, that I can save time (in both local operations and
network overhead) by skipping submodules. For example, if I know that
I'm merging mainline branches, I do not need to mess with the
submodules (I can fetch, merge, commit, push from the parent repo
without messing with the submodules. This saves me time). If
`fetchJobs` was also `updateJobs`, i.e. you could update submodules in
parallel too, that might make this less of an issue. Think of
repositories [like boost][1] that have (I think) over a hundred
sibling submodules: Fetching 8 in parallel *and* doing `submodule
update` in parallel 8 times might also speed things up. There's also
`git status`, that if it recurses into submodules, is also
significantly slow in the boost case (I'm not sure if it is
parallelized).

Again, none of this is particularly related, but just to give you more
context on the "why" for my ask. Sorry if I'm dragging this out too
far.

The TLDR is that I do prefer the manual control. Automatic would be
great if submodules were treated as integrated in a similar manner to
subtree, but it's not there. I wasn't aware that `submodule update`
did a fetch, because sometimes if I do that, I get errors saying SHA1
is not present (because the submodule did not get fetched). Granted I
haven't seen this in a while, so maybe the fetch on submodule update
is a newer feature. Do you know what triggers the fetch on update
without --remote? Is it the missing SHA1 that triggers it, or is it
fetching unconditionally?

Thanks for confirming it behaves as I already wanted. And as you can
tell, I'm also happy to further discuss motivation / use cases /
details related to overall usage of submodules if you'd like. I'm
happy to help however I can!

[1]: https://github.com/boostorg/boost
