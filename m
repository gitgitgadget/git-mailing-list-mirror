Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BD61203C2
	for <e@80x24.org>; Thu, 21 Jul 2016 19:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbcGUTy4 (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 15:54:56 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:35131 "EHLO
	smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbcGUTyz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 15:54:55 -0400
Received: from PhilipOakley ([92.22.60.196])
	by smtp.talktalk.net with SMTP
	id QK3YbCBEpgKstQK3YbgjAU; Thu, 21 Jul 2016 20:54:53 +0100
X-Originating-IP: [92.22.60.196]
X-Spam:	0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=CAUsSRhAQMN2yxzfxQdKpQ==:117
 a=CAUsSRhAQMN2yxzfxQdKpQ==:17 a=N659UExz7-8A:10 a=8q6LdnVOAAAA:8
 a=xtxXYLxNAAAA:8 a=TDe5NS1vb_AlKtK0W4AA:9 a=jNYSTCpFY2gkngftge3H:22
 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <9B0B8E2D61D34BFEB8FC3F30EB23437C@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"GitList" <git@vger.kernel.org>,
	"Marc Branchaud" <marcnarc@xiplink.com>
Cc:	"Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Jakub Narebski" <jnareb@gmail.com>
References: <20160711202518.532-1-philipoakley@iee.org> <20160720211007.5520-1-philipoakley@iee.org> <20160720211007.5520-5-philipoakley@iee.org> <5790DF64.8030603@xiplink.com>
Subject: Re: [PATCH v4 4/8] doc: give headings for the two and three dot notations
Date:	Thu, 21 Jul 2016 20:54:53 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="Windows-1252";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfIi1pjbEOikxQevz2cPDGxGEPJ60yvdeMCaccfmuBStBZBy5lrTqVEFpHrMAMoespR9+hH12rw1m2KomdxwhoWaOyKq+WErTJpY38joyWMAMmH0CW8wj
 iQLaU9r2SaLhL06RMEvkmH6Mg8Be6w3PaqfUCRjFFkU/KArrrMnGPj3090S6z+tcaOktP6Bp3a8uHCPRhVEj3udhhKO7PATi/GCGg43Qe5m7RtHMtgfgJa8g
 hd+xMdJMhaYsyIdbayJZukOarj98qnYGYaA9h37Kp1U=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Marc Branchaud" <marcnarc@xiplink.com>
> On 2016-07-20 05:10 PM, Philip Oakley wrote:
>> While there, also break out the other shorthand notations and
>> add a title for the revision range summary (which also appears
>> in git-rev-parse, so keep it mixed case).
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>   Documentation/revisions.txt | 58 
>> ++++++++++++++++++++++++++++-----------------
>>   1 file changed, 36 insertions(+), 22 deletions(-)
>>
>> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
>> index 6e9cd41..5b37283 100644
>> --- a/Documentation/revisions.txt
>> +++ b/Documentation/revisions.txt
>> @@ -242,35 +242,49 @@ specifying a single revision with the notation 
>> described in the
>>   previous section means the set of commits reachable from that
>>   commit, following the commit ancestry chain.
>>
>> -To exclude commits reachable from a commit, a prefix '{caret}'
>> -notation is used.  E.g. '{caret}r1 r2' means commits reachable
>> -from 'r2' but exclude the ones reachable from 'r1'.
>> -
>> -This set operation appears so often that there is a shorthand
>> -for it.  When you have two commits 'r1' and 'r2' (named according
>> -to the syntax explained in SPECIFYING REVISIONS above), you can ask
>> -for commits that are reachable from r2 excluding those that are 
>> reachable
>> -from r1 by '{caret}r1 r2' and it can be written as 'r1..r2'.
>> -
>> -A similar notation 'r1\...r2' is called symmetric difference
>> -of 'r1' and 'r2' and is defined as
>> -'r1 r2 --not $(git merge-base --all r1 r2)'.
>> -It is the set of commits that are reachable from either one of
>> -'r1' (left side) or 'r2' (right side) but not from both.
>> -
>> -In these two shorthands, you can omit one end and let it default to 
>> HEAD.
>> +Commit Exclusions
>> +~~~~~~~~~~~~~~~~~
>> +
>> +'{caret}<rev>' (caret) Notation::
>> + To exclude commits reachable from a commit, a prefix '{caret}'
>> + notation is used.  E.g. '{caret}r1 r2' means commits reachable
>> + from 'r2' but exclude the ones reachable from 'r1'.
>> +
>> +Dotted Range Notations
>> +~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +The '..' (two-dot) Range Notation::
>> + The '{caret}r1 r2' set operation appears so often that there is a 
>> shorthand
>> + for it.  When you have two commits 'r1' and 'r2' (named according
>> + to the syntax explained in SPECIFYING REVISIONS above), you can ask
>> + for commits that are reachable from r2 excluding those that are 
>> reachable
>> + from r1 by '{caret}r1 r2' and it can be written as 'r1..r2'.
>> +
>> +The '...' (three dot) Symmetric Difference Notation::
>> + A similar notation 'r1\...r2' is called symmetric difference
>
> s/called/called the/

The wording is the original ;-) Can change.

