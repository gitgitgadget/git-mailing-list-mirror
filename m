From: Junio C Hamano <gitster@pobox.com>
Subject: Re: libgit2 status
Date: Mon, 27 Aug 2012 10:10:42 -0700
Message-ID: <7vfw78s1kd.fsf@alter.siamese.dyndns.org>
References: <87a9xkqtfg.fsf@waller.obbligato.org> <5038A148.4020003@op5.se>
 <7vharpv77n.fsf@alter.siamese.dyndns.org>
 <nnglih0jotj.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, <greened@obbligato.org>,
	<git@vger.kernel.org>
To: <dag@cray.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 19:10:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T62pw-0001Vo-9y
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 19:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688Ab2H0RKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 13:10:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49191 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753613Ab2H0RKo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 13:10:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DB006BE6;
	Mon, 27 Aug 2012 13:10:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NjZ3qLP8fo26orQK8YvPdRHNnmg=; b=UoQzSA
	PUzpGnXZVydxf3zHkCyktJnPuwxQpcxFG3ybfBFNTJ8hP6s0jD+Rwyeg9XirkOmQ
	Al1APadT5lx9uv4S5Hsts+QALm8TVl62M6X2atbTt5YcCk83nODsLLofDKQ0YSTg
	jU0BFj3ydShBq+pTxZQxF9DwV9GK9PAncAtq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uSBlM4qL4qQxkbj6ReOK00xd4HBS4VYB
	g6i6KI/1EO0t0IuMp0KExHAIF8+MJnbpFhEyJOdlT5AyFIWIw9PvMrqztaL0DSC4
	MNs19xrnlC3rFCkHVBLbXyAuYbWsHOVhUPT12p1t9av+AFMDOzU8qP5lknPSLfAx
	5sqQJJBFysI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A8316BE5;
	Mon, 27 Aug 2012 13:10:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD4286BE3; Mon, 27 Aug 2012
 13:10:43 -0400 (EDT)
In-Reply-To: <nnglih0jotj.fsf@transit.us.cray.com> (dag@cray.com's message of
 "Mon, 27 Aug 2012 11:13:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 22D0EAD4-F06A-11E1-BEA0-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204358>

<dag@cray.com> writes:

> I am hoping to move git-subtree into core once it performs a little
> better and I've fixed a couple of bugs.  Will basing it on libgit2 delay
> that process significantly?  Six months delay is no problem.  2 years
> would be problematic.
>
> I would be happy to be a guinea pig for libgit2 in order to improve it,
> but I don't want to significantly impact git-subtree's move to core.
> I'll have to figure out the right balance there given feedback.

I expect it will take some time for libgit2 to allow our Makefile to
start saying "LDFLAGS += -libgit2"; it will need to become as stable
and widespread as other libraries we depend on, e.g. -lz and -lcurl.
