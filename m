From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2013, #08; Tue, 28)
Date: Wed, 29 May 2013 10:29:13 -0700
Message-ID: <7v4ndlvgnq.fsf@alter.siamese.dyndns.org>
References: <7vli6yydmv.fsf@alter.siamese.dyndns.org>
	<51a56e2db218d_807b33e18100177@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 19:29:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhkBk-0007tR-Lp
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 19:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932898Ab3E2R3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 13:29:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34070 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932471Ab3E2R3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 13:29:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9B8423FB0;
	Wed, 29 May 2013 17:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/wl/jB4iECZWD64FwrL1xD3uMNg=; b=EvcydC
	IQ2lBQhnBmemuSYTLBGJKiwbG2uLEBVGNkjx1tHlWYcxOasNwt6cCuqGE+b6m2Lj
	wBOFfc7c8OIyBxS4FPYnrRVRlc43XTUFpG1mcbgwpfMhj6lPhqkQTtefKGKOro4t
	YXBbgOcrgJJ7VGlkmNZrxncUB9r3HJB7Uu8sc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K3wLoPoAjnwU50eOQLiUU8lWLkHeMLsP
	Bu0cZpD8qRimof5PTM4IHgcU5dnBpjRlAjEkXDHIp+FLGUG4A7+yb77M5uNfdIkO
	TqavSNfh3jywfdPUBo3UqOMH4/5RbpjvjuXpr0bOTLwoapwsJKl0fNjVX1upVCOS
	ZlMm8TgHEeg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D049B23FAE;
	Wed, 29 May 2013 17:29:15 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BB3D23FAB;
	Wed, 29 May 2013 17:29:15 +0000 (UTC)
In-Reply-To: <51a56e2db218d_807b33e18100177@nysa.mail> (Felipe Contreras's
	message of "Tue, 28 May 2013 21:55:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48D35AAC-C885-11E2-BCA9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225847>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> * fc/makefile (2013-05-26) 5 commits
>>  - build: do not install git-remote-testpy
>>  - build: add NO_INSTALL variable
>>  - build: cleanup using $<
>>  - build: cleanup using $^
>>  - build: trivial simplification
>>  (this branch is used by fc/remote-helpers-use-specified-python.)
>
> No, these are independent.

By the way, I dropped the order-only one and I explained my
reasoning for doing so, but I haven't heard back from you.

As I haven't used the order-only dependencies nor '|' myself so far
(primarily because I have not seen a case where it was needed), it
would have been nice if you responded with either "yes, this is not
order-only and the patch should be dropped", or "no, order-only is
correct because...".

In any case, I think the above remaining five were sensible changes,
and am thinking about having it graduating early in the cycle.

I somehow had an impression that the other series depended on this
for SCRIPT_PYTHON_* stuff, but this is about the installation step
and the other one is primarily about the build step, so in that
sense it may be independent.

>> * fc/remote-bzr (2013-05-28) 8 commits
>>  - remote-bzr: add fallback check for a partial clone
>>  - remote-bzr: reorganize the way 'wanted' works
>>  - remote-bzr: trivial cleanups
>>  - remote-bzr: change global repo
>>  - remote-bzr: delay cloning/pulling
>>  - remote-bzr: simplify get_remote_branch()
>>  - remote-bzr: fix for files with spaces
>>  - remote-bzr: recover from failed clones
>> 
>>  The ones near the tip conflicted with the hotfix for 1.8.3 so I
>>  discarded them for now.
>> 
>>  Will merge to 'next'?
>
> Didn't I resend these with the conflict fixed?

As the date above (05-28) shows, it seems that I did not forget to
drop the old one to replace with the new one, but I did forget to
remove the stale comment from the previous issue.  Thanks for
noticing.
