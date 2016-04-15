From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/21] bisect: extract get_distance() function from code duplication
Date: Fri, 15 Apr 2016 15:08:33 -0700
Message-ID: <xmqqfuum8qzi.fsf@gitster.mtv.corp.google.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-15-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Apr 16 00:08:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arBuq-0002Az-JN
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 00:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbcDOWIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 18:08:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62341 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752134AbcDOWIg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 18:08:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EB5C513371;
	Fri, 15 Apr 2016 18:08:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UwEpqwWlKkkMe7fUsLtSWZee7GU=; b=kWoYVy
	h7DKIlIb5h4MiuKtQU0K4lEOZ5OWj45EwjeqrUxg7vKO+siJWNbA7GIWZYtMx+z9
	kWZHeOai7qndp2ETNx0vf9or0Job8LblH9/Sw3z0oZwU5wt1CLbOB+jFgKf0QiAI
	L+afWJWFdtgAt3jRm9Lnabi/YU2vaeXwcGX+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=krhZwNEApoU2+F5A5n8OgMDYH5qmGVge
	1DfYw4BkFciXHQyN5ndMDU+xal/m833cyccQvYcU+A5EaQnrr0u6n4eXVdCgA8cD
	HtgK2Uj44jUl5Gnf+uH/IP4QC93OE5uMlByLoj3A1lX6eesH7bfXJNO6e3AtlTmt
	WMhYHmPO0dE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E421713370;
	Fri, 15 Apr 2016 18:08:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3AC621336F;
	Fri, 15 Apr 2016 18:08:34 -0400 (EDT)
In-Reply-To: <1460294354-7031-15-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Sun, 10 Apr 2016 15:19:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 98882D7A-0356-11E6-803B-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291678>

Stephan Beyer <s-beyer@gmx.net> writes:

> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
>  bisect.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Nice.
