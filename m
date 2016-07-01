Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7985A2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 23:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbcGAXCM (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 19:02:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61439 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752516AbcGAXCK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 19:02:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D5B0D26DD0;
	Fri,  1 Jul 2016 19:01:57 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qA3yXKTf74wcmOkrVy6OTyAXwtk=; b=SJr3d/
	76Q8Q5SxSEbBirs+K5u2vABJX6dbvM/edLqje/NMbvAAFH5b8ocvhaKnkSQvzat0
	Ig+FMigNXmHyT9NcGnul4hhyQ6dLrmxFBON6+92hLCcQS46AYAWdWIELzT+Vx7PO
	QZksI9nS1dV06Y5fjJRiXq1vBg2xMyiIGc1aE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dyqOY37R5yBn9/mbnXzO0ujcPU8SG5Ms
	Cl/Kq/lzUdLkNlaWYo2We61fr4YxAFdSd58uibrYJQUgJ0O+5VkXBDZvn+JVblUw
	hLctZge44P7g0uwvla2A5v2tnJ/tqQSJo6s3kcT+TY4nSbpSPEHHP5uY/9SR8Mux
	peh3WiCv0c4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CEB4C26DCE;
	Fri,  1 Jul 2016 19:01:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 53E6726DCD;
	Fri,  1 Jul 2016 19:01:57 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Philip Oakley <philipoakley@iee.org>
Cc:	GitList <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] doc: clarify that `^r1` will exclude `r1` itself
References: <20160625164654.5192-1-philipoakley@iee.org>
	<20160630202509.4472-1-philipoakley@iee.org>
	<20160630202509.4472-5-philipoakley@iee.org>
	<xmqqk2h5vz2m.fsf@gitster.mtv.corp.google.com>
	<38FAE374CD2D44EC9C86167F98953271@PhilipOakley>
	<CAPc5daW_Kf8UG2zm4vBS9f4tN+bXusdZQkcwnssNs+gdk8J75w@mail.gmail.com>
Date:	Fri, 01 Jul 2016 16:01:55 -0700
In-Reply-To: <CAPc5daW_Kf8UG2zm4vBS9f4tN+bXusdZQkcwnssNs+gdk8J75w@mail.gmail.com>
	(Junio C. Hamano's message of "Fri, 1 Jul 2016 15:14:40 -0700")
Message-ID: <xmqqziq1ufmk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF89A536-3FDF-11E6-861D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> On Fri, Jul 1, 2016 at 3:08 PM, Philip Oakley <philipoakley@iee.org> wrote:
>>>>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>  To exclude commits reachable from a commit, a prefix '{caret}'
>>>>  notation is used.  E.g. '{caret}r1 r2' means commits reachable
>>>> -from 'r2' but exclude the ones reachable from 'r1'.
>>>> +from 'r2' but exclude 'r1' and those reachable from 'r1'.
>>>
>>> Well, if you have to spell that out, you'd want to spell out r2 side
>>> too, no?  That is,
>>
>> The clarification wasn't about what "reachable" means but about inclusivity,
>> such as whether 0..4 would give 0,1,2,3,4 or would be 'off by one' and only
>> give 1,2,3,4. And in this case it's the latter.
>
> Well, you have the same inclusivity issue on the opposite end, no? Is 0..4
> a range with 0,1,2,3,4? 0,1,2,3? 1,2,3,4? or 1,2,3?
>
>> Describing 'reachability' is a whole different kettle of fish, as you
>> highlight below, and would be separate from this patch.
>
> I am not sure I agree. It all is about "is the endpoint included or not?".

This did not come out as illustrating as I hoped.  Let's put it
differently.

I think this is all about how "reachable" is defined.  "Am I an
ancestor of myself?" is the question.

If "all commits reachable from r1" includes 'r1', then, it is clear
that "... but exclude those reachable from 'r1'" means 'r1' is not
part of the resulting set.

If I were not an ancestor of me, on the other hand, "... but exclude
those who are ancestors of 'r1'" would not exclude 'r1'.  If 'r1' is
reachable from 'r2', then 'r1' would be in the resulting set.

The same thing happens at the opposite end of the "range".  If I am
an ancestor of me, then "all commits reachable from 'r2'" does
inculde 'r2'; if I am not an ancestor of me, 'r2' is not part of the
resulting set.

	Note.  I said "range" in quotes, because this is not like
	drawing a straight line and placing two points to denote the
	lower and the upper bounds of the "range".  What Git does is
	a set operation, "r2 ^r1" excludes what is reachable from r1
        from the set of commits that are reachable from r2.

By choosing the definition of "reachable" consistently, 0..4 can
mean either 1,2,3,4 (I am reachable from myself) or 0,1,2,3 (I can
not be reached by me), and in order to clarify that we give 1,2,3,4
and not 0,1,2,3, we still need to clearly define what "reachable"
means.

But any other interpretation, e.g. 0,1,2,3,4, is incoherent.