>
>> + of 'r1' and 'r2' and is defined as
>> + 'r1 r2 --not $(git merge-base --all r1 r2)'.
>> + It is the set of commits that are reachable from either one of
>> + 'r1' (left side) or 'r2' (right side) but not from both.
>> +
>> +In these two shorthand notations, you can omit one end and let it 
>> default to HEAD.
>>   For example, 'origin..' is a shorthand for 'origin..HEAD' and asks 
>> "What
>>   did I do since I forked from the origin branch?"  Similarly, '..origin'
>>   is a shorthand for 'HEAD..origin' and asks "What did the origin do 
>> since
>>   I forked from them?"  Note that '..' would mean 'HEAD..HEAD' which is 
>> an
>>   empty range that is both reachable and unreachable from HEAD.
>>
>> -Two other shorthands for naming a set that is formed by a commit
>> -and its parent commits exist.  The 'r1{caret}@' notation means all
>> -parents of 'r1'.  'r1{caret}!' includes commit 'r1' but excludes
>> -all of its parents.
>> +Special '<rev>{caret}' Shorthand Notations
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Sorry, but this header also does not render properly in the man page. 
> Maybe just "Special {caret} Shorthand Notations"?  (But read on!)

rendered fine on the MYS2 man invocation - I had had to add the <rev> prefix 
to the quoted title to make it work.

What went wrong for you? (I'll read on)


>
>> +Two other shorthands exist, particularly useful for merge commits, is
>> +for naming a set that is formed by a commit and its parent commits.
>>
>> -To summarize:
>> +The 'r1{caret}@' notation means all parents of 'r1'.
>> +
>> +'r1{caret}!' includes commit 'r1' but excludes all of its parents.
>
> My immediate thought upon reading this is "Why not just use 'r1'?"  I 
> think the answer is "This truncates the range."  So, for example, "git log 
> r1" shows you r1 and its ancestors, while "git log r1^!" only shows you 
> r1.  I think you should add this example, or something similar.
>

I'd also asked that question in one of my replies earlier $gmane/299849. I 
was then able to determine that it was a width wide 'range' covering 
multi-parent situations.

Identifying an example could be good if it was succinct and explanatory.

$ git rev-parse 6c71a849^!
> But, really, this means that the notation is another "Commit Exclusion" 
> and properly belongs in that section.

I think it's bigger than that.
>
> That makes this "Special Notations" section rather thin.  I suggest moving 
> a slightly expanded <rev>^@ description to a small subsection just before 
> Commit Exclusions, and deleting the Special Notations section altogether. 
> So add something like this:
>
> Commit Parents
> ~~~~~~~~~~~~~~

It's a bit better, but I'm still not sure it really tells the story, maybe 
"Handling Commit Parent(s)", with that subtle extra emphasis!

>
> '<rev>{caret}@' Notation::
> The 'r1{caret}@' notation means all parents of 'r1',
> excluding 'r1' itself.
>
> This smoothly re-introduces the notion of parents for readers who skipped 
> to this section, and helps them make sense of the <rev>^! notation.
>
> Plus there's no longer anything "special" about any of the syntax.
>
>> +
>> +Revision Range Summary
>> +----------------------
>
> Sorry, but the man page renders this in all caps.  I really think you 
> should use ~~~~~~~~~ here.

Yes, the man page formating is annoying relative to the web page formatting 
which it has to be compared against.

I felt that it was at a higher level than the other sub-headings, and that 
using mixed case did work well on the html (the Git for Windows standard).

At the moment I'm minded to keep it as is unless others chime in.

>
> M.
>
I'll be away till mid next week.
--
Philip 

