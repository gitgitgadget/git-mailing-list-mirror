Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C77C202DD
	for <e@80x24.org>; Sun, 22 Oct 2017 14:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbdJVOPV (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Oct 2017 10:15:21 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:51616 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbdJVOPU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Oct 2017 10:15:20 -0400
Received: by mail-pg0-f54.google.com with SMTP id p9so9873041pgc.8
        for <git@vger.kernel.org>; Sun, 22 Oct 2017 07:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=LQ6kB/R7SolNJg4eUO6RQbpx/DMkRi2qhUY2cXoESa8=;
        b=kaQ3K33mCtNknnFObtWoz2sINzqQQIX0at3GTHRDd0J6+RkY9oDBm0zkxbaW13ZnNA
         Ua+PYvx4NDNNnpXwt4FwURJ16l2dP+nZ5cW/ZIHj2KS+o84rdxD9/hKGTASNsHwkvxrP
         nRzesOVQ6wYK8Rs84FNf71DYEPGdAVHIh5EsvZ8LHEjIU2BTM1vFB+RZN0aMn3SQGEPM
         6xFYNrgvTlGfFYlWveRrz94aN9wdytF2AsAs8XezOhL4s5Z8sp17PbhQ8EDOGgKHeXY7
         sCGS2GZfj2oeAhlznYT8OJs583Ab7Uac/NfVt9cJlEGqNviQgHOnnwMAaFY8hyqfwVak
         4DMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=LQ6kB/R7SolNJg4eUO6RQbpx/DMkRi2qhUY2cXoESa8=;
        b=eOvO3BWMQ5KSx2ncIgZQfyaSeumHSisY9KhHq30zCHx4gBw1YEoNL98fxqQmkYXfAN
         cXS0hXd3mQ0rHw4UigZvRKA/S+63yFvRquI6Ihk96GF5RnMnWFx6wEI12Pm+JVytXuS7
         WRjIXYk2RQMqmjSmLXomhNfCAl3yr+PHpEicEEakuvbcUap8EO9qebJOst0YrxTK69ud
         Ek51nNy5FdgaRFFEXqnr5CkE8KcClA+pzhimduRbTwb3hTXX3F0mk7sbz2q/VLs0Jp6z
         51DWeKNYP4kirEwkZrZsMvtKarp8AoZzFNP02U44K42lJVBm+s/ZIDXcXg2Sjj9w82bH
         kRCQ==
X-Gm-Message-State: AMCzsaUahJPADbkXlYN2uPTIZloZekkUNp5ZoEpynh1rGQtOEGwwH57b
        slMw2IcYefbV6yeHzV9wBVAtWx2+
X-Google-Smtp-Source: ABhQp+Sfu+hpkHNULinnrBbUEvU0AphXpEOhGTAtdtbELZI8KZxhZ7Bjz1q7PVvQOtYLcKMAft9Tng==
X-Received: by 10.98.233.21 with SMTP id j21mr10308704pfh.97.1508681719123;
        Sun, 22 Oct 2017 07:15:19 -0700 (PDT)
Received: from unique-pc ([14.102.72.147])
        by smtp.gmail.com with ESMTPSA id u9sm11771739pfa.40.2017.10.22.07.15.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Oct 2017 07:15:18 -0700 (PDT)
Message-ID: <1508681703.6715.12.camel@gmail.com>
Subject: Re: [RFE] Add minimal universal release management capabilities to
 GIT
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     nicolas.mailhot@laposte.net, Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
In-Reply-To: <1760206035.56692.1508594211365.JavaMail.zimbra@laposte.net>
References: <2089146798.216127.1508487262593.JavaMail.zimbra@laposte.net>
         <1290947539.4254.1508496039812.JavaMail.zimbra@laposte.net>
         <CAGZ79kYRq4OugvTfb2WNdk-M5DMAZC0JpJHqC1KSeJY2eNN1=Q@mail.gmail.com>
         <1760206035.56692.1508594211365.JavaMail.zimbra@laposte.net>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sun, 22 Oct 2017 19:45:03 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heads up, I'm gonna play the devil's advocate a little, here.

On Sat, 2017-10-21 at 15:56 +0200, nicolas.mailhot@laposte.net wrote:
> No that is not up to the hash function. First because hashes are too
> long to be manipulated by humans, and second no hash will ever
> capture human intent. You need an explicit human action to mark "I
> want others to use this particular state of my project because I am
> confident it is solid".
> 

I would say you're just limiting your thoughts. There's no strict rule
saying hash functions should be "incomprehensible" to humans or that
different hashes should be "uncomparable". No one's going to stop
someone from creating a hypothetical hash function that's totally
ordered (!) unless you violate the basis of a "hash". (surprise,
there's already attempts at it,

https://stackoverflow.com/q/28043857/5614968


)


> Except, the releasing happens outside git, it's still fairly manual. 

You seem to be more frustrated by "manual" work. I suspect why you
can't automate that. Given all the work done during a release of "Git",
(https://public-inbox.org/git/xmqqr2tygvp4.fsf@gitster.mtv.corp.google.
com/)
may be the maintainer could possibly give some good advise on this.

+cc Junio

> All I'm proposing is to integrate the basic functions in git to
> simplify the life of those projects and help smaller projects that
> want completely intergrated git workflows.
> 

Wait, aren't you just trying to make git more than a "version control
system"? I don't think it's encouraged a lot here given that there have
patches that have not been accepted because they might make git
opinionated and the result "doesn't quite fit into the broad picture of
a version control system"

cf. https://public-inbox.org/git/20170711233827.23486-1-sbeller@google.com/

cf. https://public-inbox.org/git/CAGZ79kYArf6R-vx1-Lm4X_ANLMrXc3VNd2aCQMnqq3J6y-s31Q@mail.gmail.com/


> Yes and it is so fun to herd hundreds of management tools with
> different conventions and quirks. About as much fun as managing
> dozens of scm before most projects settled on git. All commonalities
> need to migrate in the common git layer to simplify management and
> release id is the first of those.

It's better to have a "good" (generic) release management tool that
does what you ask (probably with some help from git) than try to turn
Git into one (which is not possible without making Git opinionated,
more on that later). I guess there should already be one that meets
your expectation and you probably just have to discover it.

Further, if there's no "generic" release management tool in existence,
I suspect that because there's no such thing a "generic release
management strategy" and it always depends on context (or) create one
on your own in the spirit of letting "git" handle just "version
control" and letting your "genereic" tool handle your concerns. Who
knows, if you have developed a good enough "generic" tool it might be
used widely for "release management" just as a lot of projects starting
using Git for "version control". (I still suspect that there should be
one that already exists)


> > git tags ?
> 
> Too loosely defined to be relied on by project-agnostic tools. That's
> what most tools won't ever try to use those. Anything you will define
> around tags as they stand is unlikely to work on the project of
> someone else
> 

They are loosely defined because you can't define them "tightly" and if
you try to it would make Git opinionated !?

> > > 5. a command, such as "git release", allow a human with control of the repo to set an explicit release version to a commit. 
> > 
> > This sounds fairly specific to an environment that you are in, maybe
> > write git-release for your environment and then open source it. The
> > world will love it (assuming they have the same environment and
> > needs).
> 
> If you take the time to look at it it is not specific, it is generic.
> 

I would say that you might haven't looked broadly enough.

1) If it's generic, why isn't there any "generic" release management
tool?

2) if it's possible to create a "generic" release management tool and
it just doesn't exist yet, why not try to create instead of trying to
integrate release management into Git ? (you could make it depend on
git, of course)

> You need to identify software during
> its whole lifecycle, and the id needs to start in the scm, because
> that's where the lifecycle starts.

It might not for everyone!

-- 
Kaartic
