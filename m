From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Linear history *and* share a branch?
Date: Thu, 05 Apr 2012 14:06:36 -0700
Message-ID: <7vfwch51nn.fsf@alter.siamese.dyndns.org>
References: <CAE1pOi0-uSaQwgJHMTkw3nqp=idxZxMbyfKtLni0=Xwu-L-_hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 23:06:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFttE-0003Si-V5
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 23:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762Ab2DEVGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 17:06:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34280 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753059Ab2DEVGj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 17:06:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 849F6789D;
	Thu,  5 Apr 2012 17:06:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ySJ89296lOHSebdntIr3H2I57iI=; b=ZEIFzP
	Fuju8yicW9OmolZ8AJacSRHW5XYgQqKez/MpUYkmJ+B2kUCVN2ym7HVj1S58D0OO
	jczeYyc3LbpAdaUa7ulm92z2mXd+wQJdQJLua1ItqrC2H0Hm5pSG7Cf4XhYXOkDB
	dpNfnh1MY0ec/gYDCYSj4jdwTPowc3Lv3YwSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yJhh01XnA9LnTJ6X5FwOLpTla4fWGW93
	0IPCy+QEWv83xcKQHpZAuraleMhbbSHfUrtH3RsbPacMRjtrvW/bdoJC8Zh3claL
	l8jcYLjTOql2Rpnp35EwNG5C02ef96HDnfpXA7azEmfZs7/g4tEx6cajBSBDYjlz
	rlmzPoq9+aA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C63B789C;
	Thu,  5 Apr 2012 17:06:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DEBD7899; Thu,  5 Apr 2012
 17:06:37 -0400 (EDT)
In-Reply-To: <CAE1pOi0-uSaQwgJHMTkw3nqp=idxZxMbyfKtLni0=Xwu-L-_hA@mail.gmail.com> (Hilco
 Wijbenga's message of "Thu, 5 Apr 2012 13:48:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3BDD611A-7F63-11E1-A5F1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194811>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> Hi all,
>
> We have been using Git for about a year now in a very small team. So
> far, everyone has worked on their own local branches and been doing
> "git rebase master" to make sure their local branches stay in synch.
> This way we have a nice linear history in master.
>
> Recently, it has become useful to share one of these local branches
> between two devs. Of course, when one of the devs does his usual "git
> rebase master", he screws up the other dev's environment. Our solution
> has been to keep rebasing the shared branch but to actually work on a
> local branch that is rebased on the shared branch. By judiciously
> using "git reset" and "git pull" on the shared branch the two devs can
> keep the shared branch in synch and then use "git rebase
> shared-branch" on their local branch to keep it in synch to. While
> this works, there is probably a better/simpler solution.
>
> Should we simply do "git merge master" instead of "git rebase master"?

That certainly is a sensible thing to do.

But if your people are used to rebasing their own 'master' on top of
shared 'master', I would imagine that it wouldn't be hard at all for these
two people that work on a topic branch to do the same for their 'topic'
branch, no?  Just like rebasing their 'master' on shared 'master', they
would rebase their own 'topic' on shared 'topic'.
