From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 10/14] trailer: execute command from 'trailer.<name>.command'
Date: Fri, 07 Feb 2014 10:17:34 -0800
Message-ID: <xmqqfvnuvlc1.fsf@gitster.dls.corp.google.com>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
	<20140206202004.325.54178.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Feb 07 19:17:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBpzj-0007bf-Jf
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 19:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbaBGSRj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 13:17:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47627 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512AbaBGSRi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 13:17:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 291E369A31;
	Fri,  7 Feb 2014 13:17:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yB8JdYi4VUizoEivFkqDWcdw8pU=; b=vISvUa
	dV6EKLJCCtYdZOO83yU+9j69lloMXKoFIQiQkZSw/WHmydoH7JuS9HXGk5iJCD7C
	xbxfZC/7pSGicvyWE4mtP/SJDXiSlksomlw4LCk+4QtmUP4g/2B8Qpw19eMh1W5Z
	qWY4yJyW+KQCOVcRqcGuFbajvIgu0FD7Gk9us=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hl8Aq6Ke2gHabIa+PA3CrO0sSATRuW5c
	9FISHoC/4YPtiiEH03DxhSxKjDXCNWcr4ls7JjTJAgQHpzQopPqHuxnBZ8HfD4z3
	RinPQoW1CQLT4JJr8pnYobPkhaGQoAPvXuBzQjp7+OJCzHVX9bardYE7OOcUMQvb
	41bdE08Sh08=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1646769A30;
	Fri,  7 Feb 2014 13:17:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC44869A2C;
	Fri,  7 Feb 2014 13:17:36 -0500 (EST)
In-Reply-To: <20140206202004.325.54178.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 06 Feb 2014 21:19:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1F4667B2-9024-11E3-835B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241790>

Christian Couder <chriscool@tuxfamily.org> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

"execute command from ..." is fine, but I wish there were more
details before S-o-b line.  Is is not worth explaining what happens
to the output, and what the facility is used for in general?

Is it to give a string used for the value part?  "Key: Value"
string?  Is the command allowed to say "Put an entry with this
string before the existing one, after the existing one, or replace
the existing one"?  Can it say "Upon inspection of the existing
entry, it is no longer necessary to have it in the footer---remove
it"?
