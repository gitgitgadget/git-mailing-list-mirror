Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 190F31FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 19:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932645AbdBPTTu (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 14:19:50 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35646 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932465AbdBPTTu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 14:19:50 -0500
Received: by mail-pg0-f68.google.com with SMTP id y6so1615593pgy.2
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 11:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dIVSG2tOBLAeLKZZI2nU4Xkc5qj7epKqRoVbvJess4k=;
        b=XNX+I2u6pLEGoO65s9GUJdLnoDT6X+jR3UVz3naJ8MfjCnSWUvQLWjz19D/wnUhi00
         JObZfr9X8Ypp2hS7AfmhmlCJoi2Q5NrbtbWrSK1e/VmBf2O7kMgdTJaZ4aqUiwI0egBW
         lrxP6qHPwXgTxceixCWWk4I5x4B+G0Qiv9/jrv89De5m01Ym5h0mOvVddeecPeIRZX/R
         cZcGd84ZaYA5Be0IfcR2YygozVdJto0cJK3RouyWMfSMRmqFhhsc4LDrYNRdb450bQII
         M5WaDdhcS9/lh+nwGTQVw34NRybLPiqnr9M6RGkDyLgYuY8NwqHcw3/M69GcUK5h1p7x
         2frA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dIVSG2tOBLAeLKZZI2nU4Xkc5qj7epKqRoVbvJess4k=;
        b=jRRSxBcMUYD8u3VozTyzvSVXoFrKdvVFrSHAbUdQlklxJlnpVngBOcO01EAT/NX6DB
         xviJegtpAnYDbvc2/YYnyh73+Lk5JZLDgJLWU3w/q+g6Tmcy54n7wRp8KLBAfiiVKH96
         CMQMOeAkhek7vnxyGr/NhxD+mX/kfq6ybVGtUv93GF2fAQQC1umVKsj9K4+m1rx2UIAu
         uYC4Jp5H0e5bBH6/vvyjyhtar2zwuHDjgkULOFmXQC98VzqeOMfQICFekpbf4kYBxiQd
         tuD3sx+rieV+7YwIJe2j0P+8dburb7hOTbi2O9HsvNBjpT+UHh8FnVQFAuh0n1jigKHZ
         BVgg==
X-Gm-Message-State: AMke39nwij454NUL4NmyGyVbR2SvxKm5P9IYOD3dkX56hcbfGgh1LMMMzrgRdRttgozn5g==
X-Received: by 10.98.95.70 with SMTP id t67mr4456156pfb.37.1487272789160;
        Thu, 16 Feb 2017 11:19:49 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:9476:4c5c:6ee4:ba3])
        by smtp.gmail.com with ESMTPSA id r78sm15087697pfl.63.2017.02.16.11.19.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 11:19:48 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3] reset: add an example of how to split a commit into two
References: <20170216002212.31088-1-jacob.e.keller@intel.com>
Date:   Thu, 16 Feb 2017 11:19:47 -0800
In-Reply-To: <20170216002212.31088-1-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Wed, 15 Feb 2017 16:22:12 -0800")
Message-ID: <xmqq4lzux7sc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> The interdiff between v2 and v3 is not really worth showing since I
> basically re-wrote the entire section a bit.

Could this be made into an incremental, now that v2 has been in
'next' for about 10 days, please?

> +Split a commit apart into a sequence of commits::
> ++
> +Suppose that you have create lots of logically separate changes and commit them

s/create/&d/; s/commit/&ed/

> +together. Then, later you decide that it might be better to have each logical
> +chunk associated with its own commit. You can use git reset to rewind history
> +without changing the contents of your local files, and then successively use
> +git add -p to interactively select which hunks to include into each commit,
> +using git commit -c to pre-populate the commit message.
> ++
> +------------
> +$ git reset -N HEAD^                        <1>
> +$ git add -p                                <2>
> +$ git diff --cached                         <3>
> +$ git commit -c HEAD@{1}                    <4>
> +...                                         <5>
> +$ git add ...                               <6>
> +$ git diff --cached                         <7>
> +$ git commit ...                            <8>
> +------------
> ++
> +<1> First, reset the history back one commit so that we remove the original
> +    commit, but leave the working tree with all the changes. The -N ensures
> +    that any new files added with HEAD are still marked so that git add -p
> +    will find them.
> +<2> Next, we interactively select diff hunks to add using the git add -p
> +    facility. This will ask you about each diff hunk in sequence and you can
> +    use simple commands such as "yes, include this", "No don't include this"
> +    or even the very powerful "edit" facility.
> +<3> Once satisfied with the hunks you want to include, you should verify what
> +    has been prepared for the first commit by using git diff --cached. This
> +    shows all the changes that have been moved into the index and are about
> +    to be committed.
> +<4> Next, commit the changes stored in the index. The -c option specifies to
> +    pre-populate the commit message from the original message that you started
> +    with in the first commit. This is helpful to avoid retyping it. The HEAD@{1}
> +    is a special notation for the commit that HEAD used to be at prior to the
> +    original reset commit (1 change ago). See linkgit:git-reflog[1] for more
> +    details. You may also use any other valid commit reference.
> +<5> You can repeat steps 2-4 multiple times to break the original code into
> +    any number of commits.
> +<6> Now you've split out many of the changes into their own commits, and might
> +    no longer use the patch mode of git add, in order to select all remaining
> +    uncommitted changes.
> +<7> Once again, check to verify that you've included what you want to. You may
> +    also wish to verify that git diff doesn't show any remaining changes to be
> +    committed later.
> +<8> And finally create the final commit.
> +

Nicely done.  We could talk more "best practice" things in this
sequence (e.g. "'stash --keep' then test in isolation"), but it is
already sufficiently long, so extending it may hurt the readability
more than it helps by guiding the readers to better ways.

