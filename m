Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BF4720281
	for <e@80x24.org>; Wed, 27 Sep 2017 00:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969322AbdI0AJe (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 20:09:34 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:54953 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967989AbdI0AJc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 20:09:32 -0400
Received: by mail-pg0-f51.google.com with SMTP id c137so6789265pga.11
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 17:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ixitUmnlrdP3IqJT+xSYwAolDYi6StUg47O82IYcz2w=;
        b=juf5UoxZYZmPMaKQV2F9qx6YhJkNTl4ziNzeKd94/Mnx1Os1+fpqNY4f9cduhSCL9o
         Fvo9g5pwohqebb2y3tMB+t9627lDGnHMtK5sX+5yvSYebZpgg3o+YL1DxrliC9dQaVSo
         TByeCOUB7f8VZdEQ5uW3B8XT3g+RdGi5xAg52uSU05VO+/e5r0pzvYRZPh44Xpi/dV5X
         eKvHeI6jrwR57iiZDg4SRZxwjQV9kN5yzf/OMepHQKT1eD49YApegj7gvU2Y9DoeRNkK
         gz4o+PmDP0JLUUyxNfG88mIgmoKPg3Jk++dkuOVxAcKU3u6wRjYfNGtI08Aw0BQ40n10
         4uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ixitUmnlrdP3IqJT+xSYwAolDYi6StUg47O82IYcz2w=;
        b=KAwvjpVzSAHK7eUlYj2j4zq4qmB+1raFZ1Dwy5Z6MM801+90lPrntou5ru2kpn7w8Q
         6AZKX7Cin5ivEUCqP79NFWWfhyaBqonvZXfL9iGWDlRZnGDnLTHrNhIoGt5olXUYW8Ly
         jrDy6cgs4mZ/eBZst/WWPAuwPkVFj/hO1kFmKAiQBN9IDIFRgEG22zInQsxXjAWSgcs1
         yd8W34Pq4Hyclyb3xxB+0WGSI4Wt6zY1XOmiZphbC64qataRKp3Hllgd9hEnKxic/g+K
         DPZUxar1VSudy4xcFPxozNsuZPWjw8UND0azztNjSyj/3sdOAP5dsnLdwk/yMDmwg7p+
         YSqA==
X-Gm-Message-State: AHPjjUiPSH8axp0cqBJPQocycbRFnoqgU7p0MjbxUcNg7mLui63US/Tk
        UtWrGa/uZ9Bcr1YFn2cr+nLJJ7ku
X-Google-Smtp-Source: AOwi7QCsxbIkiMBghuFSuxtP3xceZ/10gM8NLC/Q0bO/fhPgRlryzl3pazTouc1IfUy5dzBIvmBTGQ==
X-Received: by 10.99.173.67 with SMTP id y3mr12479029pgo.69.1506470972008;
        Tue, 26 Sep 2017 17:09:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a541:226f:6d4c:7f7a])
        by smtp.gmail.com with ESMTPSA id a1sm19475012pgu.47.2017.09.26.17.09.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 17:09:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: -s theirs use-case(s) Was: BUG: merge -s theirs  is not in effect
References: <20170925000213.rilmsczdbi3jqkta@hopa.kiewit.dartmouth.edu>
        <xmqqwp4nfuv1.fsf@gitster.mtv.corp.google.com>
        <20170925031751.lg7zk6krt65dxwas@hopa.kiewit.dartmouth.edu>
        <xmqqmv5je412.fsf_-_@gitster.mtv.corp.google.com>
        <20170925144021.vhbd3wb3uqejs5wq@hopa.kiewit.dartmouth.edu>
        <xmqqzi9iazrp.fsf@gitster.mtv.corp.google.com>
        <20170926133232.3yjasune6um4qw45@hopa.kiewit.dartmouth.edu>
Date:   Wed, 27 Sep 2017 09:09:30 +0900
In-Reply-To: <20170926133232.3yjasune6um4qw45@hopa.kiewit.dartmouth.edu>
        (Yaroslav Halchenko's message of "Tue, 26 Sep 2017 09:32:32 -0400")
Message-ID: <xmqqzi9h80jp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yaroslav Halchenko <yoh@onerussian.com> writes:

> and that is where the gotcha comes -- what if "my" changes were already
> published?  then I would like to avoid the rebase, and would -s theirs
> to choose "their" solution in favor of mine and be able to push so
> others could still "fast-forward" to the new state.
>
> So -- as to me it remains 'symmetric' ;)

I do not necessarily agree.  Once you decide that their history is
the mainline, you'd rather want to treat your line of development as
a side branch and make a merge in that direction, i.e. the first
parent of the resulting merge is a commit on their history and the
second parent is the last bad one of your history.  So you would end
up using "checkout their-history && merge -s ours your-history" to
keep the first-parenthood sensible.

And at that point, use of "-s ours" is no longer a workaround for
lack of "-s theirs".  It is a proper part of the desired semantics,
i.e. from the point of view of the surviving canonical history line,
you want to preserve what it did, nullifying what the other line of
history did.

So I still do not think the above scenario justifies "-s theirs".
