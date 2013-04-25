From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-bzr: use proper push method
Date: Thu, 25 Apr 2013 15:32:26 -0700
Message-ID: <7vobd21bt1.fsf@alter.siamese.dyndns.org>
References: <1366889137-19700-1-git-send-email-felipe.contreras@gmail.com>
	<87haiu7jgn.fsf@linux-k42r.v.cablecom.net>
	<7v1u9y2u4q.fsf@alter.siamese.dyndns.org>
	<CAMP44s2-QZxuV-bXc_0zeqxJDy=Y6AAC0iwgbjNDNuCaaMcErA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 00:32:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVUiP-00038r-Uu
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 00:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933299Ab3DYWca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 18:32:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54135 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932396Ab3DYWc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 18:32:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6D8419FE8;
	Thu, 25 Apr 2013 22:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H88SK2vn/H39X3F2CaHPm96bLss=; b=jF/b5K
	g6Mmn7ah6thqiXvrxmX2hkIF9k0WtZzUugYYUfvowu40xu+M/hLUJH9Hlh6ynVh9
	d8IsMAQjvwez/URl3rN7d+05dwCShL4f+B1pEeVqcO0t9APLAczCmMw0echbFNAR
	Gyc94a7AqPMkBlzoWFTpIgeZQjx2Vbv1Sa4sg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CQXt7aVJhzSwLXuAY957ECosalWLFno1
	x8FRLPpq8iCdJF6Pll6bma2szUgXBLo/recVWRJc43vMxNmHLB7a5/v8pw8XkOY7
	EklWy+etkcIjkBto1EAWZcHRrNmojm8KaAIlNcMoPKCXdnsVplH9fDMphS5qGjUV
	73371d+rW38=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAA0D19FE7;
	Thu, 25 Apr 2013 22:32:28 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DB0A19FE4;
	Thu, 25 Apr 2013 22:32:28 +0000 (UTC)
Importance: high
In-Reply-To: <CAMP44s2-QZxuV-bXc_0zeqxJDy=Y6AAC0iwgbjNDNuCaaMcErA@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 25 Apr 2013 16:41:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 02A8B146-ADF8-11E2-81E8-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222458>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> My gut feeling is that we should do it the way the Bazaar UI does it,
> I don't have any evidence that there's anything wrong with the current
> code, which Bazaar seems to but have, but for different purposes which
> are hard to explain. I would rather avoid surprises.

That is actually a very fine description for this change ;-).

commit 473b7aac9f542dc22cfff0c264e96d8dbbd9d895
Author: Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu Apr 25 06:25:37 2013 -0500

    remote-bzr: use proper push method
    
    Do not just randomly synchronize the revisions with no checks at
    all.
    
    I don't have any evidence that there's anything wrong with the
    current code, which Bazaar seems to use, but for different purposes.
    Let's use the logic Bazaar UI uses to avoid surprises.
    
    Also, add a non-ff check.
    
    Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
