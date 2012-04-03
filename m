From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Updated tags on repo are not updated when pull
Date: Tue, 03 Apr 2012 16:39:28 -0700
Message-ID: <7vfwckbd1r.fsf@alter.siamese.dyndns.org>
References: <27353249354D994D8E42D75D75FBA614896543@OASBEVEXM01.oaifield.onasgn.com>
 <CAJsNXTk8R0yjad0T9605v-CMMdCA+C0v3Rqt65h_k6MK88UD9g@mail.gmail.com>
 <27353249354D994D8E42D75D75FBA6148965A9@OASBEVEXM01.oaifield.onasgn.com>
 <27353249354D994D8E42D75D75FBA6148967BE@OASBEVEXM01.oaifield.onasgn.com>
 <CAJsNXT=mQgt++g-Tz=kfDjC+PC7wJhc77f6zu7vg8GSnJfDq3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastien Tardif <sebastien_tardif@oxfordcorp.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: PJ Weisberg <pj@irregularexpressions.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 01:39:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFDK4-0001Uh-27
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 01:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057Ab2DCXjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 19:39:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43122 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754548Ab2DCXjb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 19:39:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 717B769F1;
	Tue,  3 Apr 2012 19:39:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/dlOYiAc2TdSNjZZ4/uzvV2nMBQ=; b=WuUCtD
	By7TW2NuZb2/Ww2XXZySNkNF9IEiaUyYC3x+zcUeqYgdM8YegaoeVrxTdl/CjKdi
	v3SXChDnPtCcaOs2JjbLf/tyYXBZTC0DDbXOHBSUTE4U3FFLXQTIWP0iGPCT1mfv
	yjF0LxPOSyZYxptQd85y6p85nWAEF52M2nFW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kdRykF0cz5p22tRrqE+frjoOOyqCxjzI
	+l5eGebnsLor3U9gE297MlS4ES0iWSXXVrEyqw9HlV0wzPHMsteRHQpbQ+GFKVze
	e83gygdX6nRAFIGf6sa217I9Ri4aDcc6jYRGgAcfpBl+gmcD5KdHedqf40p1gpC2
	AD1CN10uDE4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68E5269EF;
	Tue,  3 Apr 2012 19:39:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF9D669EE; Tue,  3 Apr 2012
 19:39:29 -0400 (EDT)
In-Reply-To: <CAJsNXT=mQgt++g-Tz=kfDjC+PC7wJhc77f6zu7vg8GSnJfDq3w@mail.gmail.com> (PJ
 Weisberg's message of "Tue, 3 Apr 2012 12:44:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41D097BE-7DE6-11E1-84B8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194673>

PJ Weisberg <pj@irregularexpressions.net> writes:

> Basically it's a branch that no one updates
> except the build server under specific circumstances.  You could
> enforce that with hooks, but I think the biggest problem is the word
> "branch".  People (and UIs) have ideas of what a branch is and what
> it's used for, which don't *quite* match the intended use.
>
> I wonder if the Git developers have any ideas on the best way to
> maintain a pointer to the latest successful automated build, and other
> such things?

Such things, if they are not branches nor tags, can be placed under
different naming hierarchy, e.g. refs/built, without interfering the
normal semantics of "branches" (people expect to be able to check them
out, build on them and push them back to advance their tips) or "tags"
(people expect them to anchored at known points without floating).  Any
semantics the project wants to assign to them by social convention, and
Git does not care.  If the project participants are expected to always
fetch them to keep them up to date in their local namespace, the project
can tell them to place an extra entry for remote.origin.fetch in their
repository config

	[remote "origin"]
        	fetch = +refs/built/*:refs/built/*

in the same document they tell them where and how to clone the project
history from.

I would however use the usual branch perhaps with a well-known prefix if I
were doing this.  You would want to forbid updates of them from random
people at the central site with a pre-receive hook anyway; using a
different hierarchy only to avoid the word "branch" is not worth the extra
complexity.
