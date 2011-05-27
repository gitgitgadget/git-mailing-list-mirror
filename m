From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Whitespace and '&nbsp'
Date: Fri, 27 May 2011 11:31:32 -0700
Message-ID: <7vipswro57.fsf@alter.siamese.dyndns.org>
References: <BANLkTik7eJ=BC9Bekqu-W1-r0cheCjC+wg@mail.gmail.com>
 <7vzkm9unu0.fsf@alter.siamese.dyndns.org>
 <BANLkTi=hYR4ow1eMR3rHkMuVRsHJ=TFDZA@mail.gmail.com>
 <m262owhyuy.fsf@igel.home>
 <BANLkTimPfN6LQBhWj6rW3Zcm9JHPsMWsjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 27 20:31:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ1p8-0005Ud-6o
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 20:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005Ab1E0Sbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 14:31:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36794 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab1E0Sbo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 14:31:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 944A25DE4;
	Fri, 27 May 2011 14:33:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w4tqPF9JwNoYzBFqdfhZZe1P5to=; b=bFR33K
	oLGVH/Fw8G5gFBzNOqbPC7Qe0FrF/U4U1jQ2esvw043b2pKvr0Vaz9ubmyWMubu4
	Jy3ACBIRZ6xBRzrcDQvdw5EQ7CJiiER+PL0wp4PjtF+Md5D20yAJ7oKsZO46GacV
	C0DVX4kOdx09BdIM7nygmzz4EUCw7Ew73JqQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oOCo80B4DW20MEVEozwV1hE98x3PZYPv
	8fUfpRALXV1HV9u9JszzqKo52CSMn4bsMuDkhkXT1/dw0NM1msYaFJn+ek+2E8J8
	WxN83iVzKBhIIJ0ISd8tJlge7RdOIaYu8/Lz9lY6vZNXbHtelcx9WZd0H5+uaT0i
	Fbv1Y1uKF0w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 562705DD8;
	Fri, 27 May 2011 14:33:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1EBBE5DD5; Fri, 27 May 2011
 14:33:40 -0400 (EDT)
In-Reply-To: <BANLkTimPfN6LQBhWj6rW3Zcm9JHPsMWsjA@mail.gmail.com> (Linus
 Torvalds's message of "Fri, 27 May 2011 10:01:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB56DD00-888F-11E0-959F-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174637>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Now, very arguably this is not a git issue at all. Having the odd nbsp
> be more visible in my other tools would have been fine - either 'less'
> showing it (the way it shows other control characters) or my terminal
> making some visual distinction. That said, I think it's something that
> git could perhaps protect against a bit.

Yeah. I would have expected that "git log -p" would at least show after
the fact, relying on "less" being aware about it, but that does not seem
to be the case.  Setting my pager to "cat -e" is the only workaround I can
think of right now (shows "M-BM- " there), but of course that wouldn't be
practical at all. We want to notice this during patch application.
