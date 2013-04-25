From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Thu, 25 Apr 2013 16:39:16 -0700
Message-ID: <7vzjwmyycb.fsf@alter.siamese.dyndns.org>
References: <7va9ong9oa.fsf@alter.siamese.dyndns.org>
	<CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
	<7v38ufer2x.fsf@alter.siamese.dyndns.org>
	<CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
	<CALkWK0=5tE0pXj-XTe4g9LdCO78yrPNwyom5fupF1WTToY2TZw@mail.gmail.com>
	<877gjrpsk4.fsf@hexa.v.cablecom.net>
	<CALkWK0kn7mEosWSdWs1Jjx-L32wmL51W=X7ny9BYQMttG1LPvQ@mail.gmail.com>
	<87li87awwc.fsf@linux-k42r.v.cablecom.net>
	<7va9om5zxu.fsf@alter.siamese.dyndns.org>
	<CALkWK0mMvUXnMDY87h3US0gRuM44ADEYXPh+JVP23Ja1=yz=VQ@mail.gmail.com>
	<20130425232145.GM29963@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 01:39:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVVl6-0004X7-D1
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 01:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758779Ab3DYXjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 19:39:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54923 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758758Ab3DYXjT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 19:39:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81A6A19C36;
	Thu, 25 Apr 2013 23:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w+b+CZ2QDrO5YtLtN/X+U93WOhs=; b=uhfeoB
	Z2DM4vMIlphnkQVokooVtkYQpaAKrcJi3ponRjoZHHFi142mfPJRvaC2s7a5g0+V
	QcWD7W3TUWi68FbE8/niD/gikR2shIXlMZF+jJD4QbniYeXSHDcQzdequV//0PUP
	WDqyKin6hKwVHSD/Z16yhWu5aiCExiOhyAmD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b0akZ6zRxoCjO7dnWoxINUyNaOJrP5PT
	7NPOe2a4dLwngZ4HNWC5ZCFkph0M1ZXdOYvdZIm9hajd4Q/fIhm3DKB8yEYuIs4J
	ut4cSkEh7TPuwF4Myob38hOWYRqBXcBShTCqJ1/SCdyiTHmmJtCYgy/GmuJwMdHq
	fZUNsFSUIyY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7917B19C34;
	Thu, 25 Apr 2013 23:39:18 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB66419C30;
	Thu, 25 Apr 2013 23:39:17 +0000 (UTC)
In-Reply-To: <20130425232145.GM29963@google.com> (Jonathan Nieder's message of
	"Thu, 25 Apr 2013 16:21:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5897CB7E-AE01-11E2-BF46-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222465>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ramkumar Ramachandra wrote:
>
>> I thought ^@ was invented for scripting, but can't imagine a usecase for ^!.
>
> I use "git diff $commit^!" from time to time to get the diff between a
> merge and its first parent.
>
> For comparison, I haven't found ^@ or "git log $commit^!" useful.  The
> commit introducing the former says
>
> | I needed it to do the multi-tree diff on Len's infamous 12-way
> | Octopus; typing "diff --cc funmerge funmerge^1 funmerge^2 funmerge^3
> | ..." was too painful.
>
> which is spelled as "git show --cc funmerge" these days.

The more important part of the message comes before that part ;-)

    This might be just my shiny new toy that is not very useful in
    practice.  I needed it to do the multi-tree diff on Len's ...

So I was right --- from the very beginning, this was "let's add a
random cruft on a whim without thinking things through" as I said.

It is not satisfactory to be right in saying that "I am sure this
was a stupid mistake" X-<.
