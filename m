Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D2651F935
	for <e@80x24.org>; Wed, 21 Sep 2016 13:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757345AbcIUNSC (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 09:18:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34873 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754822AbcIUNSB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 09:18:01 -0400
Received: by mail-wm0-f68.google.com with SMTP id 133so8565075wmq.2
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 06:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=dNIfVlrfoSafZYDjrlhkvpEJbs3+9vC8mVUqtf1hL5o=;
        b=uPLsx8ElMV4nrg6TqjEt3jtGpGJMKoGv8xa+CZWe8VL16Z3U7kAg4l8vWN0A5G9EgK
         7O+UwuEOPtPr920jVhxLs6B88sPAz9XJ39UMRmxBPvYIw1h0aWg0fOtBESwF45Gn8wAc
         bxB3rn4E0mIWul8ocBZprPTxHiTKmz1GDQ+6ysEUHtgbqlrx3kRXKgztDVPWXzAQPoD1
         uvafbD/Im0hGTf/bJ7KQ8CPEoir23i/OEv0whN2mAK4srRZ8A1iYtNPTLYLh9wWfAVWX
         A0TKILlSDdUJZQqDNRol6JCFXtNTZBgS1fn1Rj9XbJsPD337Xfs8TkXyi5GXv1Vja2i+
         97uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=dNIfVlrfoSafZYDjrlhkvpEJbs3+9vC8mVUqtf1hL5o=;
        b=BvENu+LsyFrRowQlJW3JUS+5XCp+DS5Zb74pZI4tbSi8SJLEz5iwG+Xwga1zXee5vI
         /bGTUuTI6fgxfbVVo4aKW/eF8O/6vZQWONej1QIoN1jB2b/Q0avKZDLMAMNE4/baGmYo
         VQ9rMbPZ4S60phZdB2Qqz4uyZNnlAei+bQly6g5Y8cvtWPEY1T6bdAxG5z1N/a9PjQYP
         HtbHXziBiwY5LgiI5wfmCPA/OmS7ere/0iQZZmMInZ6mIXWW975ATDGvkUFFel7wZiaE
         LGitFuLSd02JPO6kuuS11a+Oqkm3ydt47XP+OT47wJd4GTvwZ+9lJF5wAVjUC2TmUxhb
         6HNw==
X-Gm-Message-State: AE9vXwPKoQCDCXaKni8ar0zewx/HsUkvZ7gbXrJBETCtxA2UTcxzf+bMkfKF0X4xKovqJQ==
X-Received: by 10.194.21.200 with SMTP id x8mr33349992wje.129.1474463874880;
        Wed, 21 Sep 2016 06:17:54 -0700 (PDT)
Received: from [192.168.1.26] (enn40.neoplus.adsl.tpnet.pl. [83.20.3.40])
        by smtp.googlemail.com with ESMTPSA id q142sm32500821wmd.4.2016.09.21.06.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Sep 2016 06:17:53 -0700 (PDT)
Subject: Re: Git garden shears, was Re: [PATCH 13/22] sequencer: remember the
 onelines when parsing the todo file
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <12bffd6ca4eb7acc00a102d13348bb96ad08371d.1472457609.git.johannes.schindelin@gmx.de>
 <52d61bef-668b-fdc4-30b3-a34c11b39f81@gmail.com>
 <xmqq8tvc21re.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1609011052260.129229@virtualbox>
 <xmqqeg53wj7a.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1609091708480.129229@virtualbox>
 <5b707a0d-6c10-abb5-3213-d13490e9b9de@gmail.com>
 <alpine.DEB.2.20.1609111027330.129229@virtualbox>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Haller <lists@haller-berlin.de>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <f7fe3f15-664e-61a5-6101-30ed4946c107@gmail.com>
Date:   Wed, 21 Sep 2016 15:17:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1609111027330.129229@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Dscho,

W dniu 11.09.2016 o 10:33, Johannes Schindelin napisał: 
> On Fri, 9 Sep 2016, Jakub Narębski wrote:
[...]

>> When preserving merges, there are (as far as I understand it), two
>> problems:
>>  - what it means to preserve changes (which change to pick,
>>    that is what is the mainline changes rebase is re-applying)
>>  - what are parents of the merge commit (at least one parent
>>    would be usually rewritten)
>>
>> Maybe the internal (and perhaps also user-visible) representation
>> of merge in instruction sheet could use the notation of filter-branch,
>> that is 'map(<sha-1>)'... it could also imply the mainline.
>>
>> That is the instruction in the internal instruction sheet could
>> look like this:
>>
>>   merge -m 1 map(2fd4e1c6...) da39a3ee... \t Merge 'foo' into master  
>>
>>
>> Note that it has nothing to do with this series!
> 
> Right. But I did solve that already. In the Git garden shears [*1*]
> (essentially my New And Improved attempt at recreating branch structures
> while rebasing), I generate and process scripts like this:
> 
> 	mark onto
> 
> 	# Branch: super-cool-feature
> 	rewind onto
> 	pick 00001 feature
> 	pick 00002 documentation
> 	mark super-cool-feature
> 
> 	# Branch: typo-fix
> 	rewind onto
> 	pick 0000a fix a tyop

There probably should be there

 	mark typo-fix

> 
> 	rewind onto
> 	merge -C cafebabe super-cool-feature
> 	merge -C babecafe typo-fix
> 
> 	cleanup super-cool-feature typo-fix
> 
> Of course this will change a little, still, once I get around to implement
> this on top of the rebase--helper.

Do I understand it correctly that it is user-visible instruction sheet, and
not the internal instruction sheet for sequencer?  This looks very nice
and is well readable.

I guess that it needs to be pre-populated by Git based on topology of the
branch being rebased.

As I see, there are three basic topologies of non-linear branch to be
rebased; all else is combination of thereof, or derivative:

1. Merge commit without branching point, that is we need to go
   from the following situation

   *---*---*---#---o---o---o        <-- old base
               \\
                \\=a===b===M===c    <-- branch being rebased
                          /
         ...---x---x---x-/          <-- side branch

  to the following:

   *---*---*---#---o---o---o        
                            \
                             \-a'--b'--M'--c' 
                                      /
         ...---x---x---x-------------/          

I think this case is the only one supported by `--preserve-merges`,
but I may be mistaken - I never had the need to use this feature IRL.

2. Branching point without accompanying merge commit, or in other words
   rebasing many branches tied together; a shrub if you will.  That is,
   we want to go from the following situation:

   *---*---*---#---o---o---o           <-- old base
               \
                \--a---b---c           <-- branch being rebased
                        \
                         \-1           <-- dependent branch

   to the following one:

   *---*---*---#---o---o---o
                            \
                             \--a'--b'--c'
                                     \
                                      \-1'

I don't think Git supports something like that out of the box, but it
is not hard to create something like that "by hand". It is not much
of a problem... unless you forget to rebase the second dependent branch.

3. Branching point with merge point, that is subbranch created and
   merged - an "eye" (it is not a loop in DAG):

   *---*---*---#---o---o---o             <-- old base
               \
                \--a---b---c---M---d     <-- branch being rebased
                    \         /
                     \-1---2-/         [ <-- possibly a branch ]

   All edges are directed edges, with arrows pointing from right to
   left; that is  *---*  is really  *<---*

   The expected result is:

   *---*---*---#---o---o---o
                            \
                             \--a'--b'--c'--M'--d'
                                 \         /
                                  \-1'--2'/

I guess that is the main purpose of your git-garden-shears script,
isn't it?

> 
> For example, I am not so hot about the "merge -C ..." syntax. I'll
> probably split that into a "remerge <SHA-1> <mark>" and a new "merge
> <mark>" command (the latter asking interactively for the merge commit
> message).

