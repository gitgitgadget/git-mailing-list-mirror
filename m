Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73B201F859
	for <e@80x24.org>; Thu, 25 Aug 2016 17:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753884AbcHYRrZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 13:47:25 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:36240 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbcHYRrY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 13:47:24 -0400
Received: by mail-it0-f53.google.com with SMTP id e63so286102329ith.1
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 10:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0y+myMf7B14ZMuiQDWq0HVqhUN8x86j3aVXflLMe124=;
        b=oXrNN2CxBNdt1/Oqczu070VsnoGQgkhX9fa8rbs11UUEL9HqWXS/u23Lj/mJPVBRRL
         8Fciy6KwiZLb9ZkjyeXOW90jEVVbFJDTMrTWpykh5eyWSov5sM/KsBz2nO7FcTBR7GNA
         Hr+7PK9XfmHD6z6wrU4PwPKJ27JjnSq0DuIu6aKm7vaNXIFioWu8M6xgvwW1DiGQFHTG
         wNB/D75zufsL7tgH3++fsbCCM69cWSmo6uy4/bXDEIGOEwRscx8yt+iTflJJEYIEr5Dt
         gWOxa6vw9f71Gntneai9Tmj/lIc0/fsgfrXODoKpfqz/emUib/1U2OCUh6waGi/UmYpQ
         pYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0y+myMf7B14ZMuiQDWq0HVqhUN8x86j3aVXflLMe124=;
        b=M6dc/Z3JFuJJgh4zvTheq/bTCDbiAt8SkBDmAzH5ILt4dBG5j+q/25/gZ7A9LdsFnA
         l3/j9GjpqzPpTeIHWw1gTQN3NFrpE5TNZT1DEC8pYUI83YQ71Pl0UtGwyIq6TIJjZTD8
         WKO1RSvAcp/trxGSc1NsWABwuZ7auX/zhymBCh5ybX46sCp8xEwiEvEcLfrBmpqMjK7I
         W/Ijsn4SpVe6fydzvbT9tt+ZlGwy69tZtCR/21YRh6szmqH8Vtyts/LIW0q4iTuviTMY
         UBdGLwFe4s3Og0BmYcj/5Q6d5Ooe915wZoF6ZW6R8k9XE/LnSsJw5RWjepdzne8L6kbw
         A0EA==
X-Gm-Message-State: AE9vXwMzfiGcCI0vzu+xaNucYf+B3CrNvkb4f2FohbWLJXHSKrvqcQToCPmXmaWu/yJAPczcrqE1WgfdC9hpramy
X-Received: by 10.36.189.76 with SMTP id x73mr6153574ite.97.1472147160244;
 Thu, 25 Aug 2016 10:46:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 25 Aug 2016 10:45:59 -0700 (PDT)
In-Reply-To: <7B5AD16B-9729-453E-839C-2A2FDB07F8E9@student.ethz.ch>
References: <7B5AD16B-9729-453E-839C-2A2FDB07F8E9@student.ethz.ch>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 25 Aug 2016 10:45:59 -0700
Message-ID: <CAGZ79kbHfofmowHnwzFrumc1XJHE=ZMQEwNSeOSyF7YDG+aSjw@mail.gmail.com>
Subject: Re: Feature Request: Branch-Aware Submodules
To:     Hedges Alexander <ahedges@student.ethz.ch>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc Jacob and Lars who work with submodules as well.

On Thu, Aug 25, 2016 at 2:00 AM, Hedges  Alexander
<ahedges@student.ethz.ch> wrote:
>
> Right now updating a submodule in a topic branch and merging it into master
> will not change the submodule index in master leading to at least two commit
> for the same change (one in any active branch). This happened to me quite a few
> times. To a newcomer this behavior is confusing and it leads to unnecessary
> commits.

So you roughly do

    git checkout -b new-topic
    # change the submodule to point at the latest upstream version:
    git submodule update --remote <submodule-path>
    git commit -a -m "update submodule"
    git checkout master
    git merge new-topic
    # here seems to be your point of critic?
    # now the submodule pointer would still point to the latest
upstream version?

>
>
> The proposed change would be to have a submodule either ignored or tracked by
> the .gitmodules file.
> If it is ignored, as for instance after a clone of the superproject, git simply
> ignores all files in the submodule directory. The content of the gitmodules
> file is then also not updated by git.
> If it is not ignored, the .gitmodules is updated every time a commit happens in
> the submodule.

So

    git -C <submodule-path> commit

should trigger a commit in the superproject as well, that changes the gitmodules
file? What do you record in the git modules file that needs updating?
As the version is tracked via the gitlink entry, I do not see the
information that
needs tracking here?

> On branch switches the revision shown in the gitmodules from
> that branch is checked out.

So you are proposing to put the revision into the gitmodules file?
That would be redundant with the actual gitlink entry in your tree.
(as shown via `git submodule status`)
What would happen if the recorded revision in the gitmodules file and the
gitlink are out of sync?

Oh, are you just proposing to actually make `git checkout` aware of the
submodules? See[1]. I would welcome such a change and be happy th

[1] https://github.com/jlehmann/git-submod-enhancements
which has some attempts for checkout including the submodules.
I also tried writing some patches which integrate checking out submodules
via checkout as well. A quicker `solution` would be a config option that
just runs `git submodule update` after each checkout/pull etc.


> This change would have submodules conceptually behave more like files to the
> superproject.
>
>
> Like current behavior, git status would display whether the submodule has
> uncommitted changes or is at a new commit.

See config options diff.submodule and status.submoduleSummary.


>
> I couldn't find any discussions on the initial implementation of git-submodule
> or any previous proposals related to this in nature due to gmane being down
> right now and the mailing list archives on the other sites are not great for
> searching. So please excuse me if I'm bringing up already discussed stuff.

https://public-inbox.org/git for reading on the web, or

    git clone https://public-inbox.org/git

for reading offline.

>
> Until now I only worked on projects with few submodules. I expect the
> proposed changes to have a larger effect on projects containing lots of
> submodules. So it would be nice if maybe somebody with experience working on
> projects with lots of submodules could weigh into the discussion.
>
