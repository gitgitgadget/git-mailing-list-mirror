From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] remote-bzr: couple of fixes
Date: Sun, 05 May 2013 11:33:41 -0700
Message-ID: <7vd2t5uvi2.fsf@alter.siamese.dyndns.org>
References: <1367627467-15132-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 05 20:33:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZ3kx-0005MX-V8
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 20:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112Ab3EESdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 14:33:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49774 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751910Ab3EESdo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 14:33:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6FB11C081;
	Sun,  5 May 2013 18:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3wnlJdi0NvxTPnR/ICULfZjWv8s=; b=HsjvaR
	QDFj2pHdAVbgcigDFHQwnPR6AbxnhmzdfM0GjdNSGfi5mEEaLoX6bM2KPMcpkriP
	cryLSOt7E07V3HK6Ta7OG5pkrVfcgs3aTlJcEr0g4aVxK9k7VkzMltt5DNngUOAX
	MIvUQMs1UgycvA/u/Yw3L/38kPCXhAsKuBLTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E+ZjA25gsALY8kRN1i2/48OSfGtuYB5/
	y1WIBokAHXWvTaKyllWctDqEe19GGxWhEYjYjVvZBMvL8b1pYjNDn+vUldPoenUC
	MsQTDrQ9SnSjZwoSN6ooQlgnd9VK+bZKL9s3mRbUN5EJ2ewWc+fVJ+BjePw5zj0L
	t5ZdFiNAn4I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF7801C080;
	Sun,  5 May 2013 18:33:43 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CE7E1C07F;
	Sun,  5 May 2013 18:33:43 +0000 (UTC)
In-Reply-To: <1367627467-15132-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 3 May 2013 19:31:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 507FF764-B5B2-11E2-AA8A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223412>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The previous version had an indentation bug (did I mention I hate python?).
>
> A few fixes to be applied on top of the massive changes already queued. Nothing
> major.

[2/2] may not matter much in the context of my tree (people would
use post 1.8.2 fast-export if they are using remote-bzr from 1.8.3
from my tree ;-), but [1/2] sounds like it is a good thing to have
in 1.8.3 (not "on top of that 'massive' series").

Assuming the "otherwise some version of bzr might barf" problem is
that repo.generate_revision_history() in those versions may not
apply str() to its first parameter and the caller is expected to
pass a string there, or something?

Thanks.

>
> Felipe Contreras (2):
>   remote-bzr: convert all unicode keys to str
>   remote-bzr: avoid bad refs
>
>  contrib/remote-helpers/git-remote-bzr | 42 +++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
