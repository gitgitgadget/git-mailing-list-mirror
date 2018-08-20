Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DC741F954
	for <e@80x24.org>; Mon, 20 Aug 2018 09:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbeHTMwW (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 08:52:22 -0400
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:46703 "EHLO
        rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeHTMwW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 08:52:22 -0400
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 12333673A6
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 11:37:26 +0200 (CEST)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id 38B82673B0
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 11:37:25 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
        with Novell_GroupWise; Mon, 20 Aug 2018 11:37:25 +0200
Message-Id: <5B7A8BD3020000A10002CDE1@gwsmtp1.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.0.1 
Date:   Mon, 20 Aug 2018 11:37:23 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     "=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?=" <avarab@gmail.com>
Cc:     <peff@peff.net>, <git@vger.kernel.org>
Subject: Re: Antw: Re: non-smooth progress  indication for git fsck and
 git gc
References: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de>
 <20180816155714.GA22739@sigill.intra.peff.net>
 <87bma2qcba.fsf@evledraar.gmail.com>
 <20180816205556.GA8257@sigill.intra.peff.net>
 <5B7A7CDC020000A10002CDCF@gwsmtp1.uni-regensburg.de>
 <87woslpg9i.fsf@evledraar.gmail.com>
In-Reply-To: <87woslpg9i.fsf@evledraar.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Here are some stats from the repository. First the fast import ones (which had
good performance, but probably all cached, also):

% git fast-import <../git-stream
/usr/lib/git/git-fast-import statistics:
---------------------------------------------------------------------
Alloc'd objects:      55000
Total objects:        51959 (        56 duplicates                  )
      blobs  :        47991 (         0 duplicates          0 deltas of       
  0 attempts)
      trees  :         3946 (        56 duplicates        994 deltas of      
3929 attempts)
      commits:           22 (         0 duplicates          0 deltas of       
  0 attempts)
      tags   :            0 (         0 duplicates          0 deltas of       
  0 attempts)
Total branches:          15 (        15 loads     )
      marks:        1048576 (     48013 unique    )
      atoms:          43335
Memory total:          9611 KiB
       pools:          7033 KiB
     objects:          2578 KiB
---------------------------------------------------------------------
pack_report: getpagesize()            =       4096
pack_report: core.packedGitWindowSize = 1073741824
pack_report: core.packedGitLimit      = 8589934592
pack_report: pack_used_ctr            =       1780
pack_report: pack_mmap_calls          =         23
pack_report: pack_open_windows        =          1 /          1
pack_report: pack_mapped              =    2905751 /    2905751
---------------------------------------------------------------------

Then the output from git-sizer:

Processing blobs: 47991                        
Processing trees: 3946                        
Processing commits: 22                        
Matching commits to trees: 22                        
Processing annotated tags: 0                        
Processing references: 15                        
| Name                         | Value     | Level of concern               |
| ---------------------------- | --------- | ------------------------------ |
| Overall repository size      |           |                                |
| * Blobs                      |           |                                |
|   * Total size               |  13.7 GiB | *                              |
|                              |           |                                |
| Biggest objects              |           |                                |
| * Trees                      |           |                                |
|   * Maximum entries      [1] |  13.4 k   | *************                  |
| * Blobs                      |           |                                |
|   * Maximum size         [2] |   279 MiB | *****************************  |
|                              |           |                                |
| Biggest checkouts            |           |                                |
| * Maximum path depth     [3] |    10     | *                              |
| * Maximum path length    [3] |   130 B   | *                              |
| * Total size of files    [3] |  8.63 GiB | *********                      |

[1]  b701345cbd4317276568b9d9890fd77f38933bdc
(refs/heads/master:Resources/default/CIFP)
[2]  19f54c4a7595667329c1be23200234f0fe50ac56
(refs/heads/master:Resources/default/apt.dat)
[3]  b0e3d3a2b7f2504117408f13486c905a8eb8fb1e (refs/heads/master^{tree})

Some notes:
[1] is a directory with many short (typically < 1kB) text files
[2] is a very large text file with many changes
[3] Yes, some paths are long

Regards,
Ulrich


>>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> schrieb am 20.08.2018 um 10:57
in
Nachricht <87woslpg9i.fsf@evledraar.gmail.com>:

> On Mon, Aug 20 2018, Ulrich Windl wrote:
> 
>>>>> Jeff King <peff@peff.net> schrieb am 16.08.2018 um 22:55 in Nachricht
>> <20180816205556.GA8257@sigill.intra.peff.net>:
>>> On Thu, Aug 16, 2018 at 10:35:53PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>>
>>>> This is all interesting, but I think unrelated to what Ulrich is talking
>>>> about. Quote:
>>>>
>>>>     Between the two phases of "git fsck" (checking directories and
>>>>     checking objects) there was a break of several seconds where no
>>>>     progress was indicated
>>>>
>>>> I.e. it's not about the pause you get with your testcase (which is
>>>> certainly another issue) but the break between the two progress bars.
>>>
>>> I think he's talking about both. What I said responds to this:
>>
>> Hi guys!
>>
>> Yes, I was wondering what git does between the two visible phases, and 
> between
>> the lines I was suggesting another progress message between those phases.
At
>> least the maximum unspecific three-dot-message "Thinking..." could be 
> displayed
>> ;-) Of course anything more appropriate would be welcome.
>> Also that message should only be displayed if it's foreseeable that the
>> operation will take significant time. In my case (I just repeated it a few
>> minutes ago) the delay is significant (at least 10 seconds). As noted 
> earlier I
>> was hoping to capture the timing in a screencast, but it seems all the 
> delays
>> were just optimized away in the recording.
>>
>>>
>>>> >> During "git gc" the writing objects phase did not update for some
>>>> >> seconds, but then the percentage counter jumped like from 15% to 42%.
>>>
>>> But yeah, I missed that the fsck thing was specifically about a break
>>> between two meters. That's a separate problem, but also worth
>>> discussing (and hopefully much easier to address).
>>>
>>>> If you fsck this repository it'll take around (on my spinning rust
>>>> server) 30 seconds between 100% of "Checking object directories" before
>>>> you get any output from "Checking objects".
>>>>
>>>> The breakdown of that is (this is from approximate eyeballing):
>>>>
>>>>  * We spend 1-3 seconds just on this:
>>>>
>>>
>> 
>
https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/pack

