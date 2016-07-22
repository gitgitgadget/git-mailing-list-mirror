Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C1D6203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 17:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbcGVRZu (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 13:25:50 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:36819 "EHLO
	mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbcGVRZo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 13:25:44 -0400
Received: by mail-it0-f51.google.com with SMTP id f6so41827184ith.1
        for <git@vger.kernel.org>; Fri, 22 Jul 2016 10:25:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1+vPpm1bl0wjfyd/oEI5gypAl+zT3U6bW+VbG2MLxYE=;
        b=JZnDJqsJUtb2AHV5bKsCEul41p0BwMTG2JixcEKtgYL/Zd82Yq/1bQn2K3NkRw+BYi
         PNeQvN0TToIc5g3RruEihYyR6EF3QVc92kNPouIA1mgrZxbF8pQbpSgb7qLsBZE4yvDv
         nnSuEO9uWjLgct3FYZVrMeuM+6mKAFsV5ITNCsU+zFIIqnRhPVu8P4j/Y8rwd2TKppZq
         HlboPro9nHtoOJa6K387ctGZ3juuD5zMx25gTAXmSspclGgU+rg3N3b8eZWRYbMe2M8l
         3YUslCVSCzs0csBvC0pTLGtd18sdtn5f/OFkb0g8bIZPVhPXRwDv7x5KrxA5r1lAjoOn
         0Upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1+vPpm1bl0wjfyd/oEI5gypAl+zT3U6bW+VbG2MLxYE=;
        b=k7D+/eQyHKk/Zxji9pBeZSsOF4tX+pjt6lpggz0VJ/v8fr0FIAL/p3lntDidIDb8ja
         2+RLB7F631hToUYU2nevYjbSyEzoDa246PEFlQXxZ7Iqj7SPqOAxlEjxeAOh098r6ZOV
         JxHsxdfCXgKy5sZiJ8CqRmJNHdPsK/2EOxLiJdil8MXUVkEG5adTutRIxGbMvVnU4jyv
         D/em6Z16o6czWvSkjwzbe/OGZGpTg4xPtDHxUv9vVCW4FTapEJryzs4GlKjmpDavTOGj
         fUzrGmq1fCCHcZgwwuGD9fJ9AvmEVvsItBnst/DiDjLx7zzcJz9HcPqdd881gQgs0I2n
         NmqA==
X-Gm-Message-State: ALyK8tK6I9Gq2k1NBvIfPNMCAM8qLWUsM4Ni4D99S5zfs7VKEhiKXOEbPSDlZqgmTRl+nLQ22x6Ywydi8yGy2JhD
X-Received: by 10.36.228.138 with SMTP id o132mr67568671ith.49.1469208343376;
 Fri, 22 Jul 2016 10:25:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 22 Jul 2016 10:25:42 -0700 (PDT)
In-Reply-To: <CACsJy8CSnmnzDMGpMvvkhWRfJvp1L+pfOZ=eYp5JF0GWNH6D0Q@mail.gmail.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com> <20160720172419.25473-4-pclouds@gmail.com>
 <CAGZ79kZB8U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com> <CACsJy8CSnmnzDMGpMvvkhWRfJvp1L+pfOZ=eYp5JF0GWNH6D0Q@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 22 Jul 2016 10:25:42 -0700
Message-ID: <CAGZ79ka-isR4DL7ZqOp8cXE1bmUOnd33yu=pZZHaqNmPWH3PYQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] submodule: support running in multiple worktree setup
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 22, 2016 at 10:09 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>
> I just quickly glanced through the rest of this mail because, as a
> submodule ignorant, it's just mumbo jumbo to me. But what I see here
> is, there may be problems if we choose to share some submodule info,
> but I haven't seen any good thing from sharing any submodule info at
> all.

Okay. :(

I assume the sharing is beneficial. (As a work-tree ignorant) I thought
we had this main work tree, which also holds the repository, whereas
the other working trees have a light weight implementation (e.g. just
a .git file pointing back to the main working tree/git dir).

So in a way my mental model is more like the config sharing here:
You can configure things in ~/.gitconfig for example that have effects
on more than one repo. Similarly you would want to configure things
in one repo, that has effect on more than one working tree?

And my assumption was to have the repository specific parts be shared,
whereas the working tree specific things should not be shared.

By working tree specific I strongly mean:

* existence in the working tree
* the checked out sha1
* submodule.$name.path

By repository specific I strongly mean:

* the submodule URL

I am not sure about:

* submodule.$name.update, submodule.$name.ignore,
   submodule.$name.branch,
  These have to be able to be different across working trees, but do we
  require them to be set for each working tree individually?  I thought a
  repo wide setup with defaults may be ok?

>
> I can imagine long term you may want to just clone a submodule repo
> once and share it across worktrees that use it, so maybe it's just me
> not seeing things and this may be a step towards that.

Just as Junio put it:
> I agree that when a top-level superproject has multiple worktrees
> these multiple worktrees may want to have the same submodule in
> different states, but I'd imagine that they want to share the same
> physical repository (i.e. $GIT_DIR/modules/$name of the primary
> worktree of the superproject)---is everybody involved in the
> discussion share this assumption?

I agree with that as well.

>
> Anyway, I assume some people will be working on the submodule side.

Once the discussion comes to a rough agreement, I'll give it a shot.

> And because I have not heard any bad thing about the new config
> design, I'm going to drop submodule patches from this series and focus
> on polishing config stuff.

Oh, sorry for not focusing on that part. The design of git config --worktree
is sound IMO.

> --
> Duy
