From: Junio C Hamano <gitster@pobox.com>
Subject: sys/param.h
Date: Tue, 18 Dec 2012 09:01:52 -0800
Message-ID: <7vobhrgupr.fsf_-_@alter.siamese.dyndns.org>
References: <20121217213730.GA17212@ftbfs.org>
 <50D02B9A.1040906@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 18:02:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl0YX-0006C8-8k
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 18:02:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811Ab2LRRBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 12:01:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38701 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754484Ab2LRRBy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 12:01:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65386A0EF;
	Tue, 18 Dec 2012 12:01:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r4DZ8impjQaJ4ga/Ymf2WcqXXcU=; b=VrPYlk
	tqGsOhZa6XeoLnmTxfJusl9qZbjjD+U/jWVpOYk9BfQ6Kce7RFH2GLtrGjTlQier
	IUxHloNeT1SA3HQRwPFm3Bs7RJqnd52pIuzdsrW7dbKFtA5VCJl99SqQdIkPv0nj
	QLp7bIQ3yVzTDjtW0VL1quEm3yv6cyjBatWt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pFmBfKUEZoYIXDp6m5yCOD/GA7ABREbM
	xgqo1clD+owdg5lV5Mq36bQtB/mA4vfcOS84h9sZNi5D26hhue6OIRG1JssbH6ds
	wcds8/NShV5LD9DIFbxmRcNXo7+JTCBFz/zrxeTHgu24v9xPqbxaLyGkIlD+X+3L
	n1Xt8AzsjsU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52485A0EE;
	Tue, 18 Dec 2012 12:01:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0CF9A0EC; Tue, 18 Dec 2012
 12:01:53 -0500 (EST)
In-Reply-To: <50D02B9A.1040906@viscovery.net> (Johannes Sixt's message of
 "Tue, 18 Dec 2012 09:38:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F8529F0-4934-11E2-BFCC-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211762>

Johannes Sixt <j.sixt@viscovery.net> writes:

>> Junio C Hamano wrote:
>>> It could turn out that we may be able to get rid of sys/param.h
>>> altogether, but one step at a time.  Inputs from people on minority
>>> platforms are very much appreciated---does your platform build fine
>>> when the inclusion of the file is removed from git-compat-util.h?
>
> MinGW works fine with sys/param.h removed from git-compat-util.h.

It seems that OpenBSD 5.2 does not mind it getting removed, either.
Debian 5 and Debian 6 seem OK; so do Ubuntu 10.04 and 12.04.  I have
a hunch that Fedora or anything based on glibc would be fine, too.

What other platforms do we care deeply about?
