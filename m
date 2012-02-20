From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-latexdiff: new command in contrib, to use latexdiff
 and Git
Date: Mon, 20 Feb 2012 01:05:43 -0800
Message-ID: <7v4nulnac8.fsf@alter.siamese.dyndns.org>
References: <1329320987-15203-1-git-send-email-Matthieu.Moy@imag.fr>
 <20120216003300.17228570@sirion> <vpq39abrxav.fsf@bauges.imag.fr>
 <7v8vk2zghl.fsf@alter.siamese.dyndns.org> <vpqty2px4l5.fsf@bauges.imag.fr>
 <7vmx8hvb69.fsf@alter.siamese.dyndns.org> <vpqobsx7d9s.fsf@bauges.imag.fr>
 <7vwr7ltlrj.fsf@alter.siamese.dyndns.org>
 <m34nups3q2.fsf@localhost.localdomain> <vpqy5rxsxb3.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Tim Haga <timhaga@ebene6.org>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 20 10:06:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzPCZ-0003k4-L6
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 10:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501Ab2BTJFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 04:05:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61204 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101Ab2BTJFq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 04:05:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE6AA441A;
	Mon, 20 Feb 2012 04:05:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kBSc3myqMk/MBsR4X6sLZH2Uxqc=; b=sk/QS1
	0tWEdHSqhZUUTDbhH/8BqiS+fG5K61GQZKZZVCKGYC8xolp31QhtSRkp9arMmcDD
	YbJjcwC8YFwsvJ41DJ/D8H8HjY0TrtFTWzL1b/w1ei6Q8VzcIyPkaJvNm4JFYUGz
	/e/pPt7hRmKFQBY7J29utDOBY2WRO4bp712CA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VJK8UFGsbaTd/1EzhDygnYJo2Dfbc9P0
	tDPpRXHExsZ+T0mlvV+F0C3aEZ9l5HB7iPS+fgwk+QKAU+flRBciWJaecMmj4Y8P
	GPIn+Wq3tjdwCXLclQoDCzYozHtu+yEIVEcQ12Wmljx+YITfw59wcXh0TJ/jteGj
	TGeUkuIGyFk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E54C74419;
	Mon, 20 Feb 2012 04:05:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D86E4417; Mon, 20 Feb 2012
 04:05:45 -0500 (EST)
In-Reply-To: <vpqy5rxsxb3.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 20 Feb 2012 09:50:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12A26226-5BA2-11E1-857F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191058>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Jakub Narebski <jnareb@gmail.com> writes:
>
>> There is CTAN: Comprehensive TeX Archive Network (http://ctan.org),
>> which hosts tools such like latexmk (cousin of the general make
>> utility), autolatex (generates Makefile), chktex, ite (interactive TeX
>> editor),... latexdiff itself is also there.
>
> It's not really the same thing: AFAIK, ctan is a good place to
> distribute things, but not to develop them (i.e. I don't see revision
> control or developpers mailing-lists there, which were the two
> motivations for pushing git-latexdiff in git.git).

Oh, don't get me wrong.

It's just that I agree with Jakub that a better final destination for it
is CTAN next to latexdiff, not in git.git/contrib/, and when we last did
something similar for emacs vc mode support, the copy I carried ended up
becoming way stale than its final destination, and we had to remove our
copy in order to reduce confusion. I just do not want to make the same
mistake here.

I didn't intend to discourage discusson of your application here.

Carry on the discussion in a forum where you think the most people with
appropriate skills and interests hang out, and if that forum is this list,
that is perfectly fine. Host a development repository at GitHub, Gitorious
or somesuch, if it would help people stay in sync with the current status
to have a public repository.

I just do not think my tree is a good place to use as a "while we are
developing" staging area.
