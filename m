From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] "status --ignored"
Date: Sat, 10 Apr 2010 00:48:49 -0700
Message-ID: <7vd3y7ycgu.fsf@alter.siamese.dyndns.org>
References: <20100410040959.GA11977@coredump.intra.peff.net>
 <1270885256-31589-1-git-send-email-gitster@pobox.com>
 <20100410074430.GA12567@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Raymond <esr@snark.thyrsus.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 10 09:49:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0VRC-0004h2-HA
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 09:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945Ab0DJHtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 03:49:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59651 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab0DJHs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 03:48:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D855A9601;
	Sat, 10 Apr 2010 03:48:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ck1oQi0N0Kq+B7ZrrO37Qjiq65g=; b=k/EmJO
	Uc1utLiijTQjaJnkhZKXJ1xulikEMhOHPguU99D9dXHb1DDYIz/j7eQLs2pFISct
	LgrvkP4McppDeKi8ACFJsq5rcR6z73ASQ0cBmnXslW1Rpu41pEaPrmKmRJp+Ryuc
	s+bbESY7ELq8eWRZI44H2gp0rBVEcM83TpxgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PwbDC7aXjsqKpE0I1pQNb0vQKTLuQd7Q
	LAjySx4smApy2FkO3T+Ii1eHT66U+/jULL1w8HcAzmtCB7qkDIFbbML6WjqvwyZY
	LevT7YG7kluLM6Y7/C5qzZGjbpHn5wGhMcz0JpnYfDw45Mapv82CxRxa06AccgF7
	V9d0yl4eolw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A136A95FF;
	Sat, 10 Apr 2010 03:48:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92073A95FD; Sat, 10 Apr
 2010 03:48:51 -0400 (EDT)
In-Reply-To: <20100410074430.GA12567@coredump.intra.peff.net> (Jeff King's
 message of "Sat\, 10 Apr 2010 03\:44\:30 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 83A9C1EE-4475-11DF-B165-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144531>

Jeff King <peff@peff.net> writes:

> +	dir.flags |= DIR_COLLECT_IGNORED;

I thought about using collect-ignored so that fill_directory() does not
have to be run twice, but IIRC it can short-circuit an entire directory
using the "simplify" logic (as it was designed to be used for "git add"),
no?

Mine is not "less ugly", but just "simple and stupid" ;-).
