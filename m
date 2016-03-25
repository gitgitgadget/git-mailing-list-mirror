From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC] A late proposal: a modern send-email
Date: Fri, 25 Mar 2016 11:16:12 -0700
Message-ID: <xmqqzitm2zkj.fsf@gitster.mtv.corp.google.com>
References: <CAKqreuyC8p9m_dgVpXCiT_hf=8qBA_5kZ5NABQGx0QDOiCBbww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?utf-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 19:16:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajWHf-0001JT-QE
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934AbcCYSQS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2016 14:16:18 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59328 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752190AbcCYSQQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2016 14:16:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2F2EB4F37C;
	Fri, 25 Mar 2016 14:16:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Q4APojNcvQ/2
	W1yl+SWIfIuoaXM=; b=aeQUuRpYm/2TT+mjwKSPewjdrGYnE661FvUETotYBhxQ
	Gf9zJrJEexUAanwoBhx2pDGrrIggFlIRQ9BTcuunCnLZkaEuikaXG/mHgRNxckbi
	6cnR9cZsNPpyl2b/j7/1oJfhXfWKXzu2iRLLrL3uFhL4KAbosWRyM5TI+3Q3MLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rHhBrD
	xtbpmGoa+TeXvzNSXmcgpg0G11LGyeX5bybT5QeYCJaDFDdNXN4AP51/vb8gd12W
	Px/CeHyq8TM6FCdqWbfaIJP1aLJmIkiEz+p1mz8sAUNrmUjShUJcLjSBHIoEZXB7
	+bCE48KnNNv3refpXNk4ZS/zFnyuAFYYLjF68=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 274D04F37B;
	Fri, 25 Mar 2016 14:16:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 137B64F37A;
	Fri, 25 Mar 2016 14:16:14 -0400 (EDT)
In-Reply-To: <CAKqreuyC8p9m_dgVpXCiT_hf=8qBA_5kZ5NABQGx0QDOiCBbww@mail.gmail.com>
	(=?utf-8?B?IuaDoOi9tue+pCIncw==?= message of "Sat, 26 Mar 2016 01:59:08
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A8DFEB7E-F2B5-11E5-BBD4-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289928>

=E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.com> writes:

> # Purpose
> The current implementation of send-email is based on perl and has onl=
y
> a tui, it has two problems:
> - user must install a ton of dependencies before submit a single patc=
h.
> - tui and parameter are both not quite friendly to new users.

Is "a ton of dependencies" true?  "apt-cache show git-email"
suggests otherwise.  Is "a ton of dependencies" truly a problem?
"apt-get install" would resolve the dependencies for you.

> # Plan
> So I propose to implement following:
> - Allow user to send mail via a [`mailto`
> link](https://en.wikipedia.org/wiki/Mailto). so that users could
> complete the mail in their favorite email clients such as gmail, mutt=
,
> alpine and even gmail for android through

IIRC, GMail on Android is incapable of sending a "text/plain", so
that part may not fly well.

> - Build a simple email client (maybe a web components based web app o=
r
> wxwidgets based GUI client, they are both cross-platform) which is
> easy to use for sending patch without disrupting the mailbox format.

I suspect it would yield a better result if the plan were to update
a popular email client and make it possible to tell it to read an
existing text file (i.e. mbox) without corrupting its contents.
People do not have to learn a new mail client if done that way.

That may not be a "Git" project, but GSoC is not limited to Git ;-)
