Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D4F01F731
	for <e@80x24.org>; Fri,  9 Aug 2019 18:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfHIS7B (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 14:59:01 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:12522 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfHIS7B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 14:59:01 -0400
X-Greylist: delayed 3464 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Aug 2019 14:58:59 EDT
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1hw9CU-0008Jg-6v; Fri, 09 Aug 2019 19:01:14 +0100
Subject: Re: $> git branch splat response considered harmful
To:     Emily Shaffer <emilyshaffer@google.com>,
        Bryan Turner <bturner@atlassian.com>
Cc:     jim.cromie@gmail.com, Git Users <git@vger.kernel.org>
References: <CAJfuBxx5R28cjUj1v+mB4J+uUpbTMWnYowrCc=iOAbOcqWX-_w@mail.gmail.com>
 <CAGyf7-FUsfKpr+HzOpS9TqE+x7GTnsVKki94gXzMVRwnnweC9g@mail.gmail.com>
 <CAJoAoZ=K0LhCmnEUk1rsan2J5APzcye7+RryjBG+mKgjGf6qzA@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <5f533351-3d77-3859-fe27-b3d96b0b8b30@iee.email>
Date:   Fri, 9 Aug 2019 19:01:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJoAoZ=K0LhCmnEUk1rsan2J5APzcye7+RryjBG+mKgjGf6qzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08/2019 22:28, Emily Shaffer wrote:
> On Thu, Aug 8, 2019 at 2:20 PM Bryan Turner <bturner@atlassian.com> wrote:
>> On Thu, Aug 8, 2019 at 2:08 PM <jim.cromie@gmail.com> wrote:
>>> fwiw,
>>>
>>> jimc@frodo:~/prj-1/capnproto.git$ git branch -l
>>> * master
>>>
>>> I find the splat in the response unhelpful
>>> when wrapped in shell for loop, the splat expands into everything in
>>> current directory
>>>
>>> jimc@frodo:~/prj-1/capnproto.git$ for b in `git branch -l`; do echo $b; done
>>> appveyor.yml
>>> c++
>>> CMakeLists.txt
>>> CONTRIBUTORS
>>> ...
>>>
>>> it would be nice if some flag combo would suppress that splat.
>>> save me from fugly brittle sh $IFS fiddlery and incomplete workarounds
>> Have you tried "git for-each-ref --format="%(refname:short)"
>> refs/heads/"? That's going to provide short names for branches without
>> any indicator for the default branch, and without any special
>> ordering.
> More generally, I think you should take a look at `git help git` and
> check out the difference between "porcelain" and "plumbing" commands.
> The former, of which `git branch` is one, are intended for interactive
> use and not really meant for scripting or piping. You can usually come
> up with an equivalent from the plumbing commands, which Bryan has
> suggested for you with `git for-each-ref`.  Git project tries very
> hard to maintain output format of the plumbing commands so as to not
> break folks' scripts, but such promises aren't usually made for
> porcelain commands.
>
I think this (the broad Q&A) also suggests that the porcelain command 
documentation could be more helpful for pointing to the appropriate 
plumbing commands for these scripting issues (and it could reduce list 
noise..).
--
Philip
