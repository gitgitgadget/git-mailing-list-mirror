From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/14] url: decode buffers that are not NUL-terminated
Date: Wed, 20 Jul 2011 15:16:29 -0700
Message-ID: <7v62mw61j6.fsf@alter.siamese.dyndns.org>
References: <20110718074642.GA11678@sigill.intra.peff.net>
 <20110718074851.GB12341@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 21 00:16:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjf4N-0005Ko-2s
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 00:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906Ab1GTWQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 18:16:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40284 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691Ab1GTWQc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 18:16:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B0815850;
	Wed, 20 Jul 2011 18:16:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=2Mr7j7ru4eDe2cUlAj7ZA76Blbk=; b=vUt3XFxGgUODyQOJHnUy
	GkCnROhMe7IPTEhPIgSwytFqXeEH81p8uTSDzWQ+cGsobgU+iU0X4HETiSmC7Wvg
	/03XyCcYHwtR+7UTn2pw27a7StPXpl6dEaBKMj7PkP9hmvOg0VSDbQLyAnYOrQ/V
	/xTJC2lP8DcqAwi/Hcahjhg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=F7woCJTmI3QAczqkgO6bhOaLE6ax6e0xXsWoiLomMrrQEg
	hSkm4RMxfi8/hVgNqGqUoVMHJg4IllcU0iAWixDvUJLAUSRtSYKsgCejYEGY/ekB
	bsyvQckiCf3NZrkkBHopMXQpiuLykv7voihF45nx8gZoiICzvrdD4gW+O1dWI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 933D1584F;
	Wed, 20 Jul 2011 18:16:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12FA5584E; Wed, 20 Jul 2011
 18:16:30 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EBB279C6-B31D-11E0-BC2B-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177551>

Jeff King <peff@peff.net> writes:

> The url_decode function needs only minor tweaks to handle
> arbitrary buffers. Let's do those tweaks, which cleans up an
> unreadable mess of temporary strings in http.c.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  http.c |   27 ++++-----------------------
>  url.c  |   26 ++++++++++++++++++--------
>  url.h  |    1 +
>  3 files changed, 23 insertions(+), 31 deletions(-)

Very nice.
