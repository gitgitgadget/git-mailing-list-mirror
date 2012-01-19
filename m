From: Junio C Hamano <gitster@pobox.com>
Subject: Re: post-update to stash after push to non-bare current branch
Date: Wed, 18 Jan 2012 17:00:29 -0800
Message-ID: <7vboq0ld5e.fsf@alter.siamese.dyndns.org>
References: <jf70vc$kol$1@dough.gmane.org> <4F171088.4080006@gmail.com>
 <4F1714AD.4090706@gmail.com> <7vwr8oljq7.fsf@alter.siamese.dyndns.org>
 <4F1764B9.90907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 02:00:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RngMo-0003Yw-2Y
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 02:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391Ab2ASBAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 20:00:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49529 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659Ab2ASBAc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 20:00:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE36162F8;
	Wed, 18 Jan 2012 20:00:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g/+1k8biPKTjESipNxqP7nPhoug=; b=n109cd
	Jp5xW9PMKX8y2mE/hwCC6Ei7DMqoJf1vMvF8vcpxyJiHn0kIXOakYpWl+V2r171h
	YjjOJ8CViwpAUaXkrr/U+jOSs/CFGpOvMMbpMGvAEc2/lQbkE1/rIZcxAw6n85Bi
	ofxw3+z1BVUu7LUHSvQUxkZ9ewQtiK46hoNSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sy6uUAWcXhtTktVohyxzToiGbOZn3OUY
	mEo7J29V5OLq7cd5EiiJFQY79G9CyNjivuAp3X0+3HsV1K3rn/jlX++fzWa/FJYf
	+cFhGI7wPuIaKc1dKuVcnei8p0JK7RmBQ6cHFY4byVeG+A00yCLCUU4oUOo2ukgL
	sNVWqNXKHuY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2AFE62F7;
	Wed, 18 Jan 2012 20:00:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3815062F6; Wed, 18 Jan 2012
 20:00:31 -0500 (EST)
In-Reply-To: <4F1764B9.90907@gmail.com> (Neal Kreitzinger's message of "Wed,
 18 Jan 2012 18:32:57 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC1115DE-4238-11E1-B614-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188784>

Neal Kreitzinger <nkreitzinger@gmail.com> writes:

>> Have you checked where in the filesystem hierarchy that script is run
>> (hint: pwd)?
>>
> echo pwd in post-update echoes /path/WORKTREE/.git in git-push stdout.
> ...
> 'git-checkout -f' works manually, but in post-update hook...

Stronger hint. Did you run "git checkout -f" in /path/WORKTREE/.git to
back that "works manually" claim?
