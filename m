From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Makefile: split GIT_USER_AGENT from GIT-CFLAGS
Date: Tue, 19 Jun 2012 13:38:56 -0700
Message-ID: <7vr4tbyr33.fsf@alter.siamese.dyndns.org>
References: <20120619195229.GA14692@sigill.intra.peff.net>
 <20120619200147.GB14714@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 19 22:39:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh5CY-0006up-Qo
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 22:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013Ab2FSUi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 16:38:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58679 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754992Ab2FSUi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 16:38:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28D669012;
	Tue, 19 Jun 2012 16:38:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eit/0jp/T2j6XJRYk5jGHgWVSgY=; b=pIlDhg
	kpAqago5EONBe1zbcd/+lh7drBhXwdCmG+xSxwFfY1m5lK5NFwZRELSLoHHpja7U
	GOOkWp1L/x+S8fPaZlGAWv9Sun3bpwtJvTDqRBeCxRXJKJP5bdO65IcnxziBj1t0
	N08W5JUsjmrfPXGHhJP/A+IlIfEMF5VvtHgmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RW2K1DW0FmxEdA+189ma/yxz/dfS0YJf
	sbEa7tqqZpaI8sAQZcf8lgd2BKa+/32tir8OQY3dkGITa84MkvLy8KsqAm29Xhz2
	wDlw+lypBF/9aam57JMN1WCdXgPee4bt8Q5ZBnAznPLpKlGe/jp/pVrzABX326eP
	9Lt+uh8Rqg8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FBE89011;
	Tue, 19 Jun 2012 16:38:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC2EF9010; Tue, 19 Jun 2012
 16:38:57 -0400 (EDT)
In-Reply-To: <20120619200147.GB14714@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 19 Jun 2012 16:01:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB32E242-BA4E-11E1-89B4-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200241>

Jeff King <peff@peff.net> writes:

> The default user-agent depends on the GIT_VERSION, which
> means that anytime you switch versions, it causes a full
> rebuild. Instead, let's split it out into its own file and
> restrict the dependency to version.o.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This can't just depend on GIT-VERSION-FILE, since the user may have set
> GIT_USER_AGENT independently, and we would want to trigger a rebuild in
> that case.

OK.  Will queue.
