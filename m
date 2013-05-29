From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git-users] Highlevel (but simple to implement) commands provided by default for git
Date: Wed, 29 May 2013 14:15:04 -0700
Message-ID: <7vtxllqyhz.fsf@alter.siamese.dyndns.org>
References: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com>
	<CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
	<CALkWK0k8GkFYNkoGH4YCgmWtSR5rgFSG0dU9Aw2CO_arvuzKxQ@mail.gmail.com>
	<CAMP44s1VFxarV4Gp5KsxhFKJbmd033-DW8koe9P4XUZQcX4mrA@mail.gmail.com>
	<7v38t5sg7k.fsf@alter.siamese.dyndns.org>
	<CALkWK0=kA8mPt-8h8dYS9HrOcF1tx=0Pj-=jFHfa_UxdC=ehPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	=?utf-8?Q?Br=C3=A1ulio?= Bhavamitra <brauliobo@gmail.com>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 23:15:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhniD-0007Yt-UP
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 23:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966087Ab3E2VPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 17:15:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41152 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933570Ab3E2VPH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 17:15:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8E752308D;
	Wed, 29 May 2013 21:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9LwnNmJqEs+J1Pq2m38AcHrNyfA=; b=kfb6RS
	5XNadhPGmej6zPBQ01KCY+691hA9OJUQ5ngky65/X72BA3CRq95Pruc42rVoXKWo
	r9DVeh1aQ2Uf7V0e8W34P5Jr7/ULSw4A3Ad4H0TMwx4hEOqAS+UAYA9+WQ+pCPhW
	pyueF6w+M9rEP3b7wZj9ngoscc9lHeWb6NNE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=amIYCO7w4BcqKoU6H55pgSD8qmHnLhvV
	OhRW3z16pxMr5Qxtcq6EI+Gl3Pv6f+0v61pTatyt2pw9XEIEPdjzWJ/6aXhL9WhJ
	Xm0GTlyxC0tjP5CxP8aDhUf/WA6F2aS5uGp20G0zC4IQYAy5CzAG+EbPRDwfIOD4
	YXUulq1ouog=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC3132308C;
	Wed, 29 May 2013 21:15:06 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E0732308A;
	Wed, 29 May 2013 21:15:06 +0000 (UTC)
In-Reply-To: <CALkWK0=kA8mPt-8h8dYS9HrOcF1tx=0Pj-=jFHfa_UxdC=ehPQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 30 May 2013 01:49:17 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D5DBA0CA-C8A4-11E2-A992-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225890>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>>         cd Documentation; git blame :/Makefile
>
> *scratches head*

You lean new things every day ;-).

>   cd Documentation; git blame ../Makefile
>
> Isn't this how pathspecs are specified everywhere?

The whole point of show-cdup is that people (especially those in
java land) bury themselves in a hierarchy so deep that it is not
feasible to tell "Go count the hierarchy and prefix that many ../
yourself" to them.

The answer to "we cannot count ../" issue is ":(top)" aka ":/" magic
pathspec modifier.

"git blame" takes a single pathname, not "a set of patterns to match
against to select concrete paths", which is what a pathspec is.  
