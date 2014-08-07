From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/11] git_config callers rewritten with the new config-set API
Date: Thu, 07 Aug 2014 13:10:59 -0700
Message-ID: <xmqqsil8jc18.fsf@gitster.dls.corp.google.com>
References: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 22:11:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFU1s-0008Jt-6o
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 22:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885AbaHGULL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 16:11:11 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53788 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890AbaHGULI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 16:11:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5F0242DAE0;
	Thu,  7 Aug 2014 16:11:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pS0blQRnntip04Wic4ctyZ02Tt0=; b=viB98K
	lC+vNhKpmJUFiifbTepmvjvAPWPx/mtDAZp+/ZuQG0YimmEJpci82mxbvs1jp6Xu
	RC1F8ozaO0NarSgS1fTNLieOoa+6l2B+R75rrale0WFKUEqAxyuBYFT54anznULt
	kT1MXrTG3+SEVaJ36vCvAJuzPqIVmFqVDxoro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ENJLr3my3eyb4DkTscjWWMjkXSQUWHtE
	TVPwfP/WK61eq9aEpQDKFq/KLOJsRxOQTGqdnYUeaDbQWREtcrKa/E9OO75AL8XQ
	ARvprSahMoplQHnyhU619AV1Suf0zYjPBHDVFn2jx9y4MEWHGVbKxu7DcKYGbUX4
	4ASIYGxkEOo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 540542DADF;
	Thu,  7 Aug 2014 16:11:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 98AEB2DAD7;
	Thu,  7 Aug 2014 16:11:01 -0400 (EDT)
In-Reply-To: <1407428486-19049-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Thu, 7 Aug 2014 09:21:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F3FC2FD6-1E6E-11E4-B79E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254994>

Tanay Abhra <tanayabh@gmail.com> writes:

>  11 files changed, 114 insertions(+), 250 deletions(-)

Nice reduction.
