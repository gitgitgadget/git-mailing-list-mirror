From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git http-backend error message
Date: Mon, 15 Mar 2010 10:12:37 -0700
Message-ID: <7v3a01v796.fsf@alter.siamese.dyndns.org>
References: <A55E5483-425E-4303-87F2-FABC46F6BFE5@pelagicore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeremiah Foster <jeremiah.foster@pelagicore.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 18:13:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrDqV-00033U-RX
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 18:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965493Ab0CORMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 13:12:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50291 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965428Ab0CORMq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 13:12:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 09CF3A25CE;
	Mon, 15 Mar 2010 13:12:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tbV/A5gm+sQrXwRL0/zWJMRuU98=; b=OhqnPV
	TcO8SCltt5aWiWje/B0J9wmTjT7J3EOAr5D3ORkMziMknRrQooLN6mAd+3yuIH6w
	Ab4MIDnyxuHG03Yl9H0+vQhIxkxehMU+njH6mitpzjVlTmc4QtirOxiX6cmfv4fl
	hdCSURVmHRK3zb1JAZG+aKcLDF2JeP0biiUDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vDV/Nmlh9nErTI2vQfkP5cU1VWDU/zvj
	IKoq4ctN89KW8yHN/tNnIT2J8anhb4P/NAjprPv6iDXtxLMXHH81KQoUXsdsMZ1u
	yZ8MpcdFHcYCoxHH+54X7Tl6Z7zP8FGBybh3akMl1MnMuXYxHkodO7d+RCOfofFV
	3uDUELkBl0s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DB9F9A25CC;
	Mon, 15 Mar 2010 13:12:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2EF11A25CA; Mon, 15 Mar
 2010 13:12:39 -0400 (EDT)
In-Reply-To: <A55E5483-425E-4303-87F2-FABC46F6BFE5@pelagicore.com> (Jeremiah
 Foster's message of "Mon\, 15 Mar 2010 17\:13\:55 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F6FF7F3C-3055-11DF-A1C5-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142223>

Jeremiah Foster <jeremiah.foster@pelagicore.com> writes:

> error: refusing to update checked out branch: refs/heads/master
> error: By default, updating the current branch in a non-bare repository
> error: is denied, because it will make the index and work tree inconsistent
> error: with what you pushed, and will require 'git reset --hard' to match
> error: the work tree to HEAD.
> error: 
> error: You can set 'receive.denyCurrentBranch' configuration variable to
> error: 'ignore' or 'warn' in the remote repository to allow pushing into
> error: its current branch; however, this is not recommended unless you
> error: arranged to update its work tree to match what you pushed in some
> error: other way.
> error: 
> error: To squelch this message and still keep the default behaviour, set
> error: 'receive.denyCurrentBranch' configuration variable to 'refuse'.
>
> 	I am unclear about my next move. Should I just set
> 	receive.denyCurrentBranch to 'warn' and then my commits locally
> 	will go back up to the server?

After it becomes clear about your next move (people will try to help you
in this thread), please also tell us what information you found lacking in
the above advisory text that you had to ask this question.  The message is
trying to help you decide what your next move should be, but apparently
did not do a good job, and we want to know what improvements we should
make.

> 	Or is it smarter to just create a bare repository, clone some
> 	content into it, and then push?

It depends on what you are trying to achieve by pushing into this
repository that is not bare, iow what this pushed-into repository is used
for.

Pushing into a repository is done for two reasons:

 - You push into repository A so that the development done in other
   repositories B, C, D,... can all be collected, kept safe, and
   transferred out to other repositories (iow, B, C, D uses A as a shared
   meeting place).

   This is the primary use case of "push", and because in repository A
   there will not be any development of its own, people make A a (shared)
   bare repository.

 - You do perform your own development in repository A, and you would want
   to interact with other repositories B, C, D,..., by doing "git pull B"
   etc., but for network configuration reasons, you can only make
   connection to A from B, C, D..., and not in the other direction.  In
   this case, because "git pull B" run on A is "git fetch B" followed by
   "git merge", you substitute the first "git fetch B" part by running
   "git push A" on B instead, because you can make connections from B to A
   but not A to B.

   In this case, you do not want your "git push A" run on B to overwrite
   the branch that is checked out in A, and the above error is issued if
   you attempted to do so.  This would show a proper arrangement for such
   a "push instead of fetch":

   http://git.wiki.kernel.org/index.php/GitFaq#push-is-reverse-of-fetch
