From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Q] Determing if a commit is reachable from the HEAD ?
Date: Fri, 20 Jan 2012 16:04:50 -0800
Message-ID: <7vzkdhdiot.fsf@alter.siamese.dyndns.org>
References: <201201201433.30267.brian.foster@maxim-ic.com>
 <m2ehuu8nrt.fsf@igel.home> <20120120180620.GA8504@codeaurora.org>
 <7v7h0mfahx.fsf@alter.siamese.dyndns.org>
 <20120120233335.GA20302@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Brian Foster <brian.foster@maxim-ic.com>,
	git mailing list <git@vger.kernel.org>
To: David Brown <davidb@codeaurora.org>
X-From: git-owner@vger.kernel.org Sat Jan 21 01:04:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoOS2-0007N8-IA
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 01:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172Ab2AUAEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 19:04:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40425 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755935Ab2AUAEx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 19:04:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43BB276EF;
	Fri, 20 Jan 2012 19:04:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OqyfXYxDxVTKvY0ZW6qwlUVaUaM=; b=gZBFtH
	GeOvP/hWPN0dNaoS30G0p3NmFBvmpRGJgxMQ0qdjAX/B/YdumryDPrCcCT5qIDdj
	edowIGg2qID4nIvsXwUSo+624d/PaXmid1oJtuZZT9HxCfy4K/TpTSxlT5MB+wVA
	TYN5FXvIkPO0NGG0D4n+uqeCT0KaavHc80i94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WzK8U5xDpORHtTlefcGl2V8kACovhh4d
	MqkDUvkXqEp8K0tMIQY04zPqUi6WibL35mrnGAL7rhnzjGY3el2DY5vhZgH1/hlF
	3vhDSmXtLKRlaSxqIUS0itjxkyKh/cHCWp4cw3Ju/7sqdyIdlvKcFT805IRfnjn1
	ZhlpEERvJ0U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B62B76EE;
	Fri, 20 Jan 2012 19:04:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C68D776ED; Fri, 20 Jan 2012
 19:04:51 -0500 (EST)
In-Reply-To: <20120120233335.GA20302@codeaurora.org> (David Brown's message
 of "Fri, 20 Jan 2012 15:33:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A723840-43C3-11E1-940B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188908>

David Brown <davidb@codeaurora.org> writes:

> Hmm, I thought I'd convinced myself that this was possible.  Now, I
> can't come up with a way of doing it that doesn't involve improper
> commits with earlier timestamps than their parents.

I'd actually want to see a way to do so that *does* involve timestamp
skew.
