From: Junio C Hamano <gitster@pobox.com>
Subject: Re: recommendation for patch maintenance
Date: Fri, 21 Dec 2012 09:01:12 -0800
Message-ID: <7vvcbv1grr.fsf@alter.siamese.dyndns.org>
References: <50D475EF.6060303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 18:01:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm5yi-0008CN-Ln
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 18:01:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393Ab2LURB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 12:01:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55422 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091Ab2LURB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 12:01:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB214A5FD;
	Fri, 21 Dec 2012 12:01:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3DiHctsIt2xEEfI4kA/xnT+Czic=; b=jfcHBl
	Um6Y2w6ICgozatEGS4L/9Iz1La80H7HgR1nBxY27a0qJjrk8/1Df0f4WbE0F1cHe
	RvRaiki0AozCvTGPrCuv7VKkY00qLc/AkA23r/Cnnda4VLWt2ohJjWRyR6duLPrU
	zv4e6JpgDBgb5QEwTuUNvP2V+rKL1ZZnJsscE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yp/jbpt91wtkfIy64OaD+8NxnCT9he61
	C03xoSerk8FNFadA8d+mbk4UHZmgdWvIc/fpjNL/TTVnbAjwz7WZQGIbvzY+2/uf
	5B4tF7MY4ct4CMqTnzc6LDRjpNi0OyjYf6V7wH0r7zLgwk5Qx6Dw+LQpy6SX6m4y
	EDMet6SZrFM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5D4BA5FC;
	Fri, 21 Dec 2012 12:01:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E59BA5FB; Fri, 21 Dec 2012
 12:01:24 -0500 (EST)
In-Reply-To: <50D475EF.6060303@gmail.com> (Manlio Perillo's message of "Fri,
 21 Dec 2012 15:45:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0DA27F48-4B90-11E2-BB3F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211986>

Manlio Perillo <manlio.perillo@gmail.com> writes:

> I would like to have advices about some possible workflows to use when
> maintaining a patch, that can evolve over the time (fixing bugs, and
> applying advices from reviewers).
>
> In my case I have a single commit to maintain.
>
>
> The workflow I use now is this:
>
>   1) create a topic branch, e.g. mp/complete-path
>   2) write code
>   3) commit
>   4) format-patch --output=mp/complete-patch master
>   5) review the patch
>   6) send-email
>
> when I need to update the patch:
>
>   1) modify code
>   2) commit --amend
>   3) format-patch --subject-prefix="PATCH v<n>" \
>      --output=mp/complete-patch master
>   4) edit patch to add a list of what was changed
>   5) review the patch
>   6) send-email
>
> This is far from ideal, since all my local changes are lost.

Not offering any answer, but it is unclear to me what local changes
you are losing here.  Care to explain?
