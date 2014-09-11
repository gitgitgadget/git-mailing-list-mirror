From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs: speed up is_refname_available
Date: Thu, 11 Sep 2014 10:07:28 -0700
Message-ID: <xmqqy4tqdr1r.fsf@gitster.dls.corp.google.com>
References: <20140910101730.GA12399@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 11 19:07:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS7qM-00036V-H0
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 19:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542AbaIKRHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 13:07:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62580 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761AbaIKRHd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 13:07:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 97944381C3;
	Thu, 11 Sep 2014 13:07:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K0DEEQsLtYhKsrOJRv3XXCXlW6A=; b=o7zIbi
	2v5uv48RMDtptZyq38OvCfe7lI5XSpBKS5mdLx0gmlnrcX0Cpicy5cwkxTOP+CMJ
	JevqBqU9w0Mri28tuYdBCzZeKy63owOBfOa+ruhI9oCWHNfbSrdhC/tPDoOwFLGy
	CMeDjQzjb1ge8TN0ZY8jlYbPyc6r0WOXlIePU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k6rBy0iKUFprmc7qix5aJynmPu49rf7N
	n8vKAzYl0ZgiJlkvmxKgqZYOIfI1pdvRLaN4dEvj3zHXrIcVI4PwHzx9lWmcGdiT
	ny6vlLmNNeVJViqVX73IbPlqCYHouSs8xx4KvpAC28lPQTJThsxCZIICvI4MSnRN
	Mmy/9wuOCpw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B979381C2;
	Thu, 11 Sep 2014 13:07:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 592B3381C0;
	Thu, 11 Sep 2014 13:07:31 -0400 (EDT)
In-Reply-To: <20140910101730.GA12399@peff.net> (Jeff King's message of "Wed,
	10 Sep 2014 06:17:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1DD6BA6A-39D6-11E4-9419-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256854>

Jeff King <peff@peff.net> writes:

> This has a fairly straightforward conflict with the ref-transaction
> stuff in pu. The "oldrefname" parameter to is_refname_available became a
> list of items;

Hmph, the trouble I had while reading the conflicts was about the
new "we skip these when repacking", not "oldrefname".

Will check your suggested resolution later today.  Thanks.
