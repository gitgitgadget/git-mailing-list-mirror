From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] lockfile: fix buffer overflow in path handling
Date: Sun, 07 Jul 2013 10:29:19 -0700
Message-ID: <7v7gh25le8.fsf@alter.siamese.dyndns.org>
References: <1373140132-12351-1-git-send-email-mhagger@alum.mit.edu>
	<20130707041236.GB30898@sigill.intra.peff.net>
	<51D94225.1010803@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jul 07 19:29:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvsm7-000058-A5
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 19:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab3GGR3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 13:29:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35894 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752736Ab3GGR3X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 13:29:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75E932AB0C;
	Sun,  7 Jul 2013 17:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hTMdEWj/bCqOiiEdXcD1kje7xHk=; b=NIr4q9
	Dl/nLBIUeqPYqcNpoyN4tehv7bc86CX7cBGpSQ28/iDsyF/UXQHxFd78o7chWmIZ
	1XhlVTTMr15TwYNMQgiCXOIg052hQvvJvHs5EZigome5c+IsHVK72c/aVZNNykPi
	PSwEqOAYMH/qbq2fdW/kZF+Lp6kZAOKqECuhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qS/a0gyHgVSfoagB0CAt8XirjBVsWXHV
	EWB4TTV5acF2J1pOfRNvJyl9mM6u4qn2wd9jHAzZXaQQoCJ4wYzs6wxgCxNwP6Lb
	A88ipo+vYJ6Vz+AnmI0YGCNrU2ocevYDDV54n6E63Dek6QW+DRMUlZmN8u8Mw8jn
	GwswuUW0YBA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D41E2AB0B;
	Sun,  7 Jul 2013 17:29:22 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2A462AB02;
	Sun,  7 Jul 2013 17:29:20 +0000 (UTC)
In-Reply-To: <51D94225.1010803@alum.mit.edu> (Michael Haggerty's message of
	"Sun, 07 Jul 2013 12:25:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C252428A-E72A-11E2-85FF-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229780>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> But either way, the fix looks good to me.
>
> Yes, the constant is an improvement and Peff's version is also fine with me.

OK, will squash in.  Thanks both.
