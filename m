Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D708720248
	for <e@80x24.org>; Mon, 25 Mar 2019 16:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfCYQEu (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 12:04:50 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39058 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfCYQEt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 12:04:49 -0400
Received: by mail-qk1-f195.google.com with SMTP id c189so5644000qke.6
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 09:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f5EqGfu+6k/OJuUdnt4uR8+gVdkrzJjWWdKqVqS3ZJU=;
        b=IVYHeuEH6dfmSDtE+DrxXdVYPD5YqVfFJR0sS/+7NCtOzypIoZzLU9DUVfhCwpaQaI
         g2YN7yKTv1ilxV0Y544nUgt8ZNFoABYAUiN6eTK8+RLeBRWw2pXykStSM/VglPRV3Jgo
         N2X2+9ny2cA4mvJK5E9iGG5+gpBpX2PosZPaOjxbxmHHwVaGBMlOT/euSu4YNNvZsPK6
         Nw5uHvzCv2ZUnKksFvbYLRnKpi4aBqkc5GuNnXg7sbvTat3/ljL4mEDssZNXUrjzz2k5
         ZY1mqN7wrBfuYdR3ZG+oteeFSWnw0l3Y+Br7Gru9EkJFLypWCMkcHTCAB/Il2qAYHaAr
         JbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f5EqGfu+6k/OJuUdnt4uR8+gVdkrzJjWWdKqVqS3ZJU=;
        b=Smph9FUnB9kIpCOpnzha6EMyX1alVhcilSi+OVEZKoY9dD9LQRoNqTUzdaN89o2Z/A
         6Upz/zGe8CmP2o5BR//X1UynxA433Vu2uHV1z0IA3PmvK8Uxj9WVArBwmEc3QXN+lAbP
         wXkK2xkdwjlGwtY7yiSOnfQzd0ckPDL227fNcbjybjXLq+2zlYyyV5QUr2kzpJPP2wdF
         Ol2bTt8XLo7xrOPfepO2iQEd7vTbYa2bsiUb0hIlTy9i9rEBx3Cs9jUt98RmmrM1JjgN
         wEYL0odSp0rbSGu+odJ11YZQkybRh4Gws+k67Ce77F6NRtv/UmxV+ri13PXtFYeH1gdF
         mHnQ==
X-Gm-Message-State: APjAAAUinHJNazEwyP9PVkJsv3cgOL1XBJHTT16bUyN6p37SxAvceJbD
        4/VghUccE9mYY5vUBP63VogIXw==
X-Google-Smtp-Source: APXvYqzyzMTj+JpQVQTl4f64368kOZRUPxurgL2NyBgonZqR+ta9LBgyZHh6R4KJqmIwhXW4Jizcsg==
X-Received: by 2002:a05:620a:15ef:: with SMTP id p15mr19364189qkm.317.1553529887973;
        Mon, 25 Mar 2019 09:04:47 -0700 (PDT)
Received: from ?IPv6:2620:0:1004:a:6e2b:60f7:b51b:3b04? ([2620:0:1004:a:6e2b:60f7:b51b:3b04])
        by smtp.gmail.com with ESMTPSA id j25sm7251243qtc.24.2019.03.25.09.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 09:04:46 -0700 (PDT)
Subject: Re: [RFC PATCH 0/1] Fuzzy blame
To:     Michael Platings <michael@platin.gs>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <20190324235020.49706-1-michael@platin.gs>
 <xmqq5zs7oexn.fsf@gitster-ct.c.googlers.com>
 <CAJDYR9RWUmXzh9Pn3qGBXAxNf70-SMKUCB3wwXVYKRTKOy8F_g@mail.gmail.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <b077afed-d143-506e-977e-6edf2492f75f@google.com>
Date:   Mon, 25 Mar 2019 12:04:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAJDYR9RWUmXzh9Pn3qGBXAxNf70-SMKUCB3wwXVYKRTKOy8F_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi -

On 3/25/19 5:32 AM, Michael Platings wrote:
> (resending in plain text mode, sorry for the noise)
> 
> Thanks Junio, that's super helpful!
> 
> A month or two ago I contacted the author of git-hyper-blame, Matt
> Giuca, asking whether anyone had looked into adding the feature to git
> blame. I didn't receive a response but maybe that prompted Barret
> Rhoden's patch? Or maybe just a weird coincidence!

Weird coincidence.  It's a big company.  =)

I work on a project that needs a major reformatting, and one thing 
delaying me was the lack of an ability to ignore commits during blame. 
hyper-blame does that, but I never liked the fact that it wasn't 
directly in git.

> 
> @Barret I see your patches are a nice translation of git-hyper-blame.

Not sure if you've seen my latest version, updated to v4 (2019-02-26) here:

https://public-inbox.org/git/20190226170648.211847-1-brho@google.com/

The one Junio has (br/blame-ignore) hasn't been updated - not sure if 
that's automated, or if it just fell through the cracks.

> However could you give me your thoughts on the approach in my patch? A
> comment in the git-hyper-blame source [1] says:
> # This doesn't work that well if there are a lot of line changes within the
> # hunk (demonstrated by GitHyperBlameLineMotionTest.testIntraHunkLineMotion).
> # A fuzzy heuristic that takes the text of the new line and tries to find a
> # deleted line within the hunk that mostly matches the new line could help.
> 
> My patch aims to implement this "fuzzy heuristic" so I'd love to get
> your take on it.

This is an interesting idea, and it sounds like it might be 
complimentary to the blame-ignore work.  Both have the flavor of "user 
knows this commit is special and wants special processing."

In my patch, I didn't try to find the likely original version of a line 
in a diff hunk.  What I did amounted to finding blame based on the 
parent's image of the file.  Example in this message:

https://public-inbox.org/git/20190226170648.211847-4-brho@google.com/

Of note, line 12 was blamed on commit b, when it really came from commit a.

For any lines added beyond the size of the parent's image (e.g. the 
ignored commit added more lines than it removed), those lines were 
removed from blame contention - marked with all 0s.

