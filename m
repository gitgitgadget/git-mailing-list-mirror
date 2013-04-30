From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] cygwin: Remove the CYGWIN_V15_WIN32API build variable
Date: Tue, 30 Apr 2013 10:05:35 -0700
Message-ID: <7vtxmodk4g.fsf@alter.siamese.dyndns.org>
References: <517C29F8.7090709@ramsay1.demon.co.uk>
	<20130429060123.GD8031@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 19:05:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXDzt-0000KW-MJ
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761224Ab3D3RFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:05:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43960 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761097Ab3D3RFi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:05:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80BF2187E6;
	Tue, 30 Apr 2013 17:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NzFjEVhmVyysLMFzb3r9Gu3ok5g=; b=HKlzNS
	KGrF4Kx4iqE3Hbj9MS+MNdiqwS7iA9z6Y0EX2Ca01qh0spYDhn7rOD0CmlS1cXVO
	joDMPYW74HhAGMHjo2eaUe1mMCcBSykO65M/0P2iWhECgBgAHlzwfBB+3iaAb271
	gxzIM88J+qb2wdfq8tJRjysdx6eQ3EQNWrJhE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J1+Ra/oebpNX9v2kcCJaPYlEBtemoJYs
	HcIUAggtIlHij9ADdm9NMjh6TnahMJNeIwBccuhFW43qmi5sY46BGWL/jj+apNBT
	ZomCjXJXKx11nqAGEIusSsXu7qKaLOuzfj/1IPjF6zrcoZVKcXbvLHIOuJpZFC2t
	uwo4+LAV8rA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74034187E5;
	Tue, 30 Apr 2013 17:05:37 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5420187E3;
	Tue, 30 Apr 2013 17:05:36 +0000 (UTC)
In-Reply-To: <20130429060123.GD8031@elie.Belkin> (Jonathan Nieder's message of
	"Sun, 28 Apr 2013 23:01:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D6E9ECC-B1B8-11E2-A4ED-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222950>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The reordering made in v1.8.1.1~7^2~2 still seems like voodoo to me,
> but at least it works.  This patch applies that same order for
> everyone.  Systems that would previously use the "I have old win32api
> and don't need that reordering" codepath don't need to be
> special-cased any more, since *their* particular brand of trouble is
> avoided by being careful about how to use the WIN32 macro.
>
> The upshot:
>
>  - No change on modern setups.  To uninformed people like me I feel
>    like there is still something subtle going on that is not well
>    understood, but hey, this patch doesn't break it. :)
>
>  - Tested to still work on setups that previously needed
>    CYGWIN_V15_WIN32API.  Yay!
>
>  - This drops an #ifdef, which means less code that is never tested
>    to keep up to date.
>
> With or without a few words of explanation in the commit message to
> save some time for the next confused person looking this over,
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.  Ramsay, I tend to agree with Jonathan that this change
deserves a bit more explanation.
