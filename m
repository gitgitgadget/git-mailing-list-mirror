From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] config: --get-urlmatch
Date: Tue, 30 Jul 2013 06:52:05 -0700
Message-ID: <7vsiywxiii.fsf@alter.siamese.dyndns.org>
References: <7vli4v66b3.fsf@alter.siamese.dyndns.org>
	<1375138150-19520-1-git-send-email-gitster@pobox.com>
	<1375138150-19520-4-git-send-email-gitster@pobox.com>
	<20130730003716.GA13114@sigill.intra.peff.net>
	<7vbo5kzv9k.fsf@alter.siamese.dyndns.org>
	<20130730081413.GC16693@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Kyle J. McKay" <mackyle@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 30 15:52:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4ALV-0007o1-Br
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 15:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705Ab3G3NwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 09:52:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46703 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753080Ab3G3NwI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 09:52:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B2D134C85;
	Tue, 30 Jul 2013 13:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ry03gIk7tkzhojMst/yul7HoCbU=; b=m58cBG
	+Zuyhs0eP7Jiy1/mkON5iBFq590zYLgu8zluyrylcHeOAxP1/nFql//IKXmuwFZ5
	MSDZE/lAyEeznlMffRE4E5/YMFGVTWICtyulsL7FHW/MVlPvZfQFhO9ym49uCmIO
	wyha6iPeq2/edEEDCHxA2P2xyYBHL/kQnLLKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YcMQQHNfymc41v23Aehc6hSK7xQak0oH
	dMxG0ZT+IP+HyV4a/fEXXYVkU6rRCczWN8vMaj0zisZaqRtyXDb2ipWeiUILnTGF
	wsze5A9anHvK7ZjgaPkSBTJvJqEpIzp0BVK6WM0mhuSoFUbVYRsHXgXy/ZqlIhlg
	edsQReSRnrA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D54534C83;
	Tue, 30 Jul 2013 13:52:07 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A702734C81;
	Tue, 30 Jul 2013 13:52:06 +0000 (UTC)
In-Reply-To: <20130730081413.GC16693@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 30 Jul 2013 01:14:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 38CF394E-F91F-11E2-B672-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231361>

Jeff King <peff@peff.net> writes:

> Ah, I missed that you could leave "key" empty.

Yes, the general syntax is

	git config [--<type>] --get-urlmatch <section>[.<key>] <url>

and giving <section> without a specific <key> would list all the
variables in the section that apply to <url>.

This is why we should do documentation at some point before
publishing a patch series; sorry about that.
