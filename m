From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] send-pack: abort sideband demuxer on pack-objects
 error
Date: Thu, 14 Apr 2011 14:21:31 -0700
Message-ID: <7vsjtkfs10.fsf@alter.siamese.dyndns.org>
References: <20110331184243.GA12027@sigill.intra.peff.net>
 <201104142136.25778.j6t@kdbg.org>
 <20110414202110.GA6525@sigill.intra.peff.net>
 <201104142243.33522.j6t@kdbg.org>
 <20110414205113.GA7451@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 23:21:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QATz5-00074B-28
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 23:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497Ab1DNVVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 17:21:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63089 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476Ab1DNVVn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 17:21:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1B66C552E;
	Thu, 14 Apr 2011 17:23:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZOjQsSUStZ+M3TK1CqiNqX7fy0g=; b=ib7mi5
	9j7s+75jUbgF9L8/PTt7FL/1iX60TSxvUkdS364hfjpW6P83qHVDVu8BXKs9z51q
	QqzmVY11wMVlVuRPhwO+LZNKc9BQnrNFLJP1ZIn8JbDC1N6/1wAP0VjGZxRf/die
	lVsqe1HbO3dZd7C9EAa1/aNkkPYmrpGTGLdFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C8LEbfCfxkV/Ri2vrNI13xpCHE+Vcadi
	APj3hjpHNXIDdF13FkPuy2bcP54XMQaYJjWUHtXssYihp4UbJ8jo3V5dEcts03iC
	Hreccy6vDUP/0PBvvjfEjwnXCBlP2KS1hm7xZojR42egtp/HBheGhA5nBxNO4cYL
	wl0hbEMw5dY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DDEE6552D;
	Thu, 14 Apr 2011 17:23:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C95BB552C; Thu, 14 Apr 2011
 17:23:31 -0400 (EDT)
In-Reply-To: <20110414205113.GA7451@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 14 Apr 2011 16:51:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 75057D3C-66DD-11E0-A8F5-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171559>

Jeff King <peff@peff.net> writes:

> I think I am leaning a bit towards (2a). It's simple, and it's not like
> this is library code with a million unknown callers; fixing it simply
> and cleanly with a nice commit message is probably sufficient.

This really sounds like a plan.  Even if we _might_ later want to go to
2b. or some other solution, we will know what pattern to grep for.

Thanks.
