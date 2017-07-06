Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C554202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 18:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbdGFSDi (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 14:03:38 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36375 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbdGFSDh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 14:03:37 -0400
Received: by mail-pg0-f45.google.com with SMTP id u62so4568690pgb.3
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 11:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HqCKSjsx3/gE0o05Qgnci43+jmIRfRDfyhg92v3ZSqY=;
        b=GNrqN/NF9ki0kj3Ha77Qm/968HvreaZ6Yodnzv1brLswkxtxU8Xb3Ky1U7dTMXfReJ
         9s3lns0SvHL8gVLmjekN6fcrA7S3hykFsCv2D3HLJx/UuliXULY3YyeLLZ9Gb9s+gdy5
         wC0YfeX1DDQ8h1hIlX+gcvEcsE06HaxBg5P51k5yMztIWROHDmOx2wXaqKE2+v/QZrJQ
         SdoR32rbSH6eiQEk4mEwRhoY9agS96Q7I0czV6wnevmwJhnIlbKzLMEWFPrZ0pbEwY62
         2SIpvVVFmxF0PfJfyWyPXLynBmc96Ka+dZUc/ZIeIMfRGXXzYhkzhmBW4oo4Ps7QfUvE
         VItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HqCKSjsx3/gE0o05Qgnci43+jmIRfRDfyhg92v3ZSqY=;
        b=Iu/6/QZfywozsAt7euVmFGfrfxOzZNwnGq83k6JTIit7lfOsZ2R6MTsvckLMUnF6GE
         CJGRZMzCVVj9IFx6/cCv0PdbHHZf2/r6Ffq87zvxXTSBpszqc8rXBF1uSEH5ebVCqwNw
         FP81CSuzwG4IiY53Hh7lIioPg7pZO4Fdmv91vhRaJeA8BXo81tEli8ORG0aFWN5K9ffR
         hYtrxQG+ufxL1F2Gfcn1cVIkadyqOknyLpqSnHWgK2C2zmTLQ6KLuVYlIx/Q3hH1Cqdu
         weZj26xijbdWPjqJBlM9uB3VLfBcND5/2k+gJEyp4bwUNBPEC2YNDa3i0glas5l98yf4
         orkg==
X-Gm-Message-State: AIVw112m0ymVIn2NQO6ts45reSURrsABL1ExSMqZ4pauIRZaCp5ks26I
        t45nI+c7GIsCvg==
X-Received: by 10.84.170.67 with SMTP id i61mr30460377plb.114.1499364216869;
        Thu, 06 Jul 2017 11:03:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f878:6796:f790:dc38])
        by smtp.gmail.com with ESMTPSA id h90sm1610152pfh.133.2017.07.06.11.03.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 06 Jul 2017 11:03:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Lewis <utoddl@email.unc.edu>
Cc:     git@vger.kernel.org
Subject: Re: bug report: dates on diff
References: <b28bc109-b06f-0acf-960b-0b6761b0ee38@email.unc.edu>
        <xmqqo9sxfscp.fsf@gitster.mtv.corp.google.com>
        <53f97d43-6984-6a46-bde2-a8cf64e7bb9e@email.unc.edu>
Date:   Thu, 06 Jul 2017 11:03:35 -0700
In-Reply-To: <53f97d43-6984-6a46-bde2-a8cf64e7bb9e@email.unc.edu> (Todd
        Lewis's message of "Thu, 6 Jul 2017 13:32:02 -0400")
Message-ID: <xmqqbmoxfnns.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Lewis <utoddl@email.unc.edu> writes:

> Trying not to sound snide, but, what's the point of "--date=" on commits if you
> can't use it later? Granted, things always seem harder until you understand how
> the work. Thanks again.

You do not sound snide at all, at least to me ;-)

Imagine this scenario:

 - Contributor A writes a change on 2017-07-01 and send it in to me
 - Contributor B writes a change on 2017-07-03 and send it in to me
 - I apply change from B on 2017-07-04 on 'master'
 - I apply change from A on 2017-07-05 on 'master'
 - You clone the resulting repository from me on 2017-07-06

Now, you have at the tip of 'master' in your repository the commit
that records the change by contributor A.

And there are three times that are relevant to your tip of 'master'.

 - When was the commit that sits at the tip of 'master' made?
 - When was the change recorded in that commit made?
 - When was the commit made at the tip of _your_ 'master'?

and the answers are 2017-07-01, 2017-07-05 and 2017-07-06, respectively.
They are called "committer", "author" and "reflog" timestamps.

The 'master@{<time>}' syntax is about the reflog timestamp.  It
never looks at the former two.  In general whenever you see <ref>@{...},
that is talking about the information that is stored in "reflog",
the record of when and in what order the <ref> in _your_ repository
pointed at various objects.

The "commit --date=<time>" is about tweaking the "author" timestamp
the commit records.  It does not affect the "committer" timestamp.
By definition (of what "reflog" is), it will not affect the reflog
timestamp, because the reflog timestamp for a particular commit
would be different across repositories.  I had A's commit on _my_
master on 2017-07-05, but the time you had it on _your_ master was
not until 2017-07-06.

I think the best way to do this properly would be to extend the
"<ref>^{...}" syntax so that we can say e.g.

    git show "master^{#author-time > 2017-01-01}"

to mean "traverse from the tip of 'master' and find the first commit
that satisfies the given expression, "author-time > 2017-01-01", i.e.
has author timestamp that is later than the specified date.  Which
would be in line with the existing

    git show "master^{/my commit message}"

that means "traverse from the tip of 'master' and find the first
commit that has 'my commit message' in the log message".

Note that "git log --since=<time> --until=<time> master" would be
the thing that is closest to what you would want that already
exists, but that limits by the "committer" timestamp.  You _could_
lie about both author and committer timestamp when building the
backdated history and use this mechanism, but we have author and
committer timestamps that are distinct for a reason, so it is a
rather poor workaround.


