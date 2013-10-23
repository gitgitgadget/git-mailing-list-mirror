From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Working patterns
Date: Wed, 23 Oct 2013 14:44:19 -0700
Message-ID: <xmqqa9hzpsr0.fsf@gitster.dls.corp.google.com>
References: <201310232023.r9NKNr5v012288@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: worley@alum.mit.edu (Dale R. Worley)
X-From: git-owner@vger.kernel.org Wed Oct 23 23:44:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ6E8-0004AP-2b
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 23:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826Ab3JWVoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 17:44:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58927 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752660Ab3JWVoX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 17:44:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8F4C4D7D5;
	Wed, 23 Oct 2013 21:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D8/t3m8Shll9YhQld4o+W38jeEk=; b=G7Lrdn
	JU54/m/ewKaAWsJYXprA9fJyYCHtcbvvv9NtDxjzxYxuW1osFrtuZXvP4PF07zz3
	zzqO7wGShqIm3S+iMOUmbWLWrJQXX0aoieBxzA1pNBWwjf0jdQRM0Oa/YFVTyDY5
	tBF/Ep4qP568OMCBDLDu+wr0RUukmRH/o5ow4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TcT1CLBMdtDSbKQfCDgoQlka83hDIX9a
	OpfiyplMAjFNDb8er6nNNKf98Crb4sxgzzRIkQDq2+BJGXH6yra1eRkb8pSh/Owr
	hid7dy2WpG43+nXhRVXa9FyRoE30Wtx2pJ6Uohh//6YCCP/KDBsC+/BLGfTNvLWn
	7BNXJMkv6UI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADA084D7D4;
	Wed, 23 Oct 2013 21:44:22 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EEE244D7D1;
	Wed, 23 Oct 2013 21:44:21 +0000 (UTC)
In-Reply-To: <201310232023.r9NKNr5v012288@freeze.ariadne.com> (Dale
	R. Worley's message of "Wed, 23 Oct 2013 16:23:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4712C20A-3C2C-11E3-A736-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236554>

worley@alum.mit.edu (Dale R. Worley) writes:

> It seems to me that the two sets of Git commands should be invokable
> under the same circumstances, that there is a design specification as
> to how Git can be invoked, and both implementations should match that.

As far as I know, the design for any (be it script or command) is
that they should be able to run from the top-level and from any
subdirectory within, but running from outside the top-level of the
working tree has never been part of the design goal.  If some
commands tolerated it, that was by mere accident and not by design.
