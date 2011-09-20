From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git patch-id fails on long lines
Date: Tue, 20 Sep 2011 13:11:09 -0700
Message-ID: <7vehzb5602.fsf@alter.siamese.dyndns.org>
References: <1316541771-sup-9996@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Andrew Pimlott <andrew@pimlott.net>
X-From: git-owner@vger.kernel.org Tue Sep 20 22:11:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R66f0-0004aY-MA
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 22:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635Ab1ITULO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 16:11:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50861 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010Ab1ITULN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 16:11:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76277461F;
	Tue, 20 Sep 2011 16:11:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fUOBSoyqXJxnwQRCmD18YGiTDd8=; b=xPrP3E
	xpQQT2VZmRieTm5pwkTeRx8XcJN4GFHfo9q52wOtLPkyt1lW1GnJ6i4JtHh6NMb1
	eaZyVRpBCdURHbBLL1u5CtxPfuzuGFWf3mqRxZowkSmTdmj/+nBzEC3awh3p0tAS
	REYluD0eXJ7nkbdHGfgEasMoA00xLzY4dmEhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bcQ57wFhU+PDrT7J+IvENObBTpUjYEg4
	ihdMSakIIHX8QxHGHzJJjSAEHcQb+d8qEuCDzTvQMzNdzX0Z+BM3ViuKX32GR+1V
	/jwfvntcCYu6vBnKIJxN/i1jvrrmtfRDAd/il+SB8xLr+2PYrX0EUKK4E1QOULJQ
	xMOEFaYGE1c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A3AC461E;
	Tue, 20 Sep 2011 16:11:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0159C461B; Tue, 20 Sep 2011
 16:11:10 -0400 (EDT)
In-Reply-To: <1316541771-sup-9996@pimlott.net> (Andrew Pimlott's message of
 "Tue, 20 Sep 2011 11:07:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AEFF2268-E3C4-11E0-9A2F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181789>

Andrew Pimlott <andrew@pimlott.net> writes:

> In patch-id.c, get_one_patchid uses a fixed 1000-char buffer to read a line.

Thanks; builtin/patch-id.c is parhaps one of the more ancient part of the
system and it hasn't been updated to use more modern facility like strbuf
API.

Fix should be pretty straightforward. Any takers?
