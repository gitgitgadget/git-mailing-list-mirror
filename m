From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Fix a race condition when reading loose refs
Date: Tue, 11 Jun 2013 13:57:59 -0700
Message-ID: <7v61xk9xgo.fsf@alter.siamese.dyndns.org>
References: <20130507023802.GA22940@sigill.intra.peff.net>
	<1370960780-1055-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 11 22:58:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmVdr-00022Q-8R
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 22:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754978Ab3FKU6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 16:58:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41094 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754753Ab3FKU6F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 16:58:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2468427643;
	Tue, 11 Jun 2013 20:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TvsQF6oQbdAjLYHLK+6NHEnBxlQ=; b=U50GA0
	tFwqjjrVoGT1coK6LupwryvBa9QsEj91WyKBg0bnZOEgIhHuGfIo5otXr2tAgomZ
	+EUPOwHYox73uOGmyIfhD4EDbpWmLLv6J4oHx2AFNslI2wACmOlwvfmK52nrseRm
	WfigCcnU9yAdT6wgjP7e/c3Ojr1Jyp1UpQOHM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZnLyaGwOpBeYsdi92c6dc6wcXEwvns4R
	CLB3h+Uba/6msmFKNAJA4x5/PhbMyjSkx8XpSW41s2Q1wnRjqvOTDg8Yl5ZViWu8
	DqZC0mlnKSoezLAWFL6r1wqSKR2paBKkj89sXQYYsoWwnzS463X1tkwojS+zaBHU
	r+tHgYg1t6A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DB792763F;
	Tue, 11 Jun 2013 20:58:03 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D7F827633;
	Tue, 11 Jun 2013 20:58:02 +0000 (UTC)
In-Reply-To: <1370960780-1055-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Tue, 11 Jun 2013 16:26:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B21EC7A-D2D9-11E2-82B2-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227515>

I've read the series while on a bus and found all of them sensible.
I do share the worry of retry storm you expressed in the last one,
and I agree that giving up after N times is a reasonable way out,
when it becomes necessary.

Thanks.