>>
>>> -check.c#L181
>>>
>>> OK, so that's checking the sha1 over the .idx file. We could put a meter
>>> on that. I wouldn't expect it to generally be all that slow outside of
>>> pathological cases, since it scales with the number of objects (and 1s
>>> is our minimum update anyway, so that might be OK as-is). Your case has
>>> 13M objects, which is quite large.
>>
>> Sometimes an oldish CPU could bring performance surprises, maybe. Anyway
my
>> CPU is question is an AMD Phenom2 quad-core with 3.2GHz nominal, and there

> is a
>> classic spinning disk with 5400RPM built in...
>>
>>>
>>>>  * We spend the majority of the ~30s on this:
>>>>
>>>
>> 
>
https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/pack

>>
>>> -check.c#L70-L79
>>>
>>> This is hashing the actual packfile. This is potentially quite long,
>>> especially if you have a ton of big objects.
>>
>> That seems to apply. BTW: Is there a way go get some repository statistics
>> like a histogram of object sizes (or whatever that might be useful to help
>> making decisions)?
> 
> The git-sizer program is really helpful in this regard:
> https://github.com/github/git-sizer 
> 
>>>
>>> I wonder if we need to do this as a separate step anyway, though. Our
>>> verification is based on index-pack these days, which means it's going
>>> to walk over the whole content as part of the "Indexing objects" step to
>>> expand base objects and mark deltas for later. Could we feed this hash
>>> as part of that walk over the data? It's not going to save us 30s, but
>>> it's likely to be more efficient. And it would fold the effort naturally
>>> into the existing progress meter.
>>>
>>>>  * Wes spend another 3-5 seconds on this QSORT:
>>>>
>>>
>> 
>
https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/pack

>>
>>> -check.c#L105
>>>
>>> That's a tough one. I'm not sure how we'd count it (how many compares we
>>> do?). And each item is doing so little work that hitting the progress
>>> code may make things noticeably slower.
>>
>> If it's sorting, maybe add some code like (wild guess):
>>
>> if (objects_to_sort > magic_number)
>>    message("Sorting something...");
> 
> I think a good solution to these cases is to just introduce something to
> the progress.c mode where it learns how to display a counter where we
> don't know what the end-state will be. Something like your proposed
> magic_number can just be covered under the more general case where we
> don't show the progress bar unless it's been 1 second (which I believe
> is the default).
> 
>>>
>>> Again, your case is pretty big. Just based on the number of objects,
>>> linux.git should be 1.5-2.5 seconds on your machine for the same
>>> operation. Which I think may be small enough to ignore (or even just
>>> print a generic before/after). It's really the 30s packfile hash that's
>>> making the whole thing so terrible.
>>>
>>> -Peff



