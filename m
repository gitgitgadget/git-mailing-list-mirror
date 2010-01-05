From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to exclude files from "git diff"
Date: Tue, 05 Jan 2010 10:41:03 -0800
Message-ID: <7vvdfgxum8.fsf@alter.siamese.dyndns.org>
References: <6dc9ffc80912180909q2e9cbe30r7c802a2152c5954@mail.gmail.com>
 <20100105064509.GC19025@coredump.intra.peff.net>
 <6dc9ffc81001050620q55c23072p93f58c8685d77f9d@mail.gmail.com>
 <37fcd2781001050954y778ba661n7cee6cda699968c2@mail.gmail.com>
 <6dc9ffc81001051015x3bebc994r3d475bdb59e12d39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: "H.J. Lu" <hjl.tools@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 19:41:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSELH-0007zi-EO
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 19:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194Ab0AESlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 13:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755175Ab0AESlP
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 13:41:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33577 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754212Ab0AESlO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 13:41:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 13A988E2B3;
	Tue,  5 Jan 2010 13:41:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2wLMpTRvlH6VvPEzzcH4Ru/c8dI=; b=rjXizE
	lVC5GSpom8oSCi/pjLVqSZ5P3XN+LJqE/MvgX16xFR/17v4kvxckhlEQgHH6mqtT
	Kz/RsAhVQL3hZoihRi1Uh6eYeKT1sccM4NJQ0u9NRsYpBXb4X3h+oJhYmm0Oc7uV
	3sdQ7ia6sRQ2b7G9twWcoPUR/PJNhRPVaSCEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pO7DLIQB4eCAF+rSdgBocsGTUJFypX5Q
	VpEPGvQM7Ga5GZTwaxYC8uh5fHzqgwV/EEofj3YaTnXi0AyBgChVYvH8ofLGH9Sj
	lwIPTqs869P/lh0G7r7eCjA3X2ws0H4aomGFMAEavgjChZwbRpS3KPksRzeLOE01
	XOoeijUwFYM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B19128E2B2;
	Tue,  5 Jan 2010 13:41:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CAC18E2AE; Tue,  5 Jan
 2010 13:41:04 -0500 (EST)
In-Reply-To: <6dc9ffc81001051015x3bebc994r3d475bdb59e12d39@mail.gmail.com>
 (H. J. Lu's message of "Tue\, 5 Jan 2010 10\:15\:19 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E433AB24-FA29-11DE-A606-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136202>

"H.J. Lu" <hjl.tools@gmail.com> writes:

> On Tue, Jan 5, 2010 at 9:54 AM, Dmitry Potapov <dpotapov@gmail.com> wrote:
>> On Tue, Jan 5, 2010 at 5:20 PM, H.J. Lu <hjl.tools@gmail.com> wrote:
>>>
>>> Yes, I want those files in repository. They are for my personal use only.
>>
>> If you modified some file locally and do not want to see and commit
>> those modifications, you may want to use:
>>
>> git update-index --assume-unchanged foo
>>
>
> I added those files into my repository for bookkeeping purpose. It
> shouldn't go out at all.

Sounds like time to run "rm --cached" to me.  IOW, keep it untracked.
