From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t6019: avoid refname collision on case-insensitive
 systems
Date: Thu, 15 Sep 2011 09:45:39 -0700
Message-ID: <7vr53hpxe4.fsf@alter.siamese.dyndns.org>
References: <02451a2849fc8f1cab7983b6c8c629ebb6a1aaa9.1316075573.git.trast@student.ethz.ch> <7vzki5pzvi.fsf@alter.siamese.dyndns.org> <20110915155308.GA19667@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Brad King <brad.king@kitware.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 15 18:45:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4F4O-0007ek-9m
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 18:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934199Ab1IOQpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 12:45:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47000 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934190Ab1IOQpm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 12:45:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77C865965;
	Thu, 15 Sep 2011 12:45:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P2DnkmhPSDodKTB9BGoGXsIAFTw=; b=fZIoEm
	wf2t5gHp8tawHY4IN6XBCE+3+dfZgIzicDlDc3YUy0YIlUfdQ0WhpXUHxanDhF5R
	jBqcwACYU5OEalCVAgzUPQXHtWdKWZDq+ZajyOBl33ycvbardS1VUN83uTgxZZip
	/dQVSnKCM2Hy6hFeIMnQLsowv5FJ3c/JI/+co=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n6MEV3QEKsSvl3dFSYo39YzLQhnG6xKv
	D8QBGGGLpcS42mRpGuMYRY6vSV0Se08y3Lp7mg3osBhp6c7ZYGu2jLc3FQCva648
	6972EbpvJ6HQp+2qscXHQw0Zcg7gouZ2FcLbv+EaJ+Wg+3P+lAzeGoBJH8+Ggu6E
	7BGCFtNRXOs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E2BC5964;
	Thu, 15 Sep 2011 12:45:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 041AD5963; Thu, 15 Sep 2011
 12:45:40 -0400 (EDT)
In-Reply-To: <20110915155308.GA19667@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 15 Sep 2011 11:53:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 25AF63FA-DFBA-11E0-AC84-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181478>

Jeff King <peff@peff.net> writes:

> On Thu, Sep 15, 2011 at 08:52:01AM -0700, Junio C Hamano wrote:
>
>> > This fixes the tests on OS X.  Together with Peff's fix to the poll
>> > issue, it now tests clean again.
>> 
>> Hmm, I must have misplaced Peff's poll fix. Care to point me in the right
>> direction?
>
> You have it already; it's part of the new http-auth commits I sent
> yesterday (patch 2/5).

Ah, that one. Thanks, yes I do have it.

I somehow thought Thomas was talking about a test fix for 5800
"intermittent hang".
