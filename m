From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/23] backend-struct-db
Date: Wed, 13 Aug 2014 14:18:56 -0700
Message-ID: <xmqqmwb82im7.fsf@gitster.dls.corp.google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 23:19:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHfwx-00023z-Cy
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 23:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907AbaHMVTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 17:19:11 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61848 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752837AbaHMVTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 17:19:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7BF42314A7;
	Wed, 13 Aug 2014 17:19:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gL6vdOfyPynmNrIzoZZc+uofVL4=; b=qe6zX3
	OuHbC5WD7H20ggGROZfu4lXJDUyrXg7uzoV8hox6igQeDGj4ulHjch7Z69VoDxLo
	jGXpPTN/Th7KglBxMegWCVI6qkHTjgW2Vt0P5qQVI6qO4kXwUmZp6h6eve4OVN1I
	Q7YF8dDPOwG1F4WSBYb2/ivc/+BABtwN134zU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LRhZTVP0xqlo8jk5lQ5qLXL3er8o1XOf
	djiokReq304z6qAf/SWFb5AL6YC5tP0VPsssfIEf4ckKCn3qjAt+5JnpV6Ws2lYQ
	ET7RQs+5YeQEsc/Z3hs4fD/HOjoB3n5LHUWHNihCD66BJ0kJGltGhN48XDGv7SG7
	oVZ/3g7NXvg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E4E50314A5;
	Wed, 13 Aug 2014 17:19:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E5FA93148F;
	Wed, 13 Aug 2014 17:18:57 -0400 (EDT)
In-Reply-To: <1407960907-18189-1-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Wed, 13 Aug 2014 13:14:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 701FD242-232F-11E4-AE7B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255253>

Ronnie Sahlberg <sahlberg@google.com> writes:

> 15 of the patches, the refs-common.c patches, focuses on moving all backend
> agnostic refs functions to a common file. This file will contain all
> backend agnostic refs functions.
>
> The last 6 patches adds a backend structure with the methods we need to
> describe a pluggable backend. Currently we only have one built in backend,
> the current files based backend. These patches do not change any of the
> behavior other than that we now call the methods through backend specific
> wrapper functions rather than calling them directly.
>
> At this stage we now have a defined set of methods needed for a refs
> backend and we can start building and adding new types of ref backends
> to git.

Very nice ;-).

I would have expected that refs.c would be the generic one and refs-be-*
would be the backend specific ones, though; that way you do not have to
introduce a new file refs-common.c at all, no?
