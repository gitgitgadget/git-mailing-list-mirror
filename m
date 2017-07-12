Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C06C202AC
	for <e@80x24.org>; Wed, 12 Jul 2017 10:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755996AbdGLKy1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 06:54:27 -0400
Received: from 5.itsy.de ([188.40.84.14]:52671 "EHLO 5.itsy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754528AbdGLKy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 06:54:27 -0400
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Jul 2017 06:54:26 EDT
Received: from [192.168.0.13] (84-72-0-73.dclient.hispeed.ch [84.72.0.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 5.itsy.de (Postfix) with ESMTPSA id 17A60648FF
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 12:47:53 +0200 (CEST)
To:     Git Mailing List <git@vger.kernel.org>
From:   Joachim Durchholz <jo@durchholz.org>
Subject: Mirroring for offline use - best practices?
Message-ID: <81052ff7-cece-400d-1742-e13693fae7e3@durchholz.org>
Date:   Wed, 12 Jul 2017 12:47:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I'm pretty sure this is a FAQ, but articles I found on the Internet were 
either mere "recipes" (i.e. tell you how, but don't explain why), or 
bogged down in so many details that I was never sure how to proceed from 
there.


Basic situation:

There's a master repository (Github or corporate or whatever), and I 
want to set up a local mirror so that I can create clones without having 
to access the original upstream.
I'd like to set the mirror up so that creating a clone from it will 
automatically set up things to "just work": I.e. branches will track the 
mirror, not upstream, possibly other settings that I'm not aware of.

I gather that local clones are fast because hardlinked - is that correct?
Is that correct on Windows? (I can't easily avoid Windows.)


Ramification 1:

I'm not sure how best to prepare patches for push-to-upstream.
Is there value in collecting them locally into a push-to-upstream repo, 
or is it better to just push from each local clone individually?


Ramification 2:

Some of the repos I work with use submodules. Sometimes they use 
submodules that I'm not aware of. Or a submodule was used historically, 
and git bisect breaks/misbehaves because it can't get the submodule in 
offline mode.
Is there a way to get these, without writing a script that recurses 
through all versions of .gitmodules?
I'm seeing the --recurse-submodules option for git fetch, so this might 
(or might not) be the Right Thing.


Any thoughts welcome, thanks!

Regards,
Jo
