From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] mergetool--lib: Simplify command expressions
Date: Sun, 27 Jan 2013 14:32:33 -0800
Message-ID: <7vr4l6tfy6.fsf@alter.siamese.dyndns.org>
References: <1359321886-80523-1-git-send-email-davvid@gmail.com>
 <1359321886-80523-2-git-send-email-davvid@gmail.com>
 <5105A56E.4010002@kdbg.org>
 <CAJDDKr61wS1ruPYDW4+exWBWveyS0Dp7Gmu5gWRh_99-frc_7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 23:33:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzamY-0002iC-ET
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 23:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780Ab3A0Wci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 17:32:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51780 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755199Ab3A0Wcg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 17:32:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FFC0C9B6;
	Sun, 27 Jan 2013 17:32:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rkeoiThWqPWf3fYPOpV9tHmcdpw=; b=PKIiw8
	BxUej64SNCnbbpjSCfqJYxJv5KsFzqL67IHtD/Vjz6hTOSYoDvx53+tDBDIO56Qi
	OMBVpC1nnNwcNZdZ8y4H9cUL2P7oZnqkTdsZFR1gJfqEiGJrd/B4IUKs6DfxOYs4
	Lb0l981vmHxOek9OBbTA2kDiEP0gALt05kZkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XKagSMDXDHJdyCVZYibyqnZIHOE/rrLX
	a8bmxiary7acVfu7sACn33QSjBcotpgyeP4VwUHmSt9dZN+q9VCPzqxGZmjXcj74
	a+3IHbYq13xK+8SaKj5q6uKVA+HvU7cvYX5/DWSo0xKr4eF5BrAy5wlcO9GueC7e
	6jmQqYtujSk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62832C9B5;
	Sun, 27 Jan 2013 17:32:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7315C9B3; Sun, 27 Jan 2013
 17:32:35 -0500 (EST)
In-Reply-To: <CAJDDKr61wS1ruPYDW4+exWBWveyS0Dp7Gmu5gWRh_99-frc_7Q@mail.gmail.com> (David
 Aguilar's message of "Sun, 27 Jan 2013 14:18:15 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 72DA3168-68D1-11E2-8D52-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214743>

David Aguilar <davvid@gmail.com> writes:

> Definitely.  I learned this the hard way when the tests broke on me while
> working it ;-)  My patch rewrites things to always use var=$(command)
> expressions with separate test "$var" evaluating them.

OK; that wasn't clear from the log message.
