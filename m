From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] git checkout refs/heads/foo checks out branch foo
Date: Mon, 07 Feb 2011 12:53:11 -0800
Message-ID: <7vwrlbtvm0.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.10.1102062234010.3788@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 21:53:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmY5L-0004VC-NW
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 21:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239Ab1BGUxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 15:53:19 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39705 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174Ab1BGUxS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 15:53:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 77014416B;
	Mon,  7 Feb 2011 15:54:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FYGo0ZXQYFEGehtaepHQx7R9bh0=; b=aaqQI/
	d0q1wYGaDTI/mqMxtt07j5tXyLoAxhHn2fH4z9ueFXt3ctNMwGbAAIUSsCchauc1
	C+488bNTlNDj91uZRvFuXZsrsl1YsuBGpTo18Rvvo+pbqys6AxYg92ArYZAi+S0w
	FJmznR6+OxFjqEzk+izocWKy/2g0/3AgjtpB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fP0EE/ppRDmg2UcSR6s2b/zJyvZByrgX
	70vGTmTF13Pv5Cl4Mk4ftuZp+dzSzuTy+2iIqPGXOsPOKshjVYbCDanUCeof44E9
	rGUlTX33VI8FCqCUDerXjg7NI1KlCJWQczJQ8j2sdxt9FLc2TTOU0JBXBbAn2A63
	uVQeJxJHPFQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 564A4416A;
	Mon,  7 Feb 2011 15:54:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4093D4169; Mon,  7 Feb 2011
 15:54:09 -0500 (EST)
In-Reply-To: <alpine.DEB.1.10.1102062234010.3788@debian> (Martin von
 Zweigbergk's message of "Mon\, 7 Feb 2011 06\:01\:51 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6B377F18-32FC-11E0-936B-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166288>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> Proposal:
>
> 'git checkout refs/heads/foo' (or 'git checkout heads/foo' for that
> matter) does not check out the branch, but instead detaches HEAD at
> foo.

Yes, and it is deliberately so as it is a guaranteed-sure way for scripts
to work around potential ref ambiguity when talking about the branch
called 'foo' to spell it out with leading refs/heads/.

As long as you do not break scripts that guard against breakage you are
proposing by saying "refs/heads/foo^0", we are Ok with the proposal, I
think.

> Migration plan:
>
> Make 'git checkout refs/head/foo' emit a warning in the next 1.7.x
> explaining that its semantics will change in 1.8.0. Then change the
> behavior in 1.8.0 and remove the warning.

Reasonable.

Thanks.
