Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 845791F404
	for <e@80x24.org>; Fri, 16 Mar 2018 21:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbeCPVaL (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 17:30:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35931 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbeCPVaK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 17:30:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id n3so5512027wmd.1
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 14:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BSxPKwmobQsWkFQud0e8FGxW6NcpYuHiU5uCxeYUmXE=;
        b=smpto5/3x2pZYzby5hhUOs4+H38OWqJAVUv0Gx84d1c4Ubqg2uiL6p+N4N3wjiOmJX
         I7MMqIR+Sc6MqQbCJMEDscw8AHcvBtMFZgV4usMLm3LSZsrLk1rg7d/QB89XRhSZVecP
         GT+GM0SIstSEXxDQHNJZ0sS+Lb3oSLEykC6HOskwUCt12T/Lz7vk3mtHekDfZ92N/n1z
         4B2RTqfeZEr85cf1fMnIu4cDEHlL9ZzuhBCSuD9OWHXW72RKfSfzITwglWhJYxgJaU32
         PaLjQGpRyLDsGDRrReKH1g6NdLQCwSEkogwcUR0Sy8d5XKAKnNvK5fNutjgdixZFfrGN
         Rmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BSxPKwmobQsWkFQud0e8FGxW6NcpYuHiU5uCxeYUmXE=;
        b=V48c16eGqJJnKy+SLEmze8UskDiEl4n9K65w+CW8JBnblFhYJi9/tuhYbkxfR/5+RY
         64KtFKsPkCoPocZa1IGJhQyFi3SmJYz20w+oQ36X9AwcaXNQzRovHGh7JNQXOmNkMGlI
         QAVnuTMkGUPKfIuG1EfrUpHiP9raHnIAbmIcbXOj+av33vJ22MJpTipV4mUZVW8eQtKK
         qAjfCd+oO37REODB9o0VxRTqr6bjxcJFb3n6rSJntnHOh0ZhXtG+vIo6n60MCxDDtAJk
         2yCkPm7MMmISIUxEGNVxfDOKzfbidd0mg7tEkF0i0Yf21FBNdYWB6fkjcwvPqf5XnvK9
         u8zg==
X-Gm-Message-State: AElRT7HjvLv3yUcAoKhEXZjFR/JQSEzmn5WmfwhMGwUeJTDvrTd4+1w8
        T/A2HNG/7OiyyPvywvA25Ss=
X-Google-Smtp-Source: AG47ELvD6yZFdGkjujJ5DWoGgzM0ItKY8dFhwu39K/7gE1sYqK7ZfxLl709dto1ESMM1JIKy+RhhAQ==
X-Received: by 10.28.239.8 with SMTP id n8mr3064742wmh.120.1521235808899;
        Fri, 16 Mar 2018 14:30:08 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id a23sm9765637wra.3.2018.03.16.14.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 14:30:07 -0700 (PDT)
Date:   Fri, 16 Mar 2018 21:33:23 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eddy =?utf-8?B?UGV0cmnImW9y?= <eddy.petrisor@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH] git-submodule.sh:cmd_update: if submodule branch
 exists, fetch that instead of default
Message-ID: <20180316213323.GC2224@hank>
References: <1520366804-28233-1-git-send-email-eddy.petrisor@gmail.com>
 <20180306202149.GA160269@aiede.svl.corp.google.com>
 <CAK0XTWdY6rfKu_s8Am6dh9njcFHqSAz_54PhW6V09DuGwE-h0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK0XTWdY6rfKu_s8Am6dh9njcFHqSAz_54PhW6V09DuGwE-h0g@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/08, Eddy Petrișor wrote:
> 2018-03-06 22:21 GMT+02:00 Jonathan Nieder <jrnieder@gmail.com>:
> >
> > (cc list snipped)
> > Hi,
> >
> > Eddy Petrișor wrote:
> >
> > > Cc: [a lot of people]
> >
> > Can you say a little about how this cc list was created?  E.g. should
> > "git send-email" get a feature to warn about long cc lists?
> 
> 
> I did it as advised by the  documentation, git blame:
> 
> https://github.com/git/git/blob/master/Documentation/SubmittingPatches#L264
> 
> I was suprised that there is no specialized script that does this, as
> it is for the kernel or u-boot, so I ran first
> 
>     git log --pretty=format:'%an <%ae>' git-submodule.sh | sort -u >
> mail-list-submodule
> 
> then configure git to use that custom output and ignore the patch
> since it was trying to convert every line of it into a email address:
> 
>     git config sendemail.ccCmd 'cat mail-list-submodule # '
> 
> Then "git send-email 0001..." did the rest.

There's a 'git contacts' command which we've been carrying in
"contrib/" for a while.  Maybe we could advertise that in
"Documentation/SubmittingPatches" instead of 'git blame' and 'git
shortlog'?

Maybe something like the patch below?

--- >8 ---
Subject: [PATCH] SubmittingPatches: mention the git contacts command

Instead of just mentioning 'git blame' and 'git shortlog', which make
it harder than necessary for new contributors to pick out the
appropriate list of people to cc on their patch series, mention the
'git contacts' utility, which should make it much easier to get a
reasonable list of contacts for a change.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/SubmittingPatches | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index a1d0feca36..945f8edb46 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -260,8 +260,8 @@ that starts with `-----BEGIN PGP SIGNED MESSAGE-----`.  That is
 not a text/plain, it's something else.
 
 Send your patch with "To:" set to the mailing list, with "cc:" listing
-people who are involved in the area you are touching (the output from
-`git blame $path` and `git shortlog --no-merges $path` would help to
+people who are involved in the area you are touching (the `git
+contacts` command in `contrib/contacts/` can help to
 identify them), to solicit comments and reviews.
 
 :1: footnote:[The current maintainer: gitster@pobox.com]
-- 
2.16.2.804.g6dcf76e11

