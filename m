From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-archive's wrong documentation: really write pax rather than
 tar
Date: Wed, 03 Aug 2011 18:56:41 -0700
Message-ID: <7v62me6ism.fsf@alter.siamese.dyndns.org>
References: <1312409879.97173.YahooMailClassic@web29501.mail.ird.yahoo.com>
 <20110804014143.GA32579@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hin-Tak Leung <htl10@users.sourceforge.net>, git@vger.kernel.org,
	rene.scharfe@lsrfire.ath.cx
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 04 03:56:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QonB2-0001TK-0i
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 03:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756551Ab1HDB4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 21:56:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59967 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756546Ab1HDB4n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 21:56:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34F1C4B5B;
	Wed,  3 Aug 2011 21:56:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/tMlyab5Y6hemaYT2Mb7U+xd+ik=; b=w41SmB
	n7An8AJ3FHGsskV6SO1CoZF303yPRNqMwNgtvb3HdinTYo/21GM409YsUJlkFcZR
	CxQ+irWi7Wjb8oWMFkXjkPi3XB+niNQYGvy+YvAJcMJWdiQIlPQ6rIcDHj44iwo4
	yVM2I9rH71xt0bHUuCCa1uHJc5h8Zhy1j1Vv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nGDzt+nmyWVbUoCIGMNRStEfuZSjLkT9
	X9sNIAMir5yXRdQSM2Wg7Qd5I1bVysGIdv4aXgt8kRsp0paT3dhMpejOkNh8vM35
	gHhVa8HI2ko3cHeDzFe0eRJpQYXCX15Ktsw3nVs3JzuAEfwCI03B12slwj3iGOv8
	0rvJivknT3o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CCE14B5A;
	Wed,  3 Aug 2011 21:56:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C93664B59; Wed,  3 Aug 2011
 21:56:42 -0400 (EDT)
In-Reply-To: <20110804014143.GA32579@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 3 Aug 2011 19:41:43 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 004BAD10-BE3D-11E0-B68D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178652>

Jeff King <peff@peff.net> writes:

> It might be a bit more obvious to find if we actually had a
> --no-pax-header option, though.

Yeah, we would need to make sure that --no-pack-header causes a barf
for other backends, though. "struct archiver_args" right now seems to have
compression_level but I think it should just have "const char **" that is
interpreted by backends.
