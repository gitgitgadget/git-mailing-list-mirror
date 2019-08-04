Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 608BF1F731
	for <e@80x24.org>; Sun,  4 Aug 2019 20:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfHDURc (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Aug 2019 16:17:32 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53785 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfHDURc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Aug 2019 16:17:32 -0400
X-Originating-IP: 157.49.172.246
Received: from localhost.localdomain (unknown [157.49.172.246])
        (Authenticated sender: me@yadavpratyush.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D24D960002;
        Sun,  4 Aug 2019 20:17:23 +0000 (UTC)
Subject: Re: [PATCH] git-gui: Perform rescan on window focus-in
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Mark Levedahl <mlevedahl@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20190728151726.9188-1-me@yadavpratyush.com>
 <20190728213634.GB162590@genre.crustytoothpaste.net>
 <e3f296a6-f33b-7b52-c4cb-9acf65145e64@yadavpratyush.com>
 <20190728224943.GC162590@genre.crustytoothpaste.net>
 <724fb243-c660-ae04-1b2f-caf34794b799@gmail.com>
 <005d7946-3fbf-9c06-21fb-51f10d06f33e@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1907312132190.21907@tvgsbejvaqbjf.bet>
 <cc5dddc7-e33e-2a2c-3205-6dd14edd0abd@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1908021414530.46@tvgsbejvaqbjf.bet>
 <a68f09be-949f-b16b-a585-9ca2a1991a4f@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1908032225510.46@tvgsbejvaqbjf.bet>
 <1489be05-ab18-a3e5-dd38-3d5729ebe67a@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1908042058340.46@tvgsbejvaqbjf.bet>
From:   Pratyush Yadav <me@yadavpratyush.com>
Message-ID: <ea3d442d-2bda-8c2a-0f75-c9b6e32c6816@yadavpratyush.com>
Date:   Mon, 5 Aug 2019 01:47:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1908042058340.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

I sense that I'm starting to test your patience. So first off, thanks 
for the advice you've given so far. It has been really valuable. Feel 
free to let me know if you don't want me to prod you further about this, 
and I'll stop :).

Also let me know if you don't want me to cc you in other git-gui patches 
I send.


On 8/5/19 12:40 AM, Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 4 Aug 2019, Pratyush Yadav wrote:
> 
>> On 8/4/19 2:04 AM, Johannes Schindelin wrote:
>>>
>>> On Sat, 3 Aug 2019, Pratyush Yadav wrote:
>>>
[...]
>>>
>>> You misunderstood what I was saying: a single setup is bad, and you
>>> can make it moderately better by testing _at least_ with a
>>> moderately-sized repository [*1*] in addition to git.git.
>>>
>>> So yes, it would still not be enough to test with, say, the git.git
>>> _and_ the Chromium repository _only_ on your setup, but if not even
>>> you can be bothered to test with more than one small repository, how
>>> can you possibly expect anybody else to add more testing?
>>
>> All right, I'll see what repos I can test.
>>
>> But my internet is pretty slow and unstable, so my clone of the
>> Chromium repo failed mid-way multiple times. I assume we need to test
>> on a large index, so is it all right if I use
>> t/perf/repos/many-files.sh to artificially generate a large repo?
> 
> Why do you ask me for permission to just try this? I feel very
> uncomfortable being put in such a position: I am not your manager or
> gate-keeper or anything.

I'm not a native speaker, so maybe I worded it incorrectly. What I meant 
by the question was not to ask permission, but to verify that this would 
be a good test for checking performance with a large repo.

So I'll rephrase the question:
Will using t/perf/repos/many-files.sh, instead of something like the 
Chromium repo, be a good enough test of performance of a rescan?

> 
>>>> [...]
>>>>> I wonder, however, whether you can think of a better method to
>>>>> figure out when to auto-refresh. Focus seems to be a low-hanging
>>>>> fruit, but as you noticed it is not very accurate. Maybe if you
>>>>> combine it with a timeout? Or maybe you can detect idle time in
>>>>> Tcl/Tk?
>>>>
>>>> Hm, I don't see a better alternative than file system watches.
>>>> Timeouts are a heuristic that can potentially be problematic.
>>>
>>> Let me stress the fact that I suggested a timeout _in addition_ to the
>>> focus event?
>>
>> Oh, my bad. I thought you suggested using timeouts exclusively.
>>
>> But I'm not sure I understand what you mean by "using timeouts in addition to
>> the focus event". My guess is that you mean we should activate a
>> refresh-on-focus-in only after git-gui has been out of focus for a certain
>> amount of time. Is my guess correct?
> 
> I am _not_ telling you what strategy you should use. You really need to
> come up with hypotheses about what tell-tales for committable outside
> changes could be easy to detect. This is your patch, and your project.

IDEs and some text editors like Atom use file system watches, and that's 
why I think they are a viable approach. But at the same time, these are 
also known to be kind of heavy-weight and slow, and I like git-gui for 
being fast and lightweight, so that might not be a good idea.

> 
> My suggestion about a time-out was to think a bit further than just mere
> Tk-provided events to detect whether the user might have changed
> anything outside of Git GUI that might make an automatic refresh
> convenient for the user.
> 
> I do _not_ want to engage in this project, it is not my pet peeve.
Understandable. We are all volunteers after all. Thanks for your help so 
far :)

> 
>>> Yes, using a timeout on its own is stupidly problematic. That's why I
>>> did not suggest that.
>>>
>>>> If you do a refresh too frequently, you hog up the user's resources
>>>> for little benefit.
>>>
>>> Indeed. You want to find a heuristic that catches most of the cases
>>> where files were changed, while at the same time not even _trying_ to
>>> refresh automatically when probably nothing changed.
>>
>> Like I said before, the best way of doing that that I can see is file system
>> watches.
> 
> That's not a heuristic.
> 
> A file system monitor is doing a lot of work in this case, for dubitable
> benefit.
> 
> Take for example git.git: Let's say that I run a specific test. It
> creates a directory under `t/`: the filesystem monitor triggers. It
> creates a repository in that directory: the filesystem monitor triggers
> _multiple times_. The test then performs all kinds of I/O, eventually
> removing the directory when all tests passed.

The monitor triggers multiple times, but we don't have to do a rescan 
every time. The callback for the trigger would just set a boolean that 
will decide whether a rescan has to be done the next time it comes back 
into focus.

> 
> Note that none of these filesystem changes correspond to anything that
> would update _anything in Git GUI during a refresh.
> 
> Of course, this is something I did not mention before because I took it
> for granted that you would always try to weigh the benefits of your
> approach to the worst possible unintended consequences.

Yes, the specific use case you mentioned would trigger an unnecessary 
refresh, but I don't think many people do these kinds of things very often.

Building the tree will generate a lot of IO, but we will only watch 
files tracked by git, so all that IO would not trigger a refresh at all.

I'm not saying file system watches are the best alternative here, I'm 
just saying it is a pretty good alternative, and the scenario you 
describe doesn't happen often enough to bother most people. One problem 
with them is, of course, added dependencies. And it's a big problem. I'd 
love to have a tcl-only alternative, but there is none at the moment.

I'll experiment with some file system watches, and see how they fare.

> 
>> But maybe we can get reasonable performance with a combination of
>> timeouts and focus events.
> 
> Please note that I would not be surprised if this heuristic _also_
> resulted in a lot of bad, unintended consequences. That's for you to
> find out.

Yes, of course. I was just thinking out loud.

> 
>>> Footnote *1*: I don't expect you to test with the largest repositories,
>>> as you are unlikely to have access to anything approaching the size of
>>> the largest Git repository on the planet:
>>> https://devblogs.microsoft.com/bharry/the-largest-git-repo-on-the-planet/
>>>
>>
>> Ah yes, I read about it a while back on Reddit. Having a huge monolithic repo
>> sounds backwards to me. Using submodules sounds like a better idea, but who am
>> I to judge. They probably have their reasons that I'm not aware of.
> 
> This statement just sounds to me as if you never have used submodules in
> any serious way. My experience is that software developers who tried to
> use submodules offer opinions that read very differently from that
> paragraph.

My last workplace had Linux, U-Boot, ARM Trusted Firmware, and a handful 
more projects under one repo with submodules. I don't remember having 
any problems, and hence why I thought it was a pretty decent idea.

> 
> Strong opinions usually do not survive contact with open-minded exposure
> to reality.

"but who am I to judge. They probably have their reasons that I'm not 
aware of."

I just put my first thoughts out about this, admitting I probably don't 
have the full picture. I see that as being open-minded.

-- 
Regards,
Pratyush Yadav
