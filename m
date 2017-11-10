Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF1DA1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 18:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753486AbdKJS22 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 13:28:28 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:46046 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751142AbdKJS21 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 13:28:27 -0500
Received: by mail-io0-f170.google.com with SMTP id q81so3724609ioi.2
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 10:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vWrIAmgKmryR7+ArbUM0VvgR4YxfdFCXvyZPhMWrhSg=;
        b=nKp2duQGt41ldHa+UUku2Q3GXgupwwQi4+MszUW0n8nWxaSMeA4xbtBbeGQYalF9Of
         bekz0kKtT+Tpw4STQrzmD+R/mtOjlOIz5y5tapKFSaZH5czWCmqgkDSioeO8HLItJHdd
         784eaafKu0vm8KKH2rlB9lMynN6CNM6oVbuh1u9sPxIlKL5U1NSXPlPtwALUyK7ACdYa
         6sKXxuMnGR6Ibgn83ITt3vkCDm74VVuwS2dKeEh0kd3Le5GNbuI9QThigArLvA4agWlz
         bLHhzNb2zkxoAfkg1sTIciQoZOjkHTtDEnazQu5A7l3rOg24k/qZajvg2x0V/qMrMQIz
         Rkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vWrIAmgKmryR7+ArbUM0VvgR4YxfdFCXvyZPhMWrhSg=;
        b=tNGRHER0jrAuG/tDuOqFTWEnhG+Qgj8LlRi7eq3eghRysXamMDfFF9tUvKQ9UoJ5o8
         bel4g5UtIucOSsphB39BRi0TJSLbduqHKO/LAiMV6YCAzWHpU6kcR9tIPrRJpz0rtUQn
         PXFjrIq09mLX1njAptGcM2BhWFFJt0MdhVs3VkCqIHs07CAeSFHMMEpvcHC7aIEW0ck7
         eIhfcFitJWERMZhKtG4eeV9If7OZKPT/5hPgm0Fkg3De5v4dMYrUn/2jJPwnmrI9+W1H
         wfQ3I8BFrGfWXeAtvKvWWQUpHzMhg/aB+W+YwvMJPj5607yMDyG1ahXPqB1OGQblPFWD
         chqQ==
X-Gm-Message-State: AJaThX4E9D99iYXHyNWioqN4zB/+KT8vPdRuKriLjf5kAkxLpkl+fvdr
        Cs2WI1tsohj8JaTB2eD7nix6Wg==
X-Google-Smtp-Source: AGs4zMZe/EyYmTHBxgG+W28XBoYv7GzEdJ3nWNOMJ3g6KuakeZbwdQrhkrOEe605Khr8iJgZppqPxw==
X-Received: by 10.107.6.140 with SMTP id f12mr1414804ioi.4.1510338506390;
        Fri, 10 Nov 2017 10:28:26 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:b965:842e:5afa:853e])
        by smtp.gmail.com with ESMTPSA id a29sm1195407itj.8.2017.11.10.10.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Nov 2017 10:28:25 -0800 (PST)
Date:   Fri, 10 Nov 2017 10:28:25 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] cover-at-tip
Message-Id: <20171110102825.ae7ccb37a13c5904d252faa1@google.com>
In-Reply-To: <e1d3ab5b-82e6-8490-8f2e-00c1359c6deb@suse.de>
References: <357e8afb-4814-c950-1530-530bb6dd5f5a@suse.de>
        <e1d3ab5b-82e6-8490-8f2e-00c1359c6deb@suse.de>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 10 Nov 2017 16:37:49 +0100
Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de> wrote:

> > Hi,
> >
> > I'm starting to look into the cover-at-tip topic that I found in the leftover bits (http://www.spinics.net/lists/git/msg259573.html)

Thanks - I personally would find this very useful.

> > Here's a first draft of a patch that adds support for format-patch --cover-at-tip. It compiles and works in my nice and user firnedly test case.
> > Just wanted to make sure I was going roughly in the right direction here.
> >
> >
> > I was wondering where is the right place to put a commit_is_cover_at_tip() as the test will be needed in other place as the feature is extended to git am/merge/pull.

I think you can put this in (root)/commit.c, especially since that test
operates on a "struct commit *".

> > Feel free to comment. I know the help is not clear at this point and there's still some work to do on option handling (add a config option, probably have --cover-at-tip imply --cover-letter, etc) and
> > some testing :)

Both are good ideas. You should probably use a
--cover-letter={no,auto,yes} instead of the current boolean, so that the
config can use the same options and configuring it to "auto" (to use a
cover letter if the tip is empty and singly-parented, and not to use a
cover letter otherwise) is meaningful.

> The proposed patch for format-patch does not output any "---" to signal the end of the commit log and the begining of the patch in the cover letter.
> This means that the log summary, the diffstat and the git footer ( --\n<git version>) is seen as part of the commit log. Which is just wrong.
> 
> Removing them would solve the issue but I feel they bring some useful info (or they would not be here).
> Adding a "---" between the commit log and those added infos poses another problem: git am does not see an empty patch anymore.
> I would need to add "some" level of parsing to am.c to make sure the patch content is just garbage and that there are no actual hunks for that.

Could you just take the message from the commit and put that in the
cover letter? The summary and diffstat do normally have useful info, but
if the commit is specifically made to be used only for the cover letter,
I think that is no longer true.
