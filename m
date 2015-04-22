From: Junio C Hamano <gitster@pobox.com>
Subject: Re: PATH modifications for git-hook processes
Date: Wed, 22 Apr 2015 10:46:57 -0700
Message-ID: <xmqq1tjcf432.fsf@gitster.dls.corp.google.com>
References: <CAKuTQSGEmHHr-c+Tc2jM-JPkx6+_f3gp8Zjj8EuQy_e4=PvMzg@mail.gmail.com>
	<xmqqk2xe39zt.fsf@gitster.dls.corp.google.com>
	<CAKuTQSGapeUeZptdX1=Uv441Moo6X19RNR0oySU--F+Kj6Xz=w@mail.gmail.com>
	<20150416061732.GA5612@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthew Rothenberg <mroth@khanacademy.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 19:47:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykyjq-0007js-0j
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 19:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162AbbDVRrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 13:47:00 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51724 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752749AbbDVRq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 13:46:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 40AC24B23D;
	Wed, 22 Apr 2015 13:46:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xoy7YhjiRcqJ/RgywyL4seqY1Gw=; b=URVwzv
	aUfT3kk5h06FJnCURutQ3eSkR0diGBCdMS6sTwi9GAOdQNczgg1gmgudYkcZ5y7u
	Z21e7L7w+eMhyPG9Qzc+2d3caZ1QOFb3Y7ainq8i7i5Q2Nl4dXiyiZdVlwOXeoPI
	8pNvXTMc/wdykxV++rbIMASQN9egkbDDUT1rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mpTdGDmCFElkWogGAeyRC5yw2m9Cr6tA
	I/AGsYU7C7AfH8HitE4nQmzDc2SsPVu6CIC7rNwcbS1MaFNE0O7pGDUbRAmvTo70
	OOCGyLxf0B4of9DFKMlWXaXEpMHm6g3pTM1LhwvTEKCYPy7WqnwB7FMELF5IKET3
	z6oMDOKGlbA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3949A4B23C;
	Wed, 22 Apr 2015 13:46:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A86634B23B;
	Wed, 22 Apr 2015 13:46:58 -0400 (EDT)
In-Reply-To: <20150416061732.GA5612@peff.net> (Jeff King's message of "Thu, 16
	Apr 2015 02:17:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 92F56602-E917-11E4-BDCF-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267601>

Jeff King <peff@peff.net> writes:

>   IOW, you can do things like
>
>         alias git=/opt/my-git/git
>
>   and all the "git" commands will automatically work fine, even if you
>   didn't know at compile time where you would install them, and you didn't
>   set GIT_EXEC_DIR at run-time. It will still first look in GIT_EXEC_DIR,
>   but if that fails, it will take the git commands from /opt/my-git/ instead
>   of from /usr/bin or whatever.
>
> If we can get away with just dropping this element from the PATH, I'd
> much rather do that than try to implement a complicated path-precedence
> scheme.

I am OK with dropping it at a major version boundary with
deprecation notice in the release note.  Unlike older days, by now,
Git has become so essential to users' everyday life, and there is
not much reason for people to keep the installation of Git they
built outside their $PATH, and "alias git=/opt/git/bin/git" has lost
much of its value, I would think.
