Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5D961FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 13:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbcGLNvj (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 09:51:39 -0400
Received: from smtp74.ord1c.emailsrvr.com ([108.166.43.74]:43088 "EHLO
	smtp74.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750922AbcGLNvi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2016 09:51:38 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jul 2016 09:51:38 EDT
Received: from smtp26.relay.ord1c.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp26.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 22C8E380259;
	Tue, 12 Jul 2016 09:44:31 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp26.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id CDDF938021D;
	Tue, 12 Jul 2016 09:44:30 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.5.4);
	Tue, 12 Jul 2016 09:44:31 -0400
Subject: Re: [PATCH v3 4/8] doc: give headings for the two and three dot
 notations
To:	Philip Oakley <philipoakley@iee.org>, GitList <git@vger.kernel.org>
References: <20160630202509.4472-1-philipoakley@iee.org>
 <20160711202518.532-1-philipoakley@iee.org>
 <20160711202518.532-5-philipoakley@iee.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:	Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <5784F43E.3080400@xiplink.com>
Date:	Tue, 12 Jul 2016 09:44:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <20160711202518.532-5-philipoakley@iee.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016-07-11 04:25 PM, Philip Oakley wrote:
> While there, also break out the other shorthand notations and
> add a title for the revision range summary (which also appears
> in git-rev-parse, so keep it mixed case).
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>   Documentation/revisions.txt | 23 +++++++++++++++++------
>   1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 79f6d03..1c59e87 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -242,35 +242,46 @@ specifying a single revision with the notation described in the
>   previous section means the set of commits reachable from that
>   commit, following the commit ancestry chain.
>
> +The '{caret}' (caret) notation
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   To exclude commits reachable from a commit, a prefix '{caret}'
>   notation is used.  E.g. '{caret}r1 r2' means commits reachable
>   from 'r2' but exclude the ones reachable from 'r1'.

All of these headings render poorly in the manpage, at least for me 
(Ubuntu 16.04).  Only the first word appears in bold; the '-quoted text 
is not bold but underlined, and the rest of the header is plain.


Also, I think calling this "The ^ notation" is confusing, because 
there's already an earlier paragraph on the "<rev>^" syntax.

Maybe we don't need a header here?  I only suggest that because I'm 
having trouble coming up with a nice alternative.  "Commit Exclusion"?

>
> -This set operation appears so often that there is a shorthand
> +The '..' (two-dot) range notation
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Perhaps "Range notation", to mirror the capitalization of "Symmetric 
Difference" in the next header?

> +The '{caret}r1 r2' set operation appears so often that there is a shorthand
>   for it.  When you have two commits 'r1' and 'r2' (named according
>   to the syntax explained in SPECIFYING REVISIONS above), you can ask
>   for commits that are reachable from r2 excluding those that are reachable
>   from r1 by '{caret}r1 r2' and it can be written as 'r1..r2'.
>
> +The '...' (three dot) Symmetric Difference notation
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   A similar notation 'r1\...r2' is called symmetric difference
>   of 'r1' and 'r2' and is defined as
>   'r1 r2 --not $(git merge-base --all r1 r2)'.
>   It is the set of commits that are reachable from either one of
>   'r1' (Left side) or 'r2' (Right side) but not from both.
>
> -In these two shorthands, you can omit one end and let it default to HEAD.
> +In these two shorthand notations, you can omit one end and let it default to HEAD.
>   For example, 'origin..' is a shorthand for 'origin..HEAD' and asks "What
>   did I do since I forked from the origin branch?"  Similarly, '..origin'
>   is a shorthand for 'HEAD..origin' and asks "What did the origin do since
>   I forked from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
>   empty range that is both reachable and unreachable from HEAD.

Unfortunately the new headings make it appear that this paragraph is 
exclusively part of the '...' notation section.  Folks reading the '..' 
section are likely to skip it.

I like the examples, though.  I think it would be worthwhile to remove 
this paragraph and fold it explicitly into the '..' and '...' notation 
sections.

So add something like this to the '..' section (only the first sentence 
here is new):

	Either r1 or r2 can be omitted, in which case HEAD is used as
	the default.  For example, 'origin..' is a shorthand for
	'origin..HEAD' and asks "What did I do since I forked from the
	origin branch?"  Similarly, '..origin' is a shorthand for
	'HEAD..origin' and asks "What did the origin do since I forked
	from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
	empty range that is both reachable and unreachable from HEAD.

And also, add the same first sentence and a different example to the 
'...' section.  Something like this:

	Either r1 or r2 can be omitted, in which case HEAD is used as
	the default.  For example, 'origin...' is a shorthand for
	'origin...HEAD' and asks "What have I and origin both done
	since I forked from the origin branch?"  Note that 'origin...'
	and '...origin' ask the same question.

>
> +Additional '{caret}' Shorthand notations
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   Two other shorthands for naming a set that is formed by a commit
> -and its parent commits exist.  The 'r1{caret}@' notation means all
> -parents of 'r1'.  'r1{caret}!' includes commit 'r1' but excludes
> -all of its parents.
> +and its parent commits exist.

I think descriptions of <rev>^@ and <rev>^! should live under the main 
description of <rev>^.  That part already describes the numeric suffix, 
so describing a couple of special suffixes there seems like a natural fit.

However, if you choose to keep this little section, you need to move the 
word "exist" earlier in the sentence:

	Two other shorthands exist for naming a set that is formed
	by a commit and its parent commits.

>
> -To summarize:
> +The 'r1{caret}@' notation means all parents of 'r1'.
> +
> +'r1{caret}!' includes commit 'r1' but excludes all of its parents.
> +
> +Revision Range Summary
> +----------------------

I think this should be a sub-heading (~~~~~~~), not a top-level heading.

		M.

