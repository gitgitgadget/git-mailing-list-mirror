From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] t0000: verify that real_path() works correctly with
 absolute paths
Date: Sat, 08 Sep 2012 21:50:53 -0700
Message-ID: <7vfw6ru7de.fsf@alter.siamese.dyndns.org>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
 <1346746470-23127-6-git-send-email-mhagger@alum.mit.edu>
 <7v627q21hl.fsf@alter.siamese.dyndns.org> <504C1B8A.3000406@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Sep 09 06:51:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAZU7-00077f-P1
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 06:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800Ab2IIEu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 00:50:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42860 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411Ab2IIEu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 00:50:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8884C9FB1;
	Sun,  9 Sep 2012 00:50:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P3csKwbCey8a/Wil68b5vRA0saE=; b=hDlm2J
	1SMiZL8BDFm2G5QDap85HlsWh4snq/oaqcCBroI/3OmHwIWtxRaHbXqzAVKDb1JM
	p8lYh7BcNE3zN6TBUJsNpcs62bX2/L+z8sxEicmc/RH189AxY01ShE+swj64HXep
	ElkWXFQeiPlB+u8pU2VyABwE3PQLq8biQEmOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mPo76606DVXdiwVQ8yX/2XBk5WWLunkv
	ggNd0+YcA4T316HBzX9A7D+T+FZR6fDcJOX/n28Uy1s4L61gsrXRAc6vXmjD5EJs
	TiEil/pCvg/E9ivwHt9uV7qwWIlC599GVQg3qRgX0RoFnJ3kNfkqfIQbiOmNMgvI
	TJ0ryDSYHfQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75F8F9FB0;
	Sun,  9 Sep 2012 00:50:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94A9D9FAE; Sun,  9 Sep 2012
 00:50:54 -0400 (EDT)
In-Reply-To: <504C1B8A.3000406@alum.mit.edu> (Michael Haggerty's message of
 "Sun, 09 Sep 2012 06:31:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F01A4AFC-FA39-11E1-B036-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205042>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The possibility is obvious.  Are you advocating it?
>
> I considered that approach, but came to the opinion that it would be
> overkill that would only complicate the code for no real advantage,
> given that (1) I picked a name that is pretty implausible for an
> existing file, (2) the test suite only reads the file, never writes it
> (so there is no risk that a copy from a previous run gets left behind),
> (3) it's only test suite code, and any failures would have minor
> consequences.

(4) if it only runs once at the very beginning of the test and sets
a variable that is named prominently clear what it means and lives
throughout the test, then we do not even have to say "hopefully" and
appear lazy and loose to the readers of the test who wonders what
happens when the path does exist; doing so will help reducing the
noise on the mailing list in the future.
