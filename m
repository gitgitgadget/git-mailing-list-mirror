Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B91AD20248
	for <e@80x24.org>; Mon,  4 Mar 2019 09:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfCDJN2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 04:13:28 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33691 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfCDJN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 04:13:28 -0500
Received: by mail-ed1-f65.google.com with SMTP id c55so3623163edb.0
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 01:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eidFX+ARkgbf3dpsb1kwUPvIlWWnPR2uJ3WNFf7UPOc=;
        b=tALp0Apguem9miLHMhzXjHHpaXGYOjecG77yxEhhahFs9dUO23KWAt4f66at9N41UY
         RusVJHFYe6LCaZofycx9HQDMNNILRFFxIXAo0XMQWYIVQlTaboe86vOvcmRLnBzc/533
         Ii7/UaUzhPTeFlA1L1d1MR4y2MFX0921/tYisJuKFXdR5B7Ngti3gT5p7s0bLIq5N8Cq
         I8HQ+UxXyn0APenIwUyDDvIpVV9jIoNxGOjuN2x2GLDONDK6LxuIoRqkkFiC+mP8zjEI
         nRsz1faq+X/7aj2vAL9h0xONExl1x+bJU0yisB0vKjGpYz9ALUM3bDDfnJjH0hG3omns
         fzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eidFX+ARkgbf3dpsb1kwUPvIlWWnPR2uJ3WNFf7UPOc=;
        b=rQKP504tWJxk1/GYSHhIHY0nX0SdfDguuJzX9kF1SC/a+/0kqeSU0mH9kr67fu62m9
         trbI3FOFayXaAmhLI8ZhSoD7nI+LxHJTbKefwTMmdNoVUGhjUXW4t9OsIhUeIAeHNGIS
         xGTgbnsaOF9MGrftsw06mGd9TzyWzwTJTR7PCiLXW4jCMGXhBQbls2fqiFjgwD2i+VVP
         CinfgFq+gwJ1fnfPAGzH1nZD0etC2TdtTj6+GYTSBGw/hbvKGLdCachF73X9Et4Ni3GU
         cNtaIWw7UFL3g6Q1u3nPtFt2fgz15RNFZlimdrUeLvQEnjPeDqnvi46jO3Ut16ws+T0H
         LQ5w==
X-Gm-Message-State: APjAAAVAMv9IFiC2TO9vf/8TdkfcZSrQNCi4MPTck9vuaqccVP+5Ljtr
        zRnw8ly8mrkN1cHLHkiasxO5+ADeuZI=
X-Google-Smtp-Source: APXvYqxyM1TcLY2nMri2PevO1nifxkmwpOApN8pz/EFxjXm8Q2KE1hHrMjcCbrFSqBeVMXUpwMEHzA==
X-Received: by 2002:a17:906:1653:: with SMTP id n19mr1133110ejd.14.1551690804796;
        Mon, 04 Mar 2019 01:13:24 -0800 (PST)
Received: from [10.10.163.202] ([212.61.153.66])
        by smtp.gmail.com with ESMTPSA id h35sm1918187ede.8.2019.03.04.01.13.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 01:13:24 -0800 (PST)
Subject: Re: [PATCH 1/1] Add feature to show log as a tree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20190303103751.6523-1-nelissen.micha@gmail.com>
 <xmqqd0n814kg.fsf@gitster-ct.c.googlers.com>
From:   Micha Nelissen <nelissen.micha@gmail.com>
Message-ID: <cc77a06e-2fa7-f3b3-dcc4-9bf385d7f384@gmail.com>
Date:   Mon, 4 Mar 2019 10:13:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <xmqqd0n814kg.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03-03-2019 14:16, Junio C Hamano wrote:
> I am not sure what you mean by a "tree".  It definitely is not a
> tree perceived by Git users (which is what represents a directory
> structure), and abusing the established term is confusing.

I called it tree because the output looks like (right half) of a tree. 
I'm open to alternatives though.

> There is no inherent ordering among children of a given commit, so
> you'd invent some way to define what "the first child" is.  That
> much can be read from the above, but what is missing is why do you
> even need to bother.  What benefit do users get by identifying "the
> first" child and cutting all others off---that is the necessary
> justification for this change, which is missing from the above
> explanation.

Right, in my mind the problem statement is so clear and I didn't write 
it down. There should have been an introduction paragraph.

Problem I want to solve. The --graph output is useful but often 
unreadable, due to the many parallel lines. On the other hand, with the 
default straight line log output all structure is lost. I am trying some 
middle ground to see merge structure, but keep history readable. I 
noticed in particular the branch point causes a line to go around or go 
in between many commits leading to clutter, so I want to remove these. 
By itself the exact point branched from is rarely important (at least to 
me). And if it is, then there still is --graph :-).

> "A (depth) level" is poorly explained---in fact, it is not explained
> what it means at all.  "We designate the first child of each commit
> by some magic" is all we can read from it.

When processing the commit nodes. Start with depth level 0. Given some 
current depth level D, assign depth level D, D+1, ... D+N-1 to the N 
parents of a (merge) commit. Recurse.

In the output, the depth level is more or less the column number the 
star '*' is in. (Although after merges of merges, there will be gaps in 
the level numbering.)

> After explaining "some magic" in a more meaningful way, perhaps
> you'd realize that you'd want to stop saying "first child".  It

OK well, the term "first parent" is already in the man page, right? 
--first-parent. So the first child of a commit is the commit C among all 
children H, such that when all of H are traced back to a common point S, 
the trace line from C is the one that ends being the first parent of S.

> ignore all side branches and concentrate only on the trunk of a
> tree).  And I'd probably call each child that is on the "trunk" line
> of the most important lineage "primary child" or something like
> that.

Sort of, but remember this works recursive, there can be merges of 
merges. Therefore the output is not a single trunk line. In other words, 
the above commit S doesn't need to be on the trunk (or, '*' completely 
left in the graph output).

> In any case, if this is to sit next to and be friends with
> "--topo-order", the option should be named as "--some-order".
> The option name "--tree" (or "--blob", "--tag", or "--commit" for
> that matter) is obviously unacceptable if the option is about
> specifying how the commits in the "git log" output are ordered.

I see it as alternative to the --graph option. I also made it jump 
there, but maybe gotos are rejected from style point of view. In this 
case I thought it would be clear to see it as alternative to --graph.

It doesn't do justice in my opinion to call it --graph --micha-order (or 
whatever ;-)), as it is not only about changing the order of commit 
display. But again, I'm open to alternatives, I can make a personal 
alias anyway :-).

> Having said that, if you are omitting commits that are not on the
> primary lineage of the history, then this is not "--anything-order"
> option, in which case it may want to sit next to and be friends with

Ah no, it doesn't omit any commits. All commits are displayed.

> Without clear explanation of what the change attempts to achieve in
> docs and tests, there is no way to review to see if the new code is
> correct.

How can I add tests for this feature? I'm also open to what kinds of 
documentation to add, as I find it way easier to explain when you 
actually run it to see the output it generates, than from abstract 
paragraph of documentation text (like a manpage has). Some 
mathematical-type of explanation like above is also not really 
immediately enlightening, and also not necessary to use it I think.

Thanks for review, Micha


