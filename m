From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] document string_list_clear
Date: Tue, 09 Dec 2014 11:41:44 -0800
Message-ID: <xmqq388omwzr.fsf@gitster.dls.corp.google.com>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
	<20141206020458.GR16345@google.com> <20141206053024.GE31301@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 09 20:41:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyQfQ-0002XI-Tm
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 20:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282AbaLITlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 14:41:49 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63450 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751141AbaLITls (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 14:41:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D4A8924671;
	Tue,  9 Dec 2014 14:41:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+zoH1unmRYrle99MYUjIJOrlQmk=; b=ISzWMY
	qz26I6rHmZsqBPb9TQRHPyDiMxU4q1Vv923IIl7kTI4xzYDw+DIVqWKe0zfYqfgq
	sg00YczBkFCf222YAzzyb6QxrGjbeCR5AwP/kWF4yhpzHr/yFwWXSVr3r34KdXq/
	3F3pn0hV/0hsfClyE6nqLHCwuaju2RbvEgAdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TIQQxO1CqO+DPt4yT4+SM3cC7a5YrHk0
	2GvixwGsI6wWmJdI+xk/3mdIK34TqOHuol3NBibERUzNolRBJcj+5osZR9WwBqLK
	b3rm/1m7HZdlR0yllmmXAHZjBOM0NhkT3zR1NF7XKQy7ol7VlgoQD3/J5vEK2Pyb
	WX7kUS6uiyQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB06F24670;
	Tue,  9 Dec 2014 14:41:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 471862466F;
	Tue,  9 Dec 2014 14:41:46 -0500 (EST)
In-Reply-To: <20141206053024.GE31301@peff.net> (Jeff King's message of "Sat, 6
	Dec 2014 00:30:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 68EECE0C-7FDB-11E4-9846-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261145>

Jeff King <peff@peff.net> writes:

> Also, I forgot to mention: if we consistently put the API docs into the
> header files and extracted it automatically into standalone documents,
> we would not need to have two places.
>
> This is something I've been meaning to look at for a long time, but it
> never quite makes the priority list. And my past experiences with tools
> like doxygen has been that they are complicated and have a lot of
> dependencies. It's been a long time since I've tried, though.

Yeah, that is a thought.

Some existing documentation pages like allocation-growing may not be
a good match for this strategy, though; cache.h has a lot more than
just alloc-grow, and there needs to be a way to generate more than
one API docs from a single header (and vice versa, taking text from
more than one source for a single API, I suspect).
