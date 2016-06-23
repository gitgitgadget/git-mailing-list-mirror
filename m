Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40BC31FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 20:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbcFWUNo (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 16:13:44 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64869 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750799AbcFWUNn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2016 16:13:43 -0400
X-AuditID: 1207440d-847ff700000008ea-47-576c42f21b79
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 7F.2D.02282.2F24C675; Thu, 23 Jun 2016 16:13:38 -0400 (EDT)
Received: from [192.168.69.130] (p508EAB27.dip0.t-ipconnect.de [80.142.171.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5NKDZFw012681
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 23 Jun 2016 16:13:36 -0400
Subject: Re: [PATCH] diff compaction heuristic: favor shortest neighboring
 blank lines
To:	Junio C Hamano <gitster@pobox.com>
References: <20160616174620.1011-1-sbeller@google.com>
 <20160617153637.GA9314@sigill.intra.peff.net>
 <CAGZ79kZgdbqnWW9uqeBHNDbyGVfc0x5gTJbyD0Nyi1i3SNvENQ@mail.gmail.com>
 <576C1803.5050905@alum.mit.edu>
 <xmqq1t3nkdrm.fsf@gitster.mtv.corp.google.com>
Cc:	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <576C42EF.80400@alum.mit.edu>
Date:	Thu, 23 Jun 2016 22:13:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq1t3nkdrm.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqPvZKSfcYOMvVouuK91MFg29V5gt
	di/uZ7b40dLDbLF5czuLA6vHzll32T0WbCr1eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M14fu8ZYcFimomf3BbYGxh+iXYycHBICJhLnV/xk62Lk4hAS2MoocWnCK3YI5zyTxPrD
	+9lAqoQFIiSuHH3ECGKLCKhJTGw7xAJR1MAk8f1tAwtIgllgOaPE8m0pIDabgK7Eop5mJhCb
	V0BTYvqfPqCpHBwsAqoSh74bgYRFBUIkzq/bygpRIihxcuYTFpASTgFriVm/oiEm6knsuP6L
	FcKWl9j+dg7zBEb+WUg6ZiEpm4WkbAEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXSO93MwS
	vdSU0k2MkEDm3cH4f53MIUYBDkYlHt4X4jnhQqyJZcWVuYcYJTmYlER5leyBQnxJ+SmVGYnF
	GfFFpTmpxYcYJTiYlUR4C+2AcrwpiZVVqUX5MClpDhYlcV61Jep+QgLpiSWp2ampBalFMFkZ
	Dg4lCd6LjkCNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aCIjC8GxiRIigdob50T
	yN7igsRcoChE6ylGXY4j+++tZRJiycvPS5US570MskMApCijNA9uBSxtvWIUB/pYmFcLZBQP
	MOXBTXoFtIQJaMnd/myQJSWJCCmpBsY84QW+BRzKExLriq7mvJu9b5/8Usdj7LLzi+5XlC59
	/n6L2FOTvisFT0zS8tSyTSbW2e7aMHP/kqTXvhKGjku6zB96Xa//cu4VSyPLTTueJnHZKQnz
	F0w9qX+aV3PDIR2ROf5zZ/8rnvTt6ebymSY6vaWX/GWK326qcJm9SXy2rGF3gJecYLQSS3FG
	oqEWc1FxIgA9GIfKNgMAAA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 06/23/2016 07:37 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Scoring heuristic:
>>
>>>     # A place to accumulate bonus factors (positive makes this
>>>     # index more favored):
>>>     bonus = 0
>>>
>>>     # Bonuses based on the location of blank lines:
>>>     if pre_blank and not blank:
>>>         bonus += 3
>>>     elif blank and not pre_blank:
>>>         bonus += 2
>>>     elif blank and pre_blank:
>>>         bonus += 1
>>>
>>>     # Now fill in missing indent values:
>>>     if pre_indent is None:
>>>         pre_indent = 0
>>>
>>>     if post_indent is None:
>>>         post_indent = 0
> 
> These "missing" are to handle the lines at the boundary of shiftable
> block, or do you have pre_indent if a line is the earliest possible
> one that could be included in the hunk by shifting, as long as it is
> not at the beginning of the file?

The missing values are meant to handle the case where there are only
blank lines between the add/delete block and the beginning/end of the
file. Though currently (due to a limitation of the prototype) I only
pass context up to the next add/delete line, so that fallback also kicks
in if there are only blank lines between this add/delete block and the
next added/deleted line. When that is fixed, I think it might help to
give beginning/end of file a little bit more bonus.

This isn't all implemented yet, but I think the best score for an
add/delete block positioning would be the sum of three values. Let's
take the following "complete file" diff as an example, and consider an
add block with the following positioning:

> diff --git a/file.txt b/file.txt
> index 9405325..6a6b95c 100644
> --- a/file.txt
> +++ b/file.txt
> @@ -1,5 +1,7 @@
>  a
>  b
>  c
> +x
> +c
>  d
>  e

The score for splitting the old version of the file between
"bc" and "de", plus

the score for splitting the new version of the file between
"bc" and "xc", plus

the score for splitting the new version of the file between
"xc" and "de".

> I think "this is indented deeper than the previous, and it wants to
> stay with the previous if possible" is an excellent heuristic, which
> you have below.  I wonder if "however, the previous cannot be
> included in the hunk by shifting, hence we try to keep this together
> with it by favouring its exclusion from the hunk" could be part of
> the same heuristics, if you do have pre_indent value for a line at
> the boundary of shiftable block.

That's automatic, isn't it? If splitting between two lines is assigned a
high cost, then the algorithm will avoid splitting there *either* by
including both lines in the hunk *or* by omitting both lines.

> Also I am wondering if 0 is a sensible thing to use as the fallback
> value.  When pre_indent is not definable, turning it to 0 and
> declaring that our indented line is indented deeper than the
> previous line and penalizing with "bonus -= 4" (which you do) feels
> just as fishy as turning the undefined pre_indent to maxint and
> declaring that our indented line is indented shallower than the
> previous line (which you don't, but is just as justifiable, I would
> think).

Once the algorithm is fixed to consider the whole file, then the
fallback value will only be used at the beginning and end of the file,
where an indent of 0 seems like the natural thing to do. As I mentioned
above, it might even help to give beginning/end of file a little more
bonus than that.

But really, testing against real-world diffs will be the best basis for
adjusting the heuristic.

Michael

