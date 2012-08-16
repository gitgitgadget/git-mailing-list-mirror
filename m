From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rev-list docs: clarify --topo-order description
Date: Wed, 15 Aug 2012 23:20:28 -0700
Message-ID: <7vipcj2w9f.fsf@alter.siamese.dyndns.org>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
 <877gt16ewe.fsf@thomas.inf.ethz.ch> <7vzk5x8s1q.fsf@alter.siamese.dyndns.org>
 <87sjbpa5m8.fsf@thomas.inf.ethz.ch>
 <7vmx1v53fb.fsf_-_@alter.siamese.dyndns.org>
 <CAOeW2eFZNuM_8bFB2cXGVRT0FpDC86fH=XMj9kviXs-UCo1fAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 08:20:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1tRu-00030j-9I
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 08:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323Ab2HPGUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 02:20:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33731 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753346Ab2HPGUb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 02:20:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D9CF6836;
	Thu, 16 Aug 2012 02:20:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3g/wJmOi7FWJUtHXpMNikMvRh2s=; b=Zode8h
	5pZEbbiPN/pMn8nyOVkRR8RpfLjWf/GuPDE71jF4kU/wLoi3csJBd3YNfYurhw8z
	hr2urTNVFmQjc+gYNOgfBPhBhnmUNp9ySBs1B30g2hSJiMsl/kGjXWXm2e5a4OvO
	LIFtKg/F+MlOfDGBk1OONbrUkwZa29o2wOggM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sXREcOohU36sERG5OVI9dhqL4zn2iIqJ
	OZgvwJ4xaDMGzZGBGCGD9ZB7VSPmyUK9TqzHICaYU1NLzys4uKOOsdedBEJypW4Q
	Zor3J69VyAwurfHIOSh5smqZda6rcLYW3s++6aqsnWAZuKNTif6zcK2pI/TtrdhE
	tPK9BRFOeh8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AAD66835;
	Thu, 16 Aug 2012 02:20:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DD926834; Thu, 16 Aug 2012
 02:20:29 -0400 (EDT)
In-Reply-To: <CAOeW2eFZNuM_8bFB2cXGVRT0FpDC86fH=XMj9kviXs-UCo1fAA@mail.gmail.com> (Martin
 von Zweigbergk's message of "Wed, 15 Aug 2012 23:06:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79F60988-E76A-11E1-963D-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> On Wed, Aug 15, 2012 at 1:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
>> index 6a4b635..9404d08 100644
>> --- a/Documentation/rev-list-options.txt
>> +++ b/Documentation/rev-list-options.txt
>> @@ -578,16 +578,33 @@ Commit Ordering
>>
>>  By default, the commits are shown in reverse chronological order.
>
> As I said before, this led me to believe that "the commits are shown
> in reverse chronological order" when neither of --topo-order or
> --date-order is passed. I agree that we should avoid specifying more
> than necessary about the default case. But in this case, what is
> specified is not exactly true (in the face of clock skew). Or am I
> misunderstanding or misinterpreting something? I still don't
> understand the revision walker well enough to be able to provide a
> better wording, but I think even the rather crude "By default, the
> order is unspecified." would at least not be as easy to misinterpret
> (if that's what I did) and is definitely not over-specified. Of
> course, if someone can think of something better, I'm all for it.
>
> Regardless of the above comment about the patch context, what your
> patch actually changes looks good. Thanks again.

We could remove it if you find it confusing.

I think the original motivation that line was added was to help
people who see "git log" (without any frills) output for the first
time not to be alarmed when they see newer things first: "In
general, the "time" flows from bottom to top", but the "time" in
that sentence is not necessarily the timestamp of either committer
nor author field.
