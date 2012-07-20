From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Fri, 20 Jul 2012 08:39:23 -0700
Message-ID: <7vpq7qtpas.fsf@alter.siamese.dyndns.org>
References: <20120719213225.GA20311@sigill.intra.peff.net>
 <20120719213311.GA20385@sigill.intra.peff.net>
 <7vy5mftm3q.fsf@alter.siamese.dyndns.org>
 <20120720144337.GA31946@sigill.intra.peff.net>
 <20120720150726.GA2862@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexey Muranov <alexey.muranov@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 20 17:39:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsFIi-0002th-Ih
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 17:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125Ab2GTPj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 11:39:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64672 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753101Ab2GTPj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 11:39:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2F857847;
	Fri, 20 Jul 2012 11:39:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YT8qKUqvg1l6aKYzhaEIYy/4ato=; b=crzSxU
	Zkk2MXp3zDAc8uPr01Xet4HFGQXIKKaaqeFZbv4eXEnAAduDypHpc5tgydZbb+QS
	hypudp/1Pe1tviEsuoI376jN+WymPpCvxhvdG3nlLX5ucOQTYACJ9amTdWFE0z+u
	FZeIPNYWtcbWGIevJoBV4vYEw5/OIwFVDoYJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KIW+40WKk310fqtv7WwFaWQ5Df/5zLWQ
	NBKGcLUevZ+xozYJxvYlcFTC5JS1d7NDB0TIMia/MscBa+mK+UGxLBmUO+Pub01Y
	Csm/ZKRxOalSFaJ4nKHLZl4yzo/+LARj4H13HD6YpDUQTIM+32E62tMPY0r4TpJA
	k9WwYhiLI48=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E08B47846;
	Fri, 20 Jul 2012 11:39:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6044A7843; Fri, 20 Jul 2012
 11:39:25 -0400 (EDT)
In-Reply-To: <20120720150726.GA2862@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 20 Jul 2012 11:07:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15ABDA00-D281-11E1-9B98-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201773>

Jeff King <peff@peff.net> writes:

> I noticed I ignored the "discover" and "delete" parts of your paragraph.
> As far as deletion goes, I think we can ignore it; expiring all entries
> is equivalent.
> ...
> In other words, I want to focus on getting the ref-level plumbing right,
> and then we can care about the porcelain later.

Yeah, I agree that is a reasonable way forward.  for-each-ref with a
new option (--include-dead or something) can wait.
