From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] test: tests for the "double > from mailmap" bug
Date: Tue, 14 Feb 2012 14:49:39 -0800
Message-ID: <7vzkcl3u9o.fsf@alter.siamese.dyndns.org>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
 <20120214203431.GB13210@burratino>
 <20120214211402.GC23291@sigill.intra.peff.net>
 <CAMP44s0Dp9Av+ikFHa=QcqKFA5XL9ESBrzWLY0jkSCdH-NxhMw@mail.gmail.com>
 <7v8vk55a99.fsf@alter.siamese.dyndns.org>
 <CAMP44s0cJroUM2aahRQz2dVPe57XPPOnsxWy+5DfmjXGArz4wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 23:49:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxRC0-00077p-4n
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 23:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760938Ab2BNWto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 17:49:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52206 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755181Ab2BNWtn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 17:49:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C143D76DD;
	Tue, 14 Feb 2012 17:49:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sGcxVyoBxi+gp2IArlo/z1+Q4Xs=; b=qa9TrP
	2dUnZtGvOkv4VA+kgqpE+7K05/WErk3+jcHPT10pDzWad2MyxorB7N6ZfMD4XzSi
	FddxDSkSknbYjdnCe26NssUg0F9Ry383hHWe0XTMCvesBwoycGca/e1OOhWzBZfQ
	2htvGKIYcVDuAUUGUz4bqwHW6dRILUzRYsT4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J8IrpflsZ88kjYqYLivSrYDN1ncO+cds
	zJVnC5HEVOjUBuOtVK5q6kcrBYNwV9rHTFiI6bizRSa45YZkgCUf5C0ivpdlIpfi
	zSe3A9MXy1kSN6SAZh5+iTVxkFNC1dAkcfjdJg8GXQZXwn9jMSDzYhR3JYQBH/op
	woEeWaEvHFU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B24E576DC;
	Tue, 14 Feb 2012 17:49:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F6CB76DB; Tue, 14 Feb 2012
 17:49:41 -0500 (EST)
In-Reply-To: <CAMP44s0cJroUM2aahRQz2dVPe57XPPOnsxWy+5DfmjXGArz4wA@mail.gmail.com> (Felipe
 Contreras's message of "Wed, 15 Feb 2012 00:34:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E3C0160-575E-11E1-8CB2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190789>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, Feb 15, 2012 at 12:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> And I don't understand why people want the obvious to be explained.

Has it ever occurred to you the reason why people ask questions to you is
perhaps because something that is obvious to you who wrote the patch is
not obvious at all to others?  Has it also occurred to you that the
majority of people who need to understand the patch during the review and
6 months down the road in "git log" output are not *you*?

> Your new point is "you can add a new thing that we did not have, but
> it would not result in a good addition if that new thing is
> irrelevant", but you already know what is the new thing from the
> summary "'git blame -e' tests".

It is not a "new point".  Jonathan, Peff and I all never said that it is
unclear "what" your patch adds.  The suggestions for improvement given in
this thread were all to explain "why" better.

> Everybody seems to assume that a simple commit message = bad. I disagree.

If you find *everybody* seems to disagree with you, it would help to
consider a slight possibility that you *might* be wrong.  And "simple" is
not necessarily "sufficient and simple".

> ... And I already pointed out the double standards.

Sorry, but the absolute uniform standards do not exist, unless you are
living in a fantasy land.  I expect better from list regulars as new
contributors will inevitably learn from their behaviour (we also learn
from our past mistakes).