In essence, my method did the following:

	for all suspect/child lines 'i' in a diff hunk
		if i <= parent's hunk size
			assign to parent line i (+ offset)
		else
			mark umblamable

Due to the two cases being contiguous, each hunk would be broken up into 
at most two blame entries.  (I actually short-circuit that for loop and 
just split at i == parent_size immediately).

Having a smart/fuzzy matcher sounds nicer.  My patch passes blame to the 
parent.  Yours finds the right *part* of the parent to blame, which 
means we have a better chance of finding the right original commit to blame.

I think you're doing this:

	for all suspect/child lines 'i' in a diff hunk
		if i matches parent line (say, x)
			assign to parent line x
		else
			assign to child line i


 From glancing at your code, it looks like you break up every blame 
entry into N entries, one for each line, which you need since each 
parent line X might not be adjacent to the matching lines in the child.

One question I have is under which circumstances do you find that you 
cannot match a suspect/child line to a parent?  One obvious case is a 
commit that only adds lines - the parent's line set is the empty set.  I 
think you catch that earlier in your code (parent_chunk_length == 0), 
though I guess there are other cases where the parent has lines, but 
they are below a certain match threshold?

For those cases where you can't find a match, I could imagine marking 
them as unblamable.  The purpose of 'unblamable' in my patchset was to 
signal to not bother looking up further commit info for a final blame 
entry.  It was largely so that the user (me!) wouldn't see a commit 
blamed when I explicitly told git to not tell me about that commit. 
Both approaches sound fine though.

Another question was whether or not you wanted this to apply per commit 
or for an entire blame session.  It looks like your current code applies 
it overall, and not for a specific commit.  I'd much prefer it to be 
per-commit, though maybe the -F is just for showing it working in the RFC.

The first thing that comes to mind for me is to plug your fuzzy logic 
into my patch set.  Basically, in my commit near "These go to the 
parent", we do your line-by-line matching.  We might not need my 'delta' 
check anymore, which was basically the 'if' part of my for loop (in text 
above).  But maybe we need more info for your function.

That way, we'd get the per-commit control of when we ignore a commit 
from my patch, and we'd get the fuzzy-blaming brains of your patch, such 
that we try to find the right *part* of the parent to blame.

Anyway, let me know what your thoughts are.  We could try to change that 
part of my code so that it just calls some function that tells it where 
in the parent to blame, and otherwise marks unblamable.  Then your patch 
can replace the logic?

Barret

