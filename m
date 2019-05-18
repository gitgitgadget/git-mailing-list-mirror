Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FFEE1F461
	for <e@80x24.org>; Sat, 18 May 2019 14:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbfEROUB (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 10:20:01 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:54183 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbfEROUA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 10:20:00 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id S0Bphnt6CnuQZS0BphBvKF; Sat, 18 May 2019 15:19:58 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8 a=C4ZTNOegAAAA:8 a=uPZiAMpXAAAA:8
 a=NMk6ksuxAAAA:8 a=9Zogh2hgYnDS0eR-pSgA:9 a=QEXdDO2ut3YA:10 a=Pjr4c87q344A:10
 a=xts0dhWdiJbonKbuqhAr:22 a=QUyOV983BqSepzLwJgEI:22 a=vGKdl4Vj01jYTOVaZSaR:22
Subject: Re: Feedback on git-restore
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Poughon Victor <Victor.Poughon@cnes.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <3E55146A6A81B44A9CB69CAB65908CEA6B91353C@TW-MBX-P01.cnesnet.ad.cnes.fr>
 <20190515103031.GA29149@ash> <xmqq7ear5egz.fsf@gitster-ct.c.googlers.com>
 <d8fd0d06-ec83-941f-c29f-2fea0efb6fd3@iee.org>
 <CACsJy8D16A3VKdTFfVyENZoH4J7Dv-3iwovEgsUj07KUT8NBKA@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <3f2a846e-ac69-c2c9-fd1b-0781f71d32ed@iee.org>
Date:   Sat, 18 May 2019 15:19:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8D16A3VKdTFfVyENZoH4J7Dv-3iwovEgsUj07KUT8NBKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfKmP8SuQfYsIgmJzsilgAHlwF9yuxtJ9pfegbCCWxB9uwK0LvlCXGF80LQIp4qfF/b3ACWArd6vxS47MmGH9zyZC8PWsmSLKBVB+2rafUAEe4i07e4Dj
 PggqYtVwiNIs6XqPNE+Ge0IER4ETFn9hGlcNjUOFJlf1ZM4lwp4IlI11FqOwUw6Cy1ONaIu7N4vjINGKxL7CgC3m+YSecmsTvBo7QjxUSoZqGZb9OnWBJb8Y
 A1AprpLlpRJO5dE81ZxInEHYsNrY0joCagWlx1peEEc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On 16/05/2019 13:44, Duy Nguyen wrote:
> On Thu, May 16, 2019 at 7:12 PM Philip Oakley <philipoakley@iee.org> wrote:
>> Maybe we need a `git index` command to make it far more visible to
>> average users (or `git staging-area --show`, with a --cached option ;-).
> Not commenting on the other parts (and also Junio's mail) since I
> still need more time to process.
>
> But how about we see the index as a "commit-in-progress" (or "staging
> area" which is almost the same, maybe "commit area" is better)?
I'd agree.

My initial comment was more about the cognitive disconnect between 
Victor's original reply where he has the commit and the file system as 
the (only) firm reference points, and then your reply, which makes the 
case that the _Index_ is central.

It was that disconnect that I wanted to highlight, which is at a level 
above the discussion on just the restore command.

There was a lot of discussion a year or three back about the terminology 
of cache/Index/staging for this middle area. It probably wasn't resolved 
fully as it only discussed the name, rather than why the concept wasn't 
well understood, and what was needed to fix _that_.
>
> You can't make a commit visible unless you check it out (and then can
> use various tools available to work on filesystem), or you use git
> diff/show to examine it. The index is treated pretty much the same
> way, except that it does not have a proper SHA-1 yet because it's
> still a work in progress.
I'd say most users feel happy about the fixedness of their last commit, 
and probably feel happy with the ability to view it via various tools 
(especially if pushed to their GitHub/Lab/Bucket repo). The apparently 
transient nature of the index is part of its Achilles heel. We talk too 
easily about 'blowing it away' [1].  Such phrases reinforce the user 
belief that they should treat it as a bit of a swamp area.

We don't have an index_log of the changes to the staging tree, as files 
are added or removed. That view implies that the index is simply the 
current work-in-progress (wip) tree, and doesn't contain anything else..
>
> Short of creating a fuse filesystem to show you the index content (as
> read-only files) I don't see any better way that you can actually see
> the index without checking it out.
Surely? the 'git status' command [1] is, in a way, trying to be that 
view, but we just haven't told the users
>
> PS. Yes I ignored the role of the index during a merge conflict. Not
> relying on the index for conflict handling might be possible, but I'm
> not going to touch that topic, way out of my area.
The role during merges would be part of that missing conceptual 
structure. Our documentation is doing a little too much of the 'ignore 
what's behind the curtain' [2]. I've certainly fallen for that often. 
The need for various web explanations e.g. [3,4] also suggest we could 
be more assertive in our top level user documentation about 'index is 
one of the most important data structures in git'.

In summary, I think the problem that Victor alludes to is at a higher 
level with respect to how we document what the staging area / index is 
and does.

Philip

[1] e.g. https://shafiul.github.io//gitbook/1_the_git_index.html
[2] Wizard of Oz, Powerful concept, vs loose tools.
[3] 
https://stackoverflow.com/questions/4084921/what-does-the-git-index-contain-exactly,
[4] https://mincong-h.github.io/2018/04/28/git-index/
