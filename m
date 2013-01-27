From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] mergetool--lib: Simplify command expressions
Date: Sun, 27 Jan 2013 14:21:06 -0800
Message-ID: <7v1ud6uv1p.fsf@alter.siamese.dyndns.org>
References: <1359321886-80523-1-git-send-email-davvid@gmail.com>
 <1359321886-80523-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 23:21:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzabU-0006wA-0B
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 23:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756763Ab3A0WVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 17:21:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47573 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756615Ab3A0WVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 17:21:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C993C6A7;
	Sun, 27 Jan 2013 17:21:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z1mxy3eoTM/b2kyiH6cg0/70zdY=; b=vWq7oB
	EuIWsKzvpoNepcj3QFzdZYCBp789xUckBFmyySqc16Cc1YyW787cW2VjLCP02AvP
	4QEvbRXkCRLEVct2ig48EqOO57RdQskDK23tYLuejWH6xJ5Ein/vr8y7eGHPpq2k
	VhLFS6rHn2cwUYcONA2LjNZlZoCwx+7AxdJ5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VDD2uDI0DT2XpouRF2UG7js5KJmAkSuH
	MFA4Re/yUwOq6euqXnSfLOjCU/y6+miAOMEHoX31xLGQX8dCBu1pmtt+sXCNO0ns
	rCxEszShZjgIH3KIcPGxEHG1gizB5GYU2KmtaHS+BUgidTE8qBC2x3sy1t/V8rk9
	4QWX+EhYDCw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71013C6A6;
	Sun, 27 Jan 2013 17:21:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0BC99C6A1; Sun, 27 Jan 2013
 17:21:07 -0500 (EST)
In-Reply-To: <1359321886-80523-2-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Sun, 27 Jan 2013 13:24:43 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8DF3B9A-68CF-11E2-9CC9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214740>

David Aguilar <davvid@gmail.com> writes:

> Use $(command "$arg") instead of "$(command "$arg")" as the latter is
> harder to read.

Did you miss my comment that this is about RHS of an assignment?
