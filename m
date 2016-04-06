From: Junio C Hamano <gitster@pobox.com>
Subject: Re: log --pretty accepts incomplete pre-defined formats
Date: Wed, 06 Apr 2016 08:15:18 -0700
Message-ID: <xmqqinzuzs3d.fsf@gitster.mtv.corp.google.com>
References: <5704A925.9030506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 17:15:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anpBA-0003VL-61
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 17:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750AbcDFPPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 11:15:25 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56983 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754984AbcDFPPW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 11:15:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D80ED52FD5;
	Wed,  6 Apr 2016 11:15:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MEa1RI7bkFNY3kWDJdd6rGJ6emM=; b=ubXvIp
	97nf2wFAYkPSg8UTrL5HivLtoMpyY9tNY70Iqv7j3KsqP+csMyTPlM2FLEwD8qtX
	6ajbipakvxRe3Qky2Mek4e80wOwYdqcFOsFCiILWZwAKHFRHyFf0iWJekYiTFr1L
	ggqbOUV9lpZhBDOPdAPXxcnW7oWMZMx+mJfRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ib3xh7sMI81KBKGyNpbs50q4cCEyE+/n
	n+1BTUlxRS4cMM00ddxr0V1UdzV3ayyi38nC6Jkw7xM9NPXpcoeMSVCZME+h4eNy
	R9LgGg+MF6bSDxybcy2i0cHFZ2WnFU0U9N+jkxjdrAFiNjHEDKDfD1O0g0QubPrQ
	xU22WnhplR8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C50BA52FD4;
	Wed,  6 Apr 2016 11:15:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 36BF652FD3;
	Wed,  6 Apr 2016 11:15:20 -0400 (EDT)
In-Reply-To: <5704A925.9030506@gmail.com> (Sidhant Sharma's message of "Wed, 6
	Apr 2016 11:43:57 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 60708048-FC0A-11E5-9040-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290843>

Sidhant Sharma <tigerkid001@gmail.com> writes:

> Recently while playing around with git log, I realized that it is possible to
> pass incomplete (pre-defined) format names. For example, it is possible to use
> `git log --pretty=one` instead of oneline and it would still output the logs in
> oneline formatting. Same goes for other formats such as 'raw', 'short' and others.
> I looked at the code and it seems that it is intentionally kept so. It this so?
> I'm curious to know the reason behind keeping this so.

I actually am curious why somebody wants to know, as more modern
parts of the system allow option names abbreviated to unique
prefixes.  "Why can't I say 'log --pret=oneline' when I can say
'commit --ame'?" might be a more plausible puzzlement (and the
answer is "hysterical raisins").  Anyway, this seems to come from
6cdfd179 (commit: allow --pretty= args to be abbreviated,
2006-05-14), which was slightly tightend by aacd404e (Fix some
documentation typos and grammar, 2007-02-02).
