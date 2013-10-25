From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT Hooks and security
Date: Fri, 25 Oct 2013 15:14:37 -0700
Message-ID: <xmqqwql1hub6.fsf@gitster.dls.corp.google.com>
References: <CA+nXgrUZk=_wtQ2yQnxwCZ3Mazdz=ZH2FJV+V92PVa0a4+A1hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Olivier Revollat <revollat@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 26 00:14:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZpeY-0002Ka-BU
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 00:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281Ab3JYWOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 18:14:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46510 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619Ab3JYWOl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 18:14:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B6E74D55A;
	Fri, 25 Oct 2013 22:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5+d0zT1z1nfZpxkQa6vL86O3/00=; b=bO+J7t
	HPks6PzG5XYlkdfBEtlGxhzV9XVayYksbE7LlIFny8fFnTUhNpSM7gGaK9N60Zh9
	NA7fQM1ZUf0cxzO13VwlWhuUxhPk+EPdZ3Cncf/7r7kFzFEvcsSnntM1QCwC2o8d
	CWejWflb0jvcDJTsFMAYreYMVOJtcC+zhPe98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NVR2e916nK2W4vI1HdbAa7gL+UtH40Lv
	ekj44IEyc37P13cDqdU+XkK/gCz2qqn5EGc9rLzXErj4JmOvtlN7mYh1MiV/vhFO
	/5lRLuMgIbnZk/I7thyoxvNlH1Q7fKUjm8lzGSU13ZULcNHWl7EgYuHvS8htBSpR
	iUEOz3GP0Sc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89FC94D559;
	Fri, 25 Oct 2013 22:14:40 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D80914D54E;
	Fri, 25 Oct 2013 22:14:39 +0000 (UTC)
In-Reply-To: <CA+nXgrUZk=_wtQ2yQnxwCZ3Mazdz=ZH2FJV+V92PVa0a4+A1hQ@mail.gmail.com>
	(Olivier Revollat's message of "Sat, 26 Oct 2013 00:02:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D7748364-3DC2-11E3-9BC0-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236720>

Olivier Revollat <revollat@gmail.com> writes:

> I was wondering : What if I had a "malicious" GIT repository who can
> "inject" code  via git hooks mechanism : someone clone my repo and
> some malicious code is executed when a certain GIT hook is triggered
> (for example on commit ("prepare-commit-msg' hook))

In that somebody else's clone, you will not have _your_ malicious
hook installed, unless that cloner explicitly does something stupid,
like copying that malicious hook.
