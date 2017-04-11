Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EB3F209FA
	for <e@80x24.org>; Tue, 11 Apr 2017 16:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbdDKQdM (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 12:33:12 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36813 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751415AbdDKQdL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 12:33:11 -0400
Received: by mail-pg0-f51.google.com with SMTP id g2so1017700pge.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 09:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k4AdVzvjc0r2zOPWCyn+Dagez0y3rV1UbG3PjWfX2RQ=;
        b=sFaNu6cVMYtscZHWAtCxFFDcdp0K42NVSksmaUsioF/xctkOO2ItSHkQy34jJkbHjJ
         xIHm83zmoHo+Zttu0bHyqIGkhAviA3oi7ac4R0NC15x7UEm/Ql+JcIVDIyJ3T76LoPD8
         3jKnBqCUDgDyrLVnnrCabjz3AK4RmoBPX2EikLieaXm3QKKZiLsLxJsssrDfSmWSr85i
         43T673hPtOCAeRF4ulBO9DtN4Y+4F2h92FxMG/5saPmpnoiA3fChXtCmmXnR3+RENW0j
         R2WuekUoGYkx/V+OYRUicAoFvWbr2e58EapEP52/h9MspZRBB+q9kIyHEJvHKRqPnNZ3
         hdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k4AdVzvjc0r2zOPWCyn+Dagez0y3rV1UbG3PjWfX2RQ=;
        b=aVmVSWIWWd+XhLv+iJA8yEn6Nho6MdB/kdtHSL+Ps+69Q8q5jDrX/neOtkZjf0qFGF
         5+Odj/tjWH0XrUE+h32jkZ5QlJ9J2MEPwYkJYGbZ/sRWqAPbaPYQ28tSbjYLNYefn/Mz
         Dua/n7EiLOx3/eknQwKGaeSr5yjXtVaYx+VQjBrOcikQpbfdacgfZ3AQuHHVh5hPGVM9
         5AANhHNsTZmQWXU4/VOKnqWjd4JRH/B/zmQifX1be8k2RyQ1OPy2RoF0r6t03ysBfUgT
         PbpeyyBBfyDY43LQimQHEajSEeKt7wwG1fZKIdrIAqKa3kFg+7vb3iy7H97biMzHyDS7
         fABQ==
X-Gm-Message-State: AN3rC/7Vz8lo7N6NH/vUpJN04DIm1MwPKe5qOLL/VROIC+v5Y9Pi8Gf2GPsGJ393a4mMKFSp
X-Received: by 10.84.236.74 with SMTP id h10mr12169823pln.91.1491928389952;
        Tue, 11 Apr 2017 09:33:09 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:9591:6d62:26a:6d59])
        by smtp.gmail.com with ESMTPSA id o7sm31615636pga.36.2017.04.11.09.33.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 09:33:09 -0700 (PDT)
Date:   Tue, 11 Apr 2017 09:33:07 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v3 0/5] propagating push-options, remote and refspec
Message-ID: <20170411163307.GB36152@google.com>
References: <20170331235623.166408-1-bmwill@google.com>
 <20170405174719.1297-1-bmwill@google.com>
 <xmqqr30zqtgb.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr30zqtgb.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/11, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > v3 builds upon v2 by adding 3 additional patches to add functionality to also
> > propagate the remote and refspec down to children process's working to push
> > submodules.  The remote and refspec will only be propagated if the provided
> > remote is configured. A remote provided in the form of a URL will cause the
> > remote and refspec to not be propagated down to the submodules and instead the
> > default remote and refspec will be used, preserving existing functionality.
> > Currently the only supported LHS of a refspec must exactly match a single ref
> > in the submodule (e.g. a branch name).
> >
> > Patches [1/5] and [2/5] remain unchanged from v2.
> 
> 2/5 seems to be a bit different in 5545 ll.156,+6, though.

Oh, oops you're right.  Looks like I forgot that I added a single line
to a test in 2/5:

  git -C parent/workbench remote add up ../../upstream &&

Which just configures a remote in one of the submodules.  I must have
added that to prep for the propagating of the remote/refspec in later
patches.

> >
> > Brandon Williams (5):
> >   push: unmark a local variable as static
> >   push: propagate push-options with --recurse-submodules
> >   remote: expose parse_push_refspec function
> >   submodule--helper: add push-check subcommand
> >   push: propagate remote and refspec with --recurse-submodules
> >
> >  builtin/push.c                 |  5 +--
> >  builtin/submodule--helper.c    | 45 +++++++++++++++++++++++++
> >  remote.c                       |  2 +-
> >  remote.h                       |  1 +
> >  submodule.c                    | 74 +++++++++++++++++++++++++++++++++++++++---
> >  submodule.h                    |  5 ++-
> >  t/t5531-deep-submodule-push.sh | 52 +++++++++++++++++++++++++++++
> >  t/t5545-push-options.sh        | 40 +++++++++++++++++++++++
> >  transport.c                    |  4 ++-
> >  9 files changed, 219 insertions(+), 9 deletions(-)

-- 
Brandon Williams
