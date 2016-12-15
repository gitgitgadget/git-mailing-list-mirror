Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D16E1FF6D
	for <e@80x24.org>; Thu, 15 Dec 2016 22:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753923AbcLOWpV (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 17:45:21 -0500
Received: from pug.qqx.org ([50.116.43.67]:59312 "EHLO pug.qqx.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752602AbcLOWpU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 17:45:20 -0500
Received: by pug.qqx.org (Postfix, from userid 1000)
        id 5CABC1E42D; Thu, 15 Dec 2016 17:44:08 -0500 (EST)
Date:   Thu, 15 Dec 2016 17:44:08 -0500
From:   Aaron Schrab <aaron@schrab.com>
To:     Larry Minton <larry.minton@autodesk.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Is there a way to have local changes in a branch 'bake' while
 working in different branches?
Message-ID: <20161215224408.GE2023@pug.qqx.org>
Mail-Followup-To: Larry Minton <larry.minton@autodesk.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <14b481f95c5043aca6cdfddfe4728fa9@BLUPR79MB001.MGDADSK.autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14b481f95c5043aca6cdfddfe4728fa9@BLUPR79MB001.MGDADSK.autodesk.com>
User-Agent: Mutt/1.7.2+125 (g65b7094) (2016-11-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At 20:14 +0000 15 Dec 2016, Larry Minton <larry.minton@autodesk.com> wrote:
>Let's say I have a code change that I want to 'bake' for a while 
>locally, just to make sure some edge case doesn't pop up while I am 
>working on other things.  Is there any practical way of doing that?
>I could constantly merge that 'bake me' branch into other branches as I 
>work on them and then remove those changes from the branches before 
>sending them out for code review, but sooner or later pretty much 
>guaranteed to screw that up....

That sounds like the best way to me. How do you envision screwing it up?

If you anticipate messing up while removing the changes, that's only 
likely if there are conflicts and any other strategy is likely to be 
worse there.

If you suspect you'll forget to remove them before sending for code 
review there may be ways to help with that. Easiest you can add a large 
notice in the commit message(s) and/or comments; this may not prevent 
going for review but reviewers should catch it pretty quickly. To help 
prevent it even getting that far you may be able to add a pre-push hook 
to prevent such commits from being pushed to somewhere other than a 
private fork or a branch with a name that clearly indicates that it 
contains experimental code.
