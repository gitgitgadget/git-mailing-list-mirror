From: Junio C Hamano <gitster@pobox.com>
Subject: Re: post-update to stash after push to non-bare current branch
Date: Fri, 20 Jan 2012 16:16:39 -0800
Message-ID: <7vr4ytdi54.fsf@alter.siamese.dyndns.org>
References: <jf70vc$kol$1@dough.gmane.org> <4F171088.4080006@gmail.com>
 <4F1714AD.4090706@gmail.com> <7vwr8oljq7.fsf@alter.siamese.dyndns.org>
 <4F1764B9.90907@gmail.com> <7vboq0ld5e.fsf@alter.siamese.dyndns.org>
 <4F188FA2.1000209@gmail.com> <4F1A0311.30502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: unlisted-recipients:; (no To-header on input)
	Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 21 01:16:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoOdS-0003kb-L1
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 01:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756324Ab2AUAQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 19:16:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45503 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755266Ab2AUAQl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 19:16:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 605507861;
	Fri, 20 Jan 2012 19:16:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kQMPtkge+Fq5tGkDV9jQGKj1mj4=; b=Udb7rb
	ncS1Pb7g0e50rs8i0UQE6wfeXA9ltuDH1gEI2yZzrOtPfEeqqR3xkS1h+s+1Qp5z
	v69QM8aL1WujjS6TxXUzFZKJNaqb/vjmDNBfp2bjop6+g/NsGNGXx9WS6Wl+jfu5
	OPVor+oqOMalOjQtCWBLQceiMztipGFAfW0IA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ySrQ3gq1raFdjAneiNApseIAh0EpxH4o
	elKwjiYQJsEnjslK3/pbxHTRCTPG05xXNaxW9RmRjbCg8/aRoJ3c3kh2UDRX1AzZ
	GCY9zNkRWyvuiFDgiBoR0fBLg99aZeLW3n+iFPG1f0kpy+iDGYio46uQ8SkRrZ+O
	xhkeMAoOTS4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58A887860;
	Fri, 20 Jan 2012 19:16:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1EA9785F; Fri, 20 Jan 2012
 19:16:40 -0500 (EST)
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	unlisted-recipients:; (no To-header on input)Neal Kreitzinger <neal@rsss.com>
								     ^-missing end of address
In-Reply-To: <4F1A0311.30502@gmail.com> (Neal Kreitzinger's message of "Fri,
 20 Jan 2012 18:13:05 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 311C1228-43C5-11E1-87BA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188911>

Neal Kreitzinger <nkreitzinger@gmail.com> writes:

> To get this to work I had to learn more about shell scripting and export
> the GIT_WORK_TREE git environment variable.
>
> (post-update hook):
> export GIT_WORK_TREE=/home/neal/FSNMSTHTML
> git checkout -f HEAD


Hmm, I thought "cd .. && git checkout -f HEAD" (or "git reset --hard")
would have worked.
