From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] diffcore-pickaxe doc: document -S and -G properly
Date: Sun, 02 Jun 2013 12:56:15 -0700
Message-ID: <7v7gicnv6o.fsf@alter.siamese.dyndns.org>
References: <1369391635-13056-1-git-send-email-artagnon@gmail.com>
	<1369391635-13056-3-git-send-email-artagnon@gmail.com>
	<7v38tcb7yx.fsf@alter.siamese.dyndns.org>
	<CALkWK0m+kUa0QUotHXSYK40vFviFFv2yETnf6sEZMh05gOgLKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 02 21:56:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjEO7-0007wk-1U
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 21:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756294Ab3FBT4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 15:56:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63510 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756241Ab3FBT4S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 15:56:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB973246A1;
	Sun,  2 Jun 2013 19:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UBovx6T9wSVd7RTKf37CnVUfcEI=; b=YhVtZL
	LkBQRbzLlI+5HHthuA6VsHZjHfxugd1niOB8jgb2iEv2U0s3mQROPdbPRJfCBA5p
	pwSLHOF3QIHp5WK2jSMvD2PdMg3Ql7GwmPmmdWdj858SwQWt+rKe10LR2R6b2pk9
	ugIoWXc3ta2M0vqrVK/fL9O0rSVLeb8EcL7FM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NKAoIyFuthw1uGVVKpcTlr9PTJlHtWH6
	QctiC8tD7jZru8qIh0w/OfoxXAR5+/DSabBxT/EnNmuast/LjzS+D+PaOYbfVFE4
	h+l88FXwn+O7fhoRdqcfgJPUEvqF2yWdlAWTVYX/yJ5md+aijtY6enCjW/yw+MOD
	UyH6IuIbYjM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B29CF246A0;
	Sun,  2 Jun 2013 19:56:17 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F32A2469D;
	Sun,  2 Jun 2013 19:56:17 +0000 (UTC)
In-Reply-To: <CALkWK0m+kUa0QUotHXSYK40vFviFFv2yETnf6sEZMh05gOgLKg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 31 May 2013 17:34:54 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7CC4B89C-CBBE-11E2-99E8-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226179>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>>         Without
>>         --pickaxe-all, only the filepairs matching the given
>>         criterion is left in the output; all filepairs are left in
>>         the output when --pickaxe-all is used and if at least one
>>         filepair matches the given criterion.
>
> Why do a poor-man's version of --pickaxe-all here, when the last
> paragraph already does justice to this?

The point of the first paragraph is to serve to help both:

 (1) people who read about this rather technical part of the
     diffcore pipeline machinery, to prepare them by listing what
     they will learn about in the section; and

 (2) those who already have read and want to skim over, by giving a
     concise summary.

It may have been "poor" because it was merely "something like this"
patch, though.


> While what you're saying is technically true, I think it is important
> to explain the interaction between diffcore-pickaxe and
> diffcore-rename as I have done.  Someone who wants to understand what
> `git log -S` does will come to this page and read this section:
> without reading diffcore-rename, she will have an incomplete picture;
> what's the harm in explaining diffcore-rename in the context of
> diffcore-pickaxe?

That is a red-herring; that is exactly why we upfront say that the
diffcore machinery is a pipeline and we describe upstream processing
like rename before we talk about pickaxe in the same document.

This document is the most accurate _technical_ documentation of how
the pipeline works (and it is not in section 1 of the manual set).
If you want to improve end-user documentation by adding explanation
for interactions between pipeline stages and also pathspec, I am all
for it, but I think that belongs to the larger "git help diff", not
"git help diffcore".
