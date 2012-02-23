From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log -z doesn't separate commits with NULs
Date: Thu, 23 Feb 2012 12:07:47 -0800
Message-ID: <7vy5rt2u0c.fsf@alter.siamese.dyndns.org>
References: <4F46036F.3040406@gmail.com>
 <20120223102426.GB2912@sigill.intra.peff.net> <4F462E61.4020203@gmail.com>
 <m34nuhelnf.fsf@localhost.localdomain> <4F4643BB.8090001@gmail.com>
 <20120223193451.GB30132@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nikolaj Shurkaev <snnicky@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 23 21:07:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0exH-0005eK-3A
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 21:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756803Ab2BWUHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 15:07:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46695 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756359Ab2BWUHu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 15:07:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C768B7F3F;
	Thu, 23 Feb 2012 15:07:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9ESS2v5LYtiRxb5a0oSygMGZFo0=; b=bjXm74
	QHXfYasQQQx4vmNFnl3d0YUloIXIYFS+qdXHi4vR0fnnQa2IQFv7A0VoO24KZPxG
	X+mcZJyY3u99CtuCn6bHP5He2SkWy4356tbEZiSoOM1ivu7MMSaF6m/3r7v2e2R7
	JfnRuCHwR4qPEDPJefQqBsd45si58xgcRZ3lQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PfhGgjqmXUaTVkeDxMiuzVCHpRA47OfH
	ml5QdfgSQ3/S5NHx3CceTEuaZwgeR/LQ0yclSoWIU0Qa7pVsAhIaxeTC01PSIz+G
	8QSqJUDTwpJWhuNrmxtLxo9Lc8LE1e4HusDdbELKl+0k19tPz9SoFGZ7GFkxxlt5
	3ZihKzvPdBs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE8A17F3E;
	Thu, 23 Feb 2012 15:07:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3633D7F3D; Thu, 23 Feb 2012
 15:07:49 -0500 (EST)
In-Reply-To: <20120223193451.GB30132@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 23 Feb 2012 14:34:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F2A8BFE-5E5A-11E1-9351-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191391>

Jeff King <peff@peff.net> writes:

> On Thu, Feb 23, 2012 at 04:48:43PM +0300, Nikolaj Shurkaev wrote:
>
> Doesn't:
>
>   git format-patch HEAD~3..HEAD SomePath
>
> do what you want? It is certainly designed to, and it seems to work for
> me.

It is not quite "designed to", though.

It happens to work that way, and I do not think we want to forbid its use,
but we would want to discourage anybody from blindly using it without
thinking if the end results suits his/her purpose (and the reason should
be obvious to those who think, the hint is "log message").
