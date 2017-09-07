Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6702120286
	for <e@80x24.org>; Thu,  7 Sep 2017 17:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbdIGRnV (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 13:43:21 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:33519 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbdIGRnU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 13:43:20 -0400
Received: by mail-yw0-f176.google.com with SMTP id s62so1279034ywg.0
        for <git@vger.kernel.org>; Thu, 07 Sep 2017 10:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OUiOknQ+680MBfBxbgQNGvR88YkaJxY5aenj5T7UWuQ=;
        b=QtiCl4C8ZwQoAgdyK0vDpSXufVnJzpThn7xUCQwJDHhRfMwpFEHfviQpdC40RuWRHL
         qnC+xFIpNvZ52g68lOOICa2mgjMSVpidHG5Ab6buj+SmFC7PPk18xXwMZQYy5ZMMK7Js
         lI7ljajc9bJ3PvqUL4ycIOkmyspjO4q7+De9mWOdGebxFwzedwBgVmby9G+ET62+/KYg
         CX14MNBzG9uORXAh/Y0w6ScEZvYp6UF+TirnBqlYx0ItP4qRN/+OFi9/bW89o67vKixR
         LUcNhMFGlG+T/F6LBM+ZXt2ndaRF3fKUiafOVBvxMnLPhynTP6fQ8xCyS85cR8r9i9ek
         jKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OUiOknQ+680MBfBxbgQNGvR88YkaJxY5aenj5T7UWuQ=;
        b=okQv9+YjJE9lHrvfffLIvgduqNgEm+ICJLd32baVKDUEp3CPJ5qj8Z/FPjFrmBW6rY
         V99LUHIhoUjc91Gl57sPSXctXch+ulICuGpRGwcg/6qxfIqfZ8hnB8REIrHOUzS2yAS0
         nrofIHvWKKExNBVoicFgHIuQKFlEBOCdVALo11o/ly4/aXH6e8uUhT9syvyymcO0a3iX
         rt9zOQtnSa+Ksbft7epveJg0VDefFEJcSAyVp7ZQPCwa4sdu52keASe4J8toCFuUEL/N
         TOO6zq34kHG6p+yPraqZfjAVPoBr+EweAtBkHW5rj4sJfMFhzQts0EfgWZEKzkq8v5bw
         lavg==
X-Gm-Message-State: AHPjjUilIinjqUarHPQCOpk+Kha3xNZQSI2ZMcIL97yxdbmddN71AqGc
        Y2SE/Y6bjz5cNsoUrAOw+WSYTXoTvFRhckaK+Q==
X-Google-Smtp-Source: AOwi7QAHcFgXw6jeHbF3tJ0j/bMMp4jO67EUWzu3AaUgmGWDOqWWZNaessQTLn7eXGCeVZjuSOp+ikw6Sslp+Y9Egv0=
X-Received: by 10.37.244.69 with SMTP id p5mr63095ybe.353.1504806199545; Thu,
 07 Sep 2017 10:43:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.116.7 with HTTP; Thu, 7 Sep 2017 10:43:19 -0700 (PDT)
In-Reply-To: <20170907091133.zygswf3f6z2bedfo@weakknees.security.iitk.ac.in>
References: <20170906093913.21485-1-root@shikherverma.com> <CAGZ79kbxDh11KxrKCk_VjmN06kzp7x4iVO6XTV=a-qBmm39K5A@mail.gmail.com>
 <20170907091133.zygswf3f6z2bedfo@weakknees.security.iitk.ac.in>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 7 Sep 2017 10:43:19 -0700
Message-ID: <CAGZ79kZO_u21JeAsNq7p7X88i0wmP6kJcg=JbKp62Bxdm4d4Uw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Add named reference to latest push cert
To:     Shikher Verma <root@shikherverma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Santiago Torres <santiago@nyu.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 7, 2017 at 2:11 AM, Shikher Verma <root@shikherverma.com> wrote:
> On Wed, Sep 06, 2017 at 02:31:49PM -0700, Stefan Beller wrote:
>> On Wed, Sep 6, 2017 at 2:39 AM, Shikher Verma <root@shikherverma.com> wrote:
>> > Currently, git only stores push certificates if there is a receive hook
>> > present. This may violate the principle of least surprise (e.g., I
>> > pushed with --signed, and I don't see anything in upstream).
>> > Additionally, push certificates could be more versatile if they are not
>> > tightly bound to git hooks. Finally, it would be useful to verify the
>> > signed pushes at later points of time with ease.
>> >
>> > A named ref is added for ease of access/tooling around push
>> > certificates. If the last push was signed, ref/PUSH_CERT stores the
>> > ref of the latest push cert otherwise it is empty.
>> >
>> > Sending patches as RFC since the documentation would have to be
>> > updated and git gc might have to be patched to not garbage collect
>> > the latest push certificate.
>> >
>> > This patch applies on master (3ec7d702a)
>>
>> What are performance implications for busy repositories at busy hosts?
>> (think kernel.org / github) They may want to disable this new feature
>> for performance reasons or because they don't want to clutter the
>> object store. So at least a config option to turn it off would be useful.
>
> Any typical git push would write several objects to disk,

(or just one pack file, [which may be renamed eventually, see 722ff7f8])

> this patch
> would only add one more object per push so I think the performance
> penalty is not that high. But I agree that we can have a config to turn
> it off.

I personally do not run a high performance server, so I do not terribly mind,
but thought it would be nice for them to have at least an option ready made
instead of a potential performance regression.

>> On the ref to store the push certs:
>> (a) Currently the ref points at the blob, I wonder if we'd rather want to
>> point at a commit? (Then we can build up a history of
>> push certs, instead of relying on the reflog to show all
>> push certs. Also the gc issue might be easier to solve using this)
>
> I am not sure how that would work. The ref points at the blob of push
> certificate. Since each push can update multiple refs, each push
> certificate can point to mutiple commits (tip of the updated refs).
> Also if the named ref points at the commit then how will we get the
> corresponding push certificate?
>
> I did think about keeping a history of push certificates but the problem
> is new pushes can delete refs and commits which were pointed to by
> previous push certificates. This makes it really difficult to decide
> which push certificates to keep and which to gc. Also this history would
> be different for different clones of the same repo. Since push
> certificate are only meta data of the git workflow I think its best to
> just keep the latest push certificate and gc the old ones. People can
> use the recieve hook if they want to do advance things like logging a
> history of push certificates. I think git should provide a builtin
> solution for the simple case.

What I had in mind was what would be achieved with a
hook like this (untested):

    #!/bin/sh
    if test -z GIT_PUSH_CERT ; then
        exit 0
    fi

    # add a new worktree 'tmp', checking out the magic ref:
    git worktree add tmp refs/PUSH_CERT

    cp $GIT_PUSH_CERT tmp/cert
    git -C tmp add cert
    git -C tmp commit -m "new push cert"
    # maybe include GIT_PUSH_CERT_[NONCE_]STATUS
    # in commit message?

    # clean up, command doesn't exist yet:
    git worktree delete tmp

This would not deal with concurrency as it re-uses the
same worktree, but illustrates what I had in mind
for the git history of that special ref.
