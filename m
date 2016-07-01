Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 102C92018A
	for <e@80x24.org>; Fri,  1 Jul 2016 22:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbcGAWVH (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 18:21:07 -0400
Received: from a1i216.smtp2go.com ([43.228.184.216]:56385 "EHLO
	a1i216.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbcGAWVG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 18:21:06 -0400
X-Greylist: delayed 748 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Jul 2016 18:21:06 EDT
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a0-2; h=Feedback-ID:X-Smtpcorp-Track:Date:Subject:To:From:
	Reply-To:Message-ID; bh=cJRNxHnqLbABf1DjbxGu6Bd+CTW6roCUYgIrJ6MfBbI=; b=T5eVu
	m53ccg/aWnvuZqVboBEumcXrrktWFBX0EuHKT0Autqyjopv1d9Z2h33zOdLGs64Vr3j3/X0N3R3KS
	fprcK6dEDP1mcObe+6oi5lfOHIrG1iSs+AzyKzMEukkgOopHGSJ/H3335xq1CgcVcg3cWu3wP/18a
	vBAR3tI4T7NC6z8tgfcwbOsgdl+Bi0xv0yYnW2bsHEWPUA+EaoQvSExgY5SGRXDyL+fRs8VbW3CcP
	We0jKeouLbQaamEj/cpp9JciNNA9jOAgg3In5VDZb15ds9d8aelqeKJ0L+d6DS59O46xSxp/lDQnR
	6F9tz83/u4CNTN3bDJDL23lCx8GDQ==;
Message-ID: <38FAE374CD2D44EC9C86167F98953271@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Junio C Hamano" <gitster@pobox.com>
Cc:	"GitList" <git@vger.kernel.org>, "Jeff King" <peff@peff.net>
References: <20160625164654.5192-1-philipoakley@iee.org><20160630202509.4472-1-philipoakley@iee.org><20160630202509.4472-5-philipoakley@iee.org> <xmqqk2h5vz2m.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH v2 4/4] doc: clarify that `^r1` will exclude `r1` itself
Date:	Fri, 1 Jul 2016 23:08:24 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Smtpcorp-Track: 1PJ6PrtxoMiP7Y.dsnZMUGDR
Feedback-ID: 66524m:66524aMf6O2Y:66524sd49UGHL4N:SMTPCORP
X-Report-Abuse:	Please forward a copy of this message, including all
 headers, to <abuse@smtp2go.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>  Documentation/revisions.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
>> index 131060c..87be9c4 100644
>> --- a/Documentation/revisions.txt
>> +++ b/Documentation/revisions.txt
>> @@ -246,7 +246,7 @@ The '{caret}' (caret) notation
>>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>  To exclude commits reachable from a commit, a prefix '{caret}'
>>  notation is used.  E.g. '{caret}r1 r2' means commits reachable
>> -from 'r2' but exclude the ones reachable from 'r1'.
>> +from 'r2' but exclude 'r1' and those reachable from 'r1'.
>
> Well, if you have to spell that out, you'd want to spell out r2 side
> too, no?  That is,

The clarification wasn't about what "reachable" means but about inclusivity,
such as whether 0..4 would give 0,1,2,3,4 or would be 'off by one' and only
give 1,2,3,4. And in this case it's the latter.

Describing 'reachability' is a whole different kettle of fish, as you
highlight below, and would be separate from this patch.

I've certainly tripped up in the past over using an appropriate reachability
definition in r1..r2, and forgetting (*) about remote branches being in the
local graph . (*- i.e. not really understanding!)

--
Philip
(only occasional access to internet over next few days)
>
> ... means commits 'r2' and those reachable from 'r2', but
> exclude 'r1' and those reachable from 'r1'.
>
> The (sub)document has 16 grep hits of "reach(able)"; a reader who
> needs this clarification would need all of them clarified, but
> repeating "X and those reachable from X" everywhere is not a good
> way to do so.  Perhaps a separate sentence upfront that defines what
> "reachable" means is a better solution, no?
>
> Something like the attached patch may be a good starting point, but
> this leaves two forward-references of reachable in the part that
> describes ways to specify a single object (e.g. find a commit with
> this string that is reachable by X) we may need to address, perhaps
> by adding "(see below)" or something.
>
>
> Documentation/revisions.txt | 4 ++++
> 1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 19314e3..34642b9 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -242,6 +242,10 @@ specifying a single revision with the notation
> described in the
> previous section means the set of commits reachable from that
> commit, following the commit ancestry chain.
>
> +A commit Y is said to be reachable from commit X if Y is X, or if Y
> +is reachable from any any of X's parents.  We also say "Y is an
> +ancestor of X" in such a case.
> +
> To exclude commits reachable from a commit, a prefix '{caret}'
> notation is used.  E.g. '{caret}r1 r2' means commits reachable
> from 'r2' but exclude the ones reachable from 'r1'.
>
> 

