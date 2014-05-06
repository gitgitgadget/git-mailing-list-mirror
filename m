From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] contrib/subtree/Makefile: Standardisation pass
Date: Tue, 06 May 2014 14:17:03 -0700
Message-ID: <xmqq7g5yehf4.fsf@gitster.dls.corp.google.com>
References: <1399380109-3805-1-git-send-email-nod.helm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: James Denholm <nod.helm@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 23:17:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whmji-0003VW-ER
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 23:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbaEFVRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 17:17:10 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60691 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719AbaEFVRI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 17:17:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4219D15928;
	Tue,  6 May 2014 17:17:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g056AmlBqWc3RrcXGBLoY10TajI=; b=tLSBQZ
	+5ioXFV5TK9/fvVV8henERJY4M7+nZUv59c/ZQucq9GPQzLDFOhcxmDunw2j+gXJ
	KCfUwaUSryMMIY1O9q6TGMB/oTsTYG7c5jmjx0Rsl9Ivs1wk85Nq6g8f0sWE/EH9
	Wx3+NoVCJPMOs/oJFACvsVCfoZgGLFOBV/lgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jZWV5Esp0s0PIa8a6iGl+QQ7EGl4bhpN
	0rS/T4NFeirBnaxaYyQTzggdjY6Sjc96Drc9xQf/FqTKY0pepBiESP9J/sssKPOm
	PsyJf2nRYMJEA8l3IgSPrRFAuRKFwe/oLVJ3dmq3GAdp4QBG2bGX16ThsGeDWgVq
	HiKUqxCPf3g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 36EE115927;
	Tue,  6 May 2014 17:17:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C70B815925;
	Tue,  6 May 2014 17:17:04 -0400 (EDT)
In-Reply-To: <1399380109-3805-1-git-send-email-nod.helm@gmail.com> (James
	Denholm's message of "Tue, 6 May 2014 22:41:44 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C5CCE492-D563-11E3-BC02-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248254>

James Denholm <nod.helm@gmail.com> writes:

> contrib/subtree/Makefile is a shambles in regards to it's consistency
> with other makefiles, which makes subtree overly painful to include in
> build scripts.
>
> The main issues are that calls are made to git itself in the build
> process, and that a subtree-exclusive variable is used for specifying
> the exec path. Patches 1/5 through 3/5 resolve these.
>
> The "cleanup" fixes (4/5 and 5/5) are based on precedents set by other
> makefiles across the project.
>
> One problem is foreseen: 3/5 will necessitate that package maintainers
> who already have git-subtree included in their packages update their
> build-scripts.
>
> Reviewed-by: Jeff King <peff@peff.net>
> Signed-off-by: James Denholm <nod.helm@gmail.com>
> Based-on-patch-by: Dan McGee <dpmcgee@gmail.com>

It is funny to see sign-off on 0/5 ;-)

By the way, this is v3, not v2, no?  It was somewhat confusing to
see Peff saying "filfre to add my reviewed-by" on v2, noticing you
posted something new, and not finding v3.

Will queue.  Thanks.

>
> James Denholm (5):
>   contrib/subtree/Makefile: scrap unused $(gitdir)
>   contrib/subtree/Makefile: Use GIT-VERSION-FILE
>   contrib/subtree/Makefile: s/libexecdir/gitexecdir
>   contrib/subtree/Makefile: Doc-gen rules cleanup
>   contrib/subtree/Makefile: clean rule cleanup
>
>  contrib/subtree/Makefile | 38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
