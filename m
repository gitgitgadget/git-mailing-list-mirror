Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4952207D6
	for <e@80x24.org>; Tue,  2 May 2017 04:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbdEBEEe (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 00:04:34 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33977 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbdEBEEd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 00:04:33 -0400
Received: by mail-pf0-f176.google.com with SMTP id e64so45613946pfd.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 21:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l1t+HjmLhXPPFtRRkE1gDKltR6D4rKbTLLrcPOi2dR8=;
        b=j1fKs1OSpvsg1Ox7Bx6DrE8Tlold91yvy8SmHDdagU+8I8LQ5PdaRddfK0YLWbRltN
         BiZMW9aM9Ui6aaU1sKLl2VDlP1oQRnLa9m5bDGtgOOJXT1Oc4rFZOY7VBgB6bver83vl
         Vwo0xu8aDy2nZLK0WW5yg677DEaayNVKmMe19/FITlqaT3NjAA1BEj/NmBsXH7SUCDOD
         jUNmCdoI37kINc/8UJtW748sOB6SfxMgHg07obT6GYTzg7pDBkn9O+nUpFTc7bTwgJ6X
         gau1dEPSaPECOJocqhGllwq6UBG/RhoxgejuqCwy5TWUTCvtToNtRZ4MEuTxS+/xMlfs
         WnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l1t+HjmLhXPPFtRRkE1gDKltR6D4rKbTLLrcPOi2dR8=;
        b=ROWEnWjNVA3048wiLhS+TXbAiWsxK+/7zYsOOdth3jZvqtoG1BrIzvCE1KitMVRTPl
         b9w16gX3tXwFdEn+e6l/YEGHbfLv6muqRuEthP0qYaZGQawTRxPZPKLJ5GMh/Kxrncqa
         WvKZtMUfzRcLIqKRAif9a1EqUNHbvauYjOeDW7kpbp5bUBiMcpNn8A3UyB9CAq+T01dx
         uJfHMG1S5dAoihc7IdEsPvmUeruLtin0fBRhL61lXXB9a/xAZKgBmX0LsrT0RI+aNFXG
         +xczxHOEYNJHu4yda0UhbgT0t41PXckQXKGWsjLXI6BY8lP3bHoDkJcuS7Oghj6pvRn/
         HSYg==
X-Gm-Message-State: AN3rC/7MRIYXxCl3ld7Vs0DYquhWUUWRSVmkB66eYdzswi8fpHCRwfMJ
        1Vyj0ATVu5TJp2Mb3U0USzJNV8TwOhfIcjU=
X-Received: by 10.99.95.14 with SMTP id t14mr15131368pgb.64.1493697872781;
 Mon, 01 May 2017 21:04:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.169.14 with HTTP; Mon, 1 May 2017 21:04:32 -0700 (PDT)
In-Reply-To: <xmqqbmrcf3cn.fsf@gitster.mtv.corp.google.com>
References: <20170501180058.8063-1-sbeller@google.com> <20170501182405.GG39135@google.com>
 <xmqqbmrcf3cn.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 1 May 2017 21:04:32 -0700
Message-ID: <CAGZ79kb52QDUG0RtTXNEEpMJR1CSMYMrRHTRRvGn0-cF=HnzWw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Some submodule bugfixes and "reattaching detached HEADs"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 1, 2017 at 6:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Williams <bmwill@google.com> writes:
>
>> I don't know why submodules were originally designed to be in a
>> detached HEAD state but I much prefer working on branches (as I'm sure
>> many other developers do) so the prospect of this becoming the norm is
>> exciting! :D
>
> The reason is because the superproject already records where the
> HEAD in the submodule should be, when any of its commits is checked
> out.  The tip of a branch (which one???)

The one as configured (submodule.NAME.branch

>  in a submodule may match
> that commit, in which case there is nothing gained by having you on
> that branch,

Being on a branch has some advantages, e.g. easier pushing, not
worrying about losing commits due to gc, an easier "name" in a literal sense.


>  or it may not match that commit, in which case it is
> unclear what should happen.

Yes, I anticipate this to be the main point of discussion.

>  Leaving your submodule on the branch
> would mean the state of your tree as a whole does not match what the
> checkout operation in the superproject wanted to create.  Resetting
> the branch would mean you may lose the history of the branch.

or telling the user via die(), that there is a mismatch.
(you may want to run git submodule update --remote to fix the situation)

> Thinking of the detached HEAD state as an implicit unnamed branch
> that matches the state the superproject checkout expects was
> conceptually one of the cleanest choices.

Assuming this is the cleanest design, we may want to change the
message of git-status, then.
Unlike the scary detached HEAD message (incl long hint), we may just
want to say

    $ git status
    In submodule 'foo'
    You're detached exactly as the superprojects wants you to be.
    Nothing to worry.



> But all of the above concentrates on what should happen immediately
> after you do a checkout in the superproject, and it would be OK for
> a sight-seer.  Once you want to work in the submodules to build on
> their histories, not being on a branch does become awkward.  For one
> thing, after you are done with the work in your submodule, you would
> want to update the superproject and make a commit that records the
> commit in the submodule, and then you would want to publish both the
> superproject and the submodule because both of them are now
> updated.  The commit in the superproject may be on the branch that
> is currently checked out, but we don't know what branch the commit
> in the submoudule should go.
>
> The submodule.<name>.branch configuration may be a good source to
> learn that piece of information,

Glad we agree up to this point.

> but it does not fully solve the
> issue.  It is OK for the tip of that branch to be at or behind the
> commit the superproject records, but it is unclear what should
> happen if the local tip of that branch is ahead of the commit in the
> superproject when checkout happens.

right. It is still unclear to me as well. I'll have to think about the
various modes of operation.

> By the way, how does this topic work with the various checkout modes
> that can be specified with submodule.<name>.update?

This series currently does not touch git-submodule, but in principle
we could just run "submodule--helper reattach-HEAD" after any operation
and then see if we can attach a HEAD (likely for "update=checkout",
but in  "merge" we may want to fast-forward the branch, and in "rebase"
we might want to reset (noff) to the tip.

I'll think about this more.
Thanks,
Stefan
