From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] t4300 (rebase): don't unnecessarily set GIT_TRACE
Date: Fri, 10 May 2013 10:51:18 -0700
Message-ID: <7vk3n6206h.fsf@alter.siamese.dyndns.org>
References: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
	<1368196178-5807-5-git-send-email-artagnon@gmail.com>
	<7vmws2529j.fsf@alter.siamese.dyndns.org>
	<CALkWK0k_ArM9EpY0S7=mbgFpHsoauZCr9e=ESX_CEA5-vRHrHQ@mail.gmail.com>
	<7vr4he3kpz.fsf@alter.siamese.dyndns.org>
	<CALkWK0kLjf=m-_9PkXzxOpnpqfh-n004E0f7_mi-VL3SbYWFAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 19:51:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UarTZ-0006x7-3T
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 19:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755509Ab3EJRvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 13:51:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35794 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756372Ab3EJRvU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 13:51:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26B3E1D600;
	Fri, 10 May 2013 17:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5ADhsR+yKozGUW3hNvNmT3IXDAM=; b=CmqETS
	oyfxlX1Het+Qa8nRZMvx+WzE/zngBPUNoEStNNQOPhchTAkRGtsJRzwp/JeLCXn5
	BHr0Tt2FfqOk3UP0ofOMPKL6vAHffAKWJDhunsCZIcFbntzKYkDqyZuDuMlf7DYK
	FT3LYpxkwJi6Y/GAqJWLFs3KPUkMW+FAR487I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oFlwXBOG7DLmqHiVIFwBxnu6kfSehxL6
	1X3VZTYdktCAQg1HcaxYladUYxCjO7TQTVgeoQnSqfjDOpPzj9HBOWmrcsDtS7mw
	KwoTNi9XrEtHgz41+Bka2VqNV/VB/vQxg8E23v9YKPKPJATr7JrQXb1jDAnqVJOQ
	81im40dhGyU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DE6B1D5FF;
	Fri, 10 May 2013 17:51:20 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 817E01D5FE;
	Fri, 10 May 2013 17:51:19 +0000 (UTC)
In-Reply-To: <CALkWK0kLjf=m-_9PkXzxOpnpqfh-n004E0f7_mi-VL3SbYWFAg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 10 May 2013 22:12:00 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 384F6A62-B99A-11E2-9F19-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223885>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Perhaps because this is a test about "rebase" and a typical debugger
>> does not want to trace other "git" things while debugging this?
>
> Okay, let's drop this 4-part series: it's too minor.

Why throw the baby with bathwater?

To me, most of them look like responses to valid issues, and that
holds true even for [PATCH 1/4].  Even though your response may have
been an incorrect one, the issue that triggered the response is
still valid---the setting of these variables without explanation
invites curiosities and a mistake similar to what you made in that
patch.

If the patch were to consistently remove "GIT_TRACE=1" placed on
"git rebase" from all test scripts that do not check the trace
output consistently (i.e. 3400, 3402, and 7402), with a different
justification, e.g. "whoever wants to debug a specific part of the
test can add GIT_TRACE=1 before running the test with -v, but it
should not be committed", the change would be very reasonable, I
would think.