There is also an additional complication in that merge commit message
may be *partially* automatically generated. First there is the subject
generated by 'git merge' ("Merge branch 'foo'") or 'git pull <URL>'.
It might have been translated, or extended.  Second there is a place
for branch cover letter. Third, subject to merge.log / merge.summary
there is a shortlog.

From those shortlog should be surely updated to correspond to the
post-rebase state.  The first line could be used to pre-populate
mark lines, but during merge it should be, I think, updated to the
new name of internal branch if it was changed.


As to 'merge -C <sha1> <marker>' vs 'remerge <sha1> <marker>',
I don't have specified opinion.  It would be nice to have one
character shortcuts for insn sheet instructions, to which
'm -C <sha1> <marker>' is more amendable... 

> 
> And also: the cleanup stage should not be necessary, as the "mark"
> commands can accumulate the known marks into a file in the state
> directory.
> 
> But you get the idea.

Right. No need to make user do something that computer can easily
and without errors do.

> 
> No :1 or some such. That's machine readable. But it's utter nonsense for
> user-facing UIs.

Of course. It's all right for machine-facing instructions, like the
'todo' file for the sequencer, or for git-fast-import stream...

> 
> Ciao,
> Dscho
> 
> Footnote *1*:
> https://github.com/git-for-windows/build-extra/blob/master/shears.sh
 
P.S. I wonder if git-imerge[2] requires for integrated branches to have
both linear history for it to work.

[2]: https://github.com/mhagger/git-imerge
     http://softwareswirl.blogspot.com/2013/05/git-imerge-practical-introduction.html
     https://www.youtube.com/watch?v=FMZ2_-Ny_zc

Best,
-- 
Jakub Narębski
