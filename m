From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: Use the term "remark" in "cherry-pick -x" to
 disambiguate from "git notes"
Date: Fri, 15 Apr 2011 10:12:07 -0700
Message-ID: <7v7have8wo.fsf@alter.siamese.dyndns.org>
References: <4DA7F73B.9050007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 19:12:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAmZC-000055-JR
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 19:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333Ab1DORMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 13:12:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61953 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005Ab1DORMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 13:12:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0788C4E01;
	Fri, 15 Apr 2011 13:14:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BVN//fQ9yeyTRqHhZ8hHmzGe/fk=; b=VJrq9T
	BmSBabyJuOxK1YMHAH6x/laHsDqkvsnWAay4bn+Nk4i3wEDw46D8RtmmR6uu/Qpp
	+lCpDOLHHTTd3O2kBO+Ru3BjpGlsIvh87owiY4C5LpGrLKWDetCMQq2vtzKwNjQ6
	MsZ43GigFEjNi67mknaEcs8UDUFuDmkMUzik0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PLXRC1RVf/aZtDFV7P0RdG8/A67YinHh
	xSuX118GSVqZMY81GGnmNoUlJTP6BX8T/XmRtrwOCCDiV5p+J3J4UmTnN4t4c761
	mq9cddfDxx4f097j2ufBjtgCmbPmboq7yumFS7OHNWJdI2Fec1tJ0OmJqjN/SsYG
	tJEodwyFGeQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CA1204DFF;
	Fri, 15 Apr 2011 13:14:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BD6C94DF2; Fri, 15 Apr 2011
 13:14:07 -0400 (EDT)
In-Reply-To: <4DA7F73B.9050007@gmail.com> (Sebastian Schuberth's message of
 "Fri, 15 Apr 2011 09:43:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C78B47DE-6783-11E0-BA87-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171618>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> The documentation for "cherry-pick -x" can be misread in the way that a
> "git notes" object is attached to the new commit, which is not the case.
> Instead, just some text is appended to the original commit message. Make this
> more clear by simply using the term "remark" instead of "note".

A sensible concern, I guess, even though "_append_ to the original _commit
message_" should signal that this sentence cannot be referring to a note
object separate from the commit.

> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index 01db830..5afc2b0 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -52,8 +52,8 @@ OPTIONS
>  
>  -x::
>  	When recording the commit, append to the original commit
> +	message a remark that indicates which commit this change
> +	was cherry-picked from.  Append the remark only for cherry
>  	picks without conflicts.  ...

I wonder if it is better to be even more explicit and say:

	... append a line that says "(cherry picked from commit ...)" to
        the original commit message in order to indicate which commit this
        change was cherry-picked from.  This is done only for ...

so that we don't have to worry about having to change this in 10 years
when we notice that description can easily be misread that it is done
using the remark feature introduced a few years back?
