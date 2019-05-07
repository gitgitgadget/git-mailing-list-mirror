Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BECE81F45F
	for <e@80x24.org>; Tue,  7 May 2019 00:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfEGACJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 20:02:09 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:46025 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfEGACI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 20:02:08 -0400
Received: by mail-pg1-f181.google.com with SMTP id i21so7262119pgi.12
        for <git@vger.kernel.org>; Mon, 06 May 2019 17:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hZIkzlii/ncR7umLp2S9fEn8r2nGkoJ5LvquCVqtnmg=;
        b=MJ/qE0BtjWY+ZOOcyL2si9JEeYMRYxphBuCCEQpOC8zY6Ux9VmuRQ7akXIdlLdLzat
         f3Rn/eo7Ec3NPq8U1i8lxTF8xhhyfSKqvbCQ27+eCe6mfBTdTL28d8goNUd6qRanta8T
         gwpD5xDpi1EiohO7OYAS8biZ20BkUyiTjA23KdbXt5SeKCZf8ASz7USSj4jNL+s/LedB
         +eTqwRoi+Xv/xjvjF2iHxN0+0BV9pTBu3km4jea6lv5YvFthni4VTcx8c9YkItDgHXgL
         kxF1+MvXYM4w7cq4Zx3g0pT0SWkeuTGpCIacRVXy++mOYEzcgJvgufdQk+bLaF8D9Wtd
         kNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hZIkzlii/ncR7umLp2S9fEn8r2nGkoJ5LvquCVqtnmg=;
        b=Q9W6gFfp3mgcW9CYQjkEfHCpLl0UqHzdE7+Qqhb/bN2cMB+vzRii6h3+5aTfOqX/4q
         zyr5FFR/rCWKq7L6fSv4/3o7ewmLm8hZovA1e2gNj0IegKVpvy3RRXeyofm8VOylvV0b
         qX0JkCZMwWjsym2p4U2ZhEKldQPdIVaGsNxj+fMvWdU9MZB2HZAfap8HqCrINeoOjlVG
         lLqtPw5YpiaMU3F1/eovkNzxfw/IJDs/R1Aw6O5/c3/MXvRcxYyLIh9WMo77u4w9aTZB
         cRYpaNaQ7bDp239hv2TQZnULrDcLGsH6zpnr33aox4PJtDCnGECXx71sChcmT6ErbkyM
         I8Kg==
X-Gm-Message-State: APjAAAXaZ0UqgEBZL8Vkiq7QzlkMvSYaSb91aq3yRM89NSssJqxI2nAl
        y6QVuH65xrmqq2ivOOBag64=
X-Google-Smtp-Source: APXvYqwjLfRiKZsyTeCLb1Zf+E9ERJbnZj+yas+5hHZ3Gr3rvSaFapX3cbzhyYENieLDN6tbKtU+qQ==
X-Received: by 2002:aa7:8b12:: with SMTP id f18mr37171353pfd.178.1557187327612;
        Mon, 06 May 2019 17:02:07 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id t3sm12399747pgu.78.2019.05.06.17.02.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 17:02:06 -0700 (PDT)
Date:   Mon, 6 May 2019 17:02:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Matthew DeVore <matvore@comcast.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, matvore@google.com,
        git@vger.kernel.org
Subject: Re: Proposal: object negotiation for partial clones
Message-ID: <20190507000205.GC57368@google.com>
References: <CAMfpvhKYRVwTVNLfRJYcjhHtg=FNLNPbnw8xtY93nJu228v6=g@mail.gmail.com>
 <20190506192800.213716-1-jonathantanmy@google.com>
 <20190506194625.GB57368@google.com>
 <EA2BD2A8-2641-4B71-8439-66994DE9589F@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EA2BD2A8-2641-4B71-8439-66994DE9589F@comcast.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore wrote:
> On 2019/05/06, at 12:46, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Ah, interesting.  When this was discussed before, the proposal has been
>> that the client can say "have" anyway.  They don't have the commit and
>> all referenced objects, but they have the commit and a *promise* that
>> they can obtain all referenced objects, which is almost as good.
>> That's what "git fetch" currently implements.
>
> Doesn’t that mean the “have” may indicate that the client has the
> entire repository already, even though it’s only a partial clone? If
> so, then the client intends to ask for some tree plus trees and
> blobs 2-3 levels down deeper, how would the server distinguish
> between those objects the client *really* has and those that were
> just promised to them? Because the whole purpose of this
> hypothetical request is to get a bunch of promises fulfilled of
> which 0-99% are fulfilled already.

For blobs, the answer is simple: the server returns any object
explicitly named in a "want", even if the client already should have
it.

For trees, the current behavior is the same: if you declare that you
"have" everything, then if you "want" a tree with filter tree:2, you
only get that tree.  So here there's already room for improvement.

[...]
> Maybe something like this (conceptually based on original proposal) ?
>
> 1. Client sends request for an object or objects with an extra flag
> which means “I can’t really tell you what I already have since it’s
> a chaotic subset of the object database of the repo”
>
> 2. Server responds back with set of objects, represented by deltas
> if that is how the server has them on disk, along with a list of
> object-IDs needed in order to resolve the content of all the
> objects. These object-IDs can go several layers of deltas back, and
> they go back as far as it takes to get to an object stored in its
> entirety by the server.
>
> 3. Client responds back with another request (this time the extra
> flag sent from step 1 is not necessary) which has “want”s for every
> object the server named which the client already has.
>
> Very hand-wavey, but I think you see my idea.

The only downside I see is that the list of objects may itself be
large, and the server has to check reachability for each one.  But
maybe that's fine.

Perhaps after that initial response, instead of sending the list of
individual objects the client wants, it could send a list of relevant
objects it has (combined with the original set of "want"s).  That
could be a smaller request and it means less work for the server to
check each "want" for reachability.

What do you think?

[...]
> That's a very good point. The data the first request gives us is
> basically the tree objects minus file names and modes. So I think a
> better feature to implement would be combining of multiple filters.
> That way, the client can combine "tree:<some small number>" and
> "blob:none" and basically get an "enumeration" of available objects.

This might be simpler.

Combining filters would be useful for other uses, too.

Thanks,
Jonathan
