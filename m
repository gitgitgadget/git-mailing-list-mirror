From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git clone -q ends with early EOF
Date: Wed, 18 Sep 2013 09:03:30 -0700
Message-ID: <xmqqzjraunfx.fsf@gitster.dls.corp.google.com>
References: <201309181444.19070.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Marek Vasut <marex@denx.de>
X-From: git-owner@vger.kernel.org Wed Sep 18 18:03:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMKE5-0007l3-Vk
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 18:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100Ab3IRQDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 12:03:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33078 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751652Ab3IRQDd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 12:03:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D9C24265D;
	Wed, 18 Sep 2013 16:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NvNQlIzsRt+Nhpv+Ol3Tzkdis4M=; b=FNeNMI
	SoGbqQ8RuqEzCzScXE1JKaOq/l6Grz33mlXG1mDxwZN6mpg+dsIDVt/ZJ5C7fC8d
	VkGo6MoBjULjXlaBbvN8mxEb3O04uANBVu6hvZRlmSQA1me69iB9WvNGWNCyWZ6X
	vXOLt8MX8wezFMdUG12jVzDGiQf6BItFBG4nI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CbFch5qK5gr1ykZMbakhNarn25csIkMP
	IZ3HpOwodjNJNUu4vxdeujVGQ7IHpKQUafFYlOnjKBFq4xwk9goy95oKytv2RkSY
	9TGMmTXDvnUKSrYEFaRRPAgfyYOO7TwTfayJedfrJBhEkBa4Jx27A5U65HoZ0JUK
	PJRFtSKEYIs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2358F4265C;
	Wed, 18 Sep 2013 16:03:33 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AB2A42650;
	Wed, 18 Sep 2013 16:03:32 +0000 (UTC)
In-Reply-To: <201309181444.19070.marex@denx.de> (Marek Vasut's message of
	"Wed, 18 Sep 2013 14:44:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DDC6E086-207B-11E3-B0AF-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234972>

This sounds suspiciously like 05e95155 (upload-pack: send keepalive
packets during pack computation, 2013-09-08) that is cooking in
'next'.

If you are talking with other people's server side, you are SOL
until the server end gets the patch.
