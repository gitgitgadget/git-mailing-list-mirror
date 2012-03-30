From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Maintaining historical data in a git repo
Date: Fri, 30 Mar 2012 09:52:04 -0700
Message-ID: <7vehsam3pn.fsf@alter.siamese.dyndns.org>
References: <CA+P+rLeyEcZPudhLWavB74CiDAqpn+iNkk4F8=NK_yGaJPMmyA@mail.gmail.com>
 <201203301510.q2UFAqn6003864@no.baka.org>
 <CA+P+rLcWT0SZQjW2LtFXXCDRwjMp8daJ2hVup=7cnsRGbKw7xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yuval Adam <yuv.adm@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 18:52:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDf3e-0004Md-4F
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 18:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760947Ab2C3QwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 12:52:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65057 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756228Ab2C3QwG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 12:52:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 605475C00;
	Fri, 30 Mar 2012 12:52:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CFdI8L1Gd38bjfjAl2QsBeWVHRA=; b=YIUO/P
	feJMGcIv6Dd2RIRStM7H2bK4AahOYheboATED5vjI0W2oCELJQbstWCy2vWlTBxZ
	DRhuCigpJmurzySCsYqG1GzhM6dY7e2YF2Bo49JgYxAvxd+pd9R7wO08kEswfC3T
	vBRsBrRctVlXLfnlUxPUqQd2hdUZTY/f3EGTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nZNYqGHejbb7iVuzqL0Tqx5OKoDjCH6b
	snsDEfzvxLiCiIAO59T+HJhPLMQ88KokrAkWElUNj13KQRWjc42fXRREYZ2OaJcw
	PfrKRWBvMNnCwRyPH8gUGbIpFC3igDk3aVcCv8pGswSVo0c2cZ4zwLYZpcmsxuJm
	0PMiSLUbp98=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 580CE5BFF;
	Fri, 30 Mar 2012 12:52:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E06765BFE; Fri, 30 Mar 2012
 12:52:05 -0400 (EDT)
In-Reply-To: <CA+P+rLcWT0SZQjW2LtFXXCDRwjMp8daJ2hVup=7cnsRGbKw7xw@mail.gmail.com> (Yuval
 Adam's message of "Fri, 30 Mar 2012 18:55:51 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE7B88EE-7A88-11E1-9E66-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194381>

Yuval Adam <yuv.adm@gmail.com> writes:

> Is this something that is definitively complicated with git?

That's not really "is it complicated with git" question, I would have to
say.  Any version control system you would build history starting from one
point going _forward_, never inserting past event as you dig back.

Surely, you could fake it by rewriting history, but I do not think SCM is
particularly geared towards such a use case *while* investigating the
history of the law and recording your findings.

I do agree that once such a discovered history is *complete*, it would be
nice to record it in a SCM with a powerful history digging capability in
chronological order, though.
