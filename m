Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B7AA20248
	for <e@80x24.org>; Sun,  3 Mar 2019 13:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfCCNQT (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 08:16:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45282 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfCCNQT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 08:16:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id w17so2538663wrn.12
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 05:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jSPYXHxjYsRbhm/a6TJd7pWhYA+w3iQQcPo9EDmAWJ8=;
        b=C1RCGOz1V3wU3vHIP87d1PZVlsheXOj8ViVShI9AcWtfZQ7z4b+FrQd+kQdCgyVj+H
         Wforln4kO9ZxmQZPZ0puttPg0yjPcj3/SzwAEC9O963+Q5Wg1iF6OffJO66UHQt02Ale
         b8vqFJ1I1RYqdmtxmOUSVRjD6fr9X1szdQ/2qoJt6nMl10z3bSEWXJM+InZO2DnC6PvA
         jG5KSIhTqgo16EPxhiL121WfbEi2OYGlGKYw2lZyr9rW0ZrIPp6KdSCvxF3V1FxYn91x
         7cw5IhQPPhatmXRFSJzZdRx9kBzreBoWSUYbQAkg0zdroTJG5Y0zAIcgsuDjZCyXX1/Q
         Rqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jSPYXHxjYsRbhm/a6TJd7pWhYA+w3iQQcPo9EDmAWJ8=;
        b=cNotdmZFPya9ArzDI+GDz82qcqyaX0JtONW5wZqmHHE5TK4ZpCdK7/exZbOkuTFPuG
         C7+ULY24/n5EgTwiGr8H1nZXDMjpNNgR49WJSjuCXWxoxim3kVopPaSlarRmC39VgPXD
         67c/5FyTDTC229ymvp29fSTJTsZ3Qt/uEVN2zlgfGafjY1o0SQhesxoMUH5Mil3AjmZK
         oFoRCqS91FL33zgddObZVti4wqOZn4YMbMjbe2pQDH7opmrSuqJiBUNwfazF10abLenr
         8CtwtkVaBpDkfmsavqTE2IgqdKwFRipwkNH7vQd/C1s2D9Hn7dppjZUdXbB43vO9UOfT
         3qdw==
X-Gm-Message-State: APjAAAUHE98cD7hPW5NMf18GW0LfBtxv/Z7ovEQpjogd/6+m5QBFbIb5
        YAZk0SRcqVak76gZgUYiIkU=
X-Google-Smtp-Source: APXvYqx/1Pk3pYJ/Xdk7gHgVdl36UOAfVRA+vae/MQLLPcy8RfZnYFdyktia8e1QTDBeuap3DdxLnA==
X-Received: by 2002:adf:ee0f:: with SMTP id y15mr9243745wrn.197.1551618976762;
        Sun, 03 Mar 2019 05:16:16 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p6sm14551748wre.63.2019.03.03.05.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 05:16:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Micha Nelissen <nelissen.micha@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] Add feature to show log as a tree
References: <20190303103751.6523-1-nelissen.micha@gmail.com>
Date:   Sun, 03 Mar 2019 22:16:15 +0900
In-Reply-To: <20190303103751.6523-1-nelissen.micha@gmail.com> (Micha
        Nelissen's message of "Sun, 3 Mar 2019 11:37:51 +0100")
Message-ID: <xmqqd0n814kg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Micha Nelissen <nelissen.micha@gmail.com> writes:

> Modifies the topo-order code to keep track of the first child,
> using a heuristic. The heuristic works by assigning a (depth)
> level to all nodes. The first child is the node of which this
> node is a parent of and has the lowest level. Then it cuts all
> the links that are not the first child, resulting in a tree.

I am not sure what you mean by a "tree".  It definitely is not a
tree perceived by Git users (which is what represents a directory
structure), and abusing the established term is confusing.

There is no inherent ordering among children of a given commit, so
you'd invent some way to define what "the first child" is.  That
much can be read from the above, but what is missing is why do you
even need to bother.  What benefit do users get by identifying "the
first" child and cutting all others off---that is the necessary
justification for this change, which is missing from the above
explanation.

"A (depth) level" is poorly explained---in fact, it is not explained
what it means at all.  "We designate the first child of each commit
by some magic" is all we can read from it.

Please try again.

After explaining "some magic" in a more meaningful way, perhaps
you'd realize that you'd want to stop saying "first child".  It
feels to me that you want to use a heuristic to identify the most
important single line of history leading to the tip.  If that is
what you are doing, then the resulting shape of the history would
not be a tree (where branching is an important aspect, and both
sides of the branches are important) but a linear line (where you
ignore all side branches and concentrate only on the trunk of a
tree).  And I'd probably call each child that is on the "trunk" line
of the most important lineage "primary child" or something like
that.

> It also uses the level to sort the nodes: trying to keep
> descendent line (of a merge) together as a group.
>
> Add commandline option "--tree" to use this new feature.

In any case, if this is to sit next to and be friends with
"--topo-order", the option should be named as "--some-order".
The option name "--tree" (or "--blob", "--tag", or "--commit" for
that matter) is obviously unacceptable if the option is about
specifying how the commits in the "git log" output are ordered.

Having said that, if you are omitting commits that are not on the
primary lineage of the history, then this is not "--anything-order"
option, in which case it may want to sit next to and be friends with
"--first-parent", perhaps?  with the fuzzy description and
explanation above, I cannot quite guess the answer to this question
myself so I'll stop here.

> Signed-off-by: Micha Nelissen <nelissen.micha@gmail.com>
> ---
>  commit.c   | 136 +++++++++++++++++++++++++++++++++++++++++++++++------
>  commit.h   |   1 +
>  revision.c |   4 ++

Without clear explanation of what the change attempts to achieve in
docs and tests, there is no way to review to see if the new code is
correct.
