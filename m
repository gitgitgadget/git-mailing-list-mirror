Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0A9C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 19:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E36F613E0
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 19:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhDTTaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 15:30:22 -0400
Received: from elephants.elehost.com ([216.66.27.132]:60903 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhDTTaW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 15:30:22 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 13KJTdXH050311
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Apr 2021 15:29:40 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Emily Shaffer'" <emilyshaffer@google.com>, <git@vger.kernel.org>,
        <avarab@gmail.com>, <jrnieder@gmail.com>, <albertcui@google.com>,
        <gitster@pobox.com>, <matheus.bernardino@usp.br>
References: <YHofmWcIAidkvJiD@google.com> <YH1+C47AErrCUkHI@pug.qqx.org> <YH8iTDNZpsoCu+lx@google.com>
In-Reply-To: <YH8iTDNZpsoCu+lx@google.com>
Subject: RE: RFC/Discussion - Submodule UX Improvements
Date:   Tue, 20 Apr 2021 15:29:34 -0400
Message-ID: <019c01d7361b$82344700$869cd500$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJbFLMgoJsVHqAp1Cmec2AAO4rv5QM8HZW4Alaz8bKpiXW2UA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 20, 2021 2:50 PM, Emily Shaffer wrote:
> On Mon, Apr 19, 2021 at 08:56:43AM -0400, Aaron Schrab wrote:
> >
> > At 16:36 -0700 16 Apr 2021, Emily Shaffer <emilyshaffer@google.com>
> wrote:
> > > - git switch / git checkout
> >
> > (snip)
> >
> > > 4. A new branch with the same name is created on each submodule.
> > >  a. If there is a naming conflict, we could prompt the user to resolve
it, or
> > >     we could just check out the branch by that name and print a
warning to
> the
> > >     user with advice on how to solve it (cd submodule && git switch -c
> > >     different-branch-name HEAD@{1}). Maybe we could skip the
> warning/advice if
> > >     the tree is identical to the tree we would have used as the start
point
> > >     (that is, the user switched branches in the submodule, then said
"oh crap"
> > >     and went back and switched branches in the superproject).
> > >  b. Tracking info is set appropriately on each new branch to the
upstream of
> > >     the branch referenced by the parent of the new superproject
commit, OR
> to
> > >     the default branch's upstream.
> > > 5. The new branch is checked out on each of the submodules.
> >
> > In many cases the branch name for the superproject isn't going to be
> > appropriate for submodules.
> >
> > This seems likely to create a LOT of junk branches. Do you also have a
> > proposal for cleaning those up?
> 
> Yeah, I think we have a point internally for "clean up alllll the
submodule
> branches that are unreferenced/already merged". You're right that in a
> workflow where I have a superproject with eight submodules, because I need
> them to build, but only do active development on one submodule out of the
> eight, I'll have a ton of junk refs in the other seven submodules. Yuck :)

In fact, this yuck is a reason why many organizations have gone to
monolithic repositories instead of multiple smaller ones - because of the
touch points. However, the argument for using multiple smaller repos mirrors
this particular use case, so while "yuck", it might have value when
mirroring what happens in the issue tracking systems that have massive touch
points. We were there and moved to monolithic per product release group, but
when we had the other approach, this particular feature actually would have
helped a whole lot. I wonder whether this mess might have more value than we
think.

Regards,
Randall

-- Brief whoami:
NonStop developer since approximately 211288444200000000
UNIX developer since approximately 421664400
MVS not admitting to anything
-- In my real life, I talk too much.



