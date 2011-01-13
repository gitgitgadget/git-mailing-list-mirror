From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Forcing re-reading files with unchanged stats
Date: Wed, 12 Jan 2011 23:26:42 -0800
Message-ID: <7vmxn51cy5.fsf@alter.siamese.dyndns.org>
References: <loom.20110112T150313-103@post.gmane.org>
 <4D2E6D99.9060907@dbservice.com>
 <20110113033217.GA32661@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tomas Carnecky <tom@dbservice.com>, Maaartin <grajcar1@seznam.cz>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 13 08:27:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdHas-0005by-T2
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 08:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601Ab1AMH05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 02:26:57 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35604 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab1AMH04 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jan 2011 02:26:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 34D233F62;
	Thu, 13 Jan 2011 02:27:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lWDgRcJngOzr8IoyQhNYoYOpeZI=; b=crQFwo
	3rzY/Ub82KVUuO04GxRU2I7abTULnPDt9WIow4C1VSpV3+rg9f5qb4Rd+2a22Dd9
	fxTDsD+/PiHNZXRxw4PsC+p2a7bTvYcWS0uEJB2/N1zmflMRBFHI3AjLhuryXQPg
	GOey2jfG5u4ppWcogoNKkEyh1kdceIvydhjjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PYOSATZreFeDwWXkpY5R/Xlrt8TsKV14
	d76Ufu3aDrtikVZOExFURNiOGKYk2lFzT2V5qfnP0UUVKWWtv4vpbghGbN3VaKqr
	3fG6kkvY+FiCwVfuvXw8vrkzdatQe9RqPMHvsJuNR1tQH53TLijwRnUUns1zjqXv
	dtp7FiQLv/I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E62213F5E;
	Thu, 13 Jan 2011 02:27:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9733F3F5C; Thu, 13 Jan 2011
 02:27:25 -0500 (EST)
In-Reply-To: <20110113033217.GA32661@sigill.intra.peff.net> (Jeff King's
 message of "Wed\, 12 Jan 2011 22\:32\:18 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 94CF39BC-1EE6-11E0-AFC9-C7CE2BC26F3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165041>

Jeff King <peff@peff.net> writes:

> I'm curious what this use case is, and whether it would be acceptable to
> update something like ctime on the files to make them stat-dirty to git.

Changing crlf-related attributes (or filter/smudge) after the fact,
perhaps?
