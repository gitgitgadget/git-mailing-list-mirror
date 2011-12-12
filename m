From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Makefile: optionally exclude code that needs Unix
 sockets
Date: Mon, 12 Dec 2011 15:31:44 -0800
Message-ID: <7v1us91i5b.fsf@alter.siamese.dyndns.org>
References: <20111210103943.GA16478@sigill.intra.peff.net>
 <20111210104130.GI16648@sigill.intra.peff.net> <4EE66DAB.5070407@kdbg.org>
 <4EE66E58.6040404@kdbg.org> <20111212213951.GB9754@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 13 00:31:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaFLe-00089m-K3
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 00:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383Ab1LLXbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 18:31:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37378 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753367Ab1LLXbs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 18:31:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56A076BC9;
	Mon, 12 Dec 2011 18:31:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HLHYTUcrPoWIUrbf+5itNs9Qgvg=; b=Z/wuln
	h86zaypkVgFNRR2V65G3doDDIwcklFpnAHJLgMfNX+YL3Em6XtYA5NGru0Eu2Sfi
	ZA5oFfcoGr/pjwgYRiGrkmDizTk26PbJXlHj06Lh7q53kROBBpZ15GvieODhI1yo
	vUTe2eCiB8sPJfuWobdFnkffwg3eM4gd3FSSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r5sQyhMAIwBmGu/+tWa2AopaRgmC9NCr
	ibbJZ6EZeC/lh/U7c61+2/vh4cIY9qs7PlPro1UPinYFNjKUWzO7t61r0blPcj2f
	xm5gQ2XXCF5r9VE0IImPVHJ4CGkea020muSXS0s/WSqt+Hkz2NSOm1hksJAe5WO2
	joq1QoKoa8Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EA8B6BC1;
	Mon, 12 Dec 2011 18:31:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA2516BC0; Mon, 12 Dec 2011
 18:31:45 -0500 (EST)
In-Reply-To: <20111212213951.GB9754@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 12 Dec 2011 16:39:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74A28204-2519-11E1-A198-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186972>

Jeff King <peff@peff.net> writes:

> In theory we should also disable the documentation for credential-cache.
> But that means surgery not only to Documentation/Makefile, but figuring
> out how to pass the flags down to the actual asciidoc process (since
> gitcredentials(7) mentions it in the text). Certainly possible, but I
> don't know if it's worth the effort or not.

I do not think it matters that much. We've been shipping documentation for
stuff like remote archiver and daemon without conditional compilation, no?
