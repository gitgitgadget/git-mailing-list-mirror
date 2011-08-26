From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] .gitattributes: Enable cpp diff parsing for .[ch] files
Date: Fri, 26 Aug 2011 13:54:19 -0700
Message-ID: <7vfwkndhc4.fsf@alter.siamese.dyndns.org>
References: <4E56CE8F.8080501@panasas.com>
 <CA+55aFxNXK-AJdrHBBycM5W632qUBi4E=jangcdRoefQiHzbug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Boaz Harrosh <bharrosh@panasas.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 22:54:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx3Q4-0004LX-6m
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 22:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755052Ab1HZUyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 16:54:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44999 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754590Ab1HZUyW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 16:54:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E4364496;
	Fri, 26 Aug 2011 16:54:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hElDlySN81Y+s6cLTZbOi++Qitw=; b=hCRnsK
	jm7dxQ+Apidz62xvNa9RU3CvVEHXZy9BXx0iaAv+zdysBn3QQ02fn65fTh9hgWzD
	aFzMmMGvebs+3yhUdqgb4dc2xTC4+Ob9XQiUikKEhCXhHBSWl4dYbeoPYZtAicmw
	Jm9QKHBwJZ2PkjlEf824jHyT/+IwDVssWM+es=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EJAR8JZEmHgJC8kJwlkYnFA0XkXkCdWX
	MbekX4NnTISUVNHb3RCvguB3V7r6tz+jB2ZOoeyFvMwF+dFZCNPeCyTsMo1UQwRZ
	qvNrGzdSKcq5JFUAZkK4b9AZo+ssQ9z5Z/ul+r8lLI0kLJ8p2apy9sBCv1BvvxBa
	44gNcZtCpL0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85B9A4495;
	Fri, 26 Aug 2011 16:54:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16B8B4494; Fri, 26 Aug 2011
 16:54:21 -0400 (EDT)
In-Reply-To: <CA+55aFxNXK-AJdrHBBycM5W632qUBi4E=jangcdRoefQiHzbug@mail.gmail.com> (Linus
 Torvalds's message of "Fri, 26 Aug 2011 13:27:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 927F8964-D025-11E0-A41E-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180196>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Aug 25, 2011 at 3:37 PM, Boaz Harrosh <bharrosh@panasas.com> wrote:
>>
>> Add a .gitattributes file to the Linux tree to enable cpp parsing
>> of the source files.
>
> Hmm. I'm not entirely conviced. If people really think that the hunk
> description matters that much, maybe we should just instead improve on
> the automatic diff detection, and extend it from just binary-vs-text,
> to also do the common hunk-headers.
>
> After all, not having a diff pattern already *does* mean "automatic",
> so it would be just a rather trivial extension to that.

Not quite sure what you exactly mean by "extend it from just binary-vs-text".
Do you mean update buffer_is_binary() and add source language detection?

See also:

    http://thread.gmane.org/gmane.comp.version-control.git/180103/focus=180113
