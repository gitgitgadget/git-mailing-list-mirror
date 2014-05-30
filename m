From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git stash gpg prompting
Date: Fri, 30 May 2014 13:31:45 -0700
Message-ID: <xmqqr43b80um.fsf@gitster.dls.corp.google.com>
References: <CALp-zYGRLKJfC5rVygRg8adjsxP0h2dguNSYsvmcZxq7tcEQfg@mail.gmail.com>
	<20140530202413.GD5513@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eddie Monge <eddie@eddiemonge.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 30 22:31:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqTT2-0001pX-9b
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 22:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460AbaE3Ubw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 16:31:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51643 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811AbaE3Ubv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 16:31:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1F70D1BD76;
	Fri, 30 May 2014 16:31:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vZNcKFyhrS5KZME8n8JUhZ0MTjM=; b=P4hz0o
	Yy/VHlWmd3SHwBJa3L5qetBhX8RJNqOoIzadHHPt0vTDC/7zKB9XIktTQwaKe+mA
	7VrxIBzTQth7IBiNrf3PA5qVoDVxf8uXKlmVmp4xy2GV+0gWdHR1syGNJm1WIP8v
	8bug9QGYFGA8Hc3gDuq2+nnbPSayYF+xCsLVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PZPHIBMGaXCH7rOEzpAbnXd57PNthKBj
	y/1TGsjoCaMMhN3sI6vpTKca3uvtKS6VSu7eJ8LYXa0erUNls2KButmP+FY/NgTC
	gz06h2LE9gjNlhyUPBTGKTBPFG9JbqPtYXNwCOIAvVYcQVGsnuUlymchR8mzDGgJ
	hi9OKId2qb4=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 160BB1BD74;
	Fri, 30 May 2014 16:31:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 867661BD6E;
	Fri, 30 May 2014 16:31:47 -0400 (EDT)
In-Reply-To: <20140530202413.GD5513@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 30 May 2014 16:24:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6C195424-E839-11E3-A7E8-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250478>

Jeff King <peff@peff.net> writes:

> However, I wonder if it is really ever going to be sane to set
> commit.gpgsign and not use something like gpg-agent.
>
> For example, if you
> were to ever "git rebase" a patch series (or even just use "git rebase
> -i" to refactor commits), you would be prompted for your passphrase to
> sign each individual patch.

Correct.

I actually doubt it is sane to set commit.gpgsign to true and trust
gpg-agent, but that is a separate issue.
