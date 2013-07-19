From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Delete current branch
Date: Fri, 19 Jul 2013 08:08:57 -0700
Message-ID: <7vr4euy4c6.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=8q4J2yi2to_+41kJSA5E59CBwkG69Hj7MmTPgUnSh5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 17:09:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0CIs-0001JL-34
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 17:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760131Ab3GSPJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 11:09:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44827 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752071Ab3GSPJA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 11:09:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0F103035B;
	Fri, 19 Jul 2013 15:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Puuc7hgo8sPPpVR14tVYlmBrzJY=; b=XgLjLT
	zvUgokq+uC4Fs48MPsVQgpdRClFnsA9dWrBIWgnxsIrTr2RcsqbBMfLK+/al+TbZ
	gzloRo1ffEP5Gt7VofCQ/CNgapTJNOWb1+PjR46PSpPunjHO9BCcr+rUBAZASXMA
	/tDGslGxy88NdlNs4D6tCxAB7llPFyzS8hCjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gsa8TwEkLV29ErEaQ1XO08Y5ZrxZwfGJ
	aozix2s6+18stMsITtCqlmVi5E7DBidzPnI3GMWgc0LlPRzm3bBisSRajCj36uCG
	BEngvOBgBADF71rmsMaSkIr6fY5hkeGrb5AIuFfD7eWpUaqhfwXBdMRLMdvs3LmR
	CRFafgDqHuA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E42BC30359;
	Fri, 19 Jul 2013 15:08:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2367030357;
	Fri, 19 Jul 2013 15:08:59 +0000 (UTC)
In-Reply-To: <CALkWK0=8q4J2yi2to_+41kJSA5E59CBwkG69Hj7MmTPgUnSh5Q@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 19 Jul 2013 16:05:04 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 23817A7C-F085-11E2-AB4A-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230815>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Many of my ideas turn out to be really stupid, and I need to throw
> away my feature branch.  So, I find myself doing this often:
>
>   # on branch menuconfig-jk
>   $ git checkout master
>   $ git branch -D<BACKSAPCE>
>   # er, what was the branch name again?
>   $ git checkout -
>   # Ah
>   $ git checkout master
>   $ git branch -D menuconfig-jk
>
> So, I scripted it for myself.  Perhaps we should get the functionality
> in core as `git branch -Dc` (c for "current"; or something)?

What branch will I be on after doing that?  Detached at that branch?

> Also, perhaps a `git describe -` corresponding to `git checkout -`

Did you know that the general way to spell the branch previously you
were on is "@{-1}" and "checkout -" is an ugly special case that is
possible only because "checkout" does not happen to take a "-" as a
valid argument that means something else (like the more usual "read
from standard input")?

Perhaps 

	$ git branch -D @{-1}

would have worked without <BACKSPACE> and everything that follows.
