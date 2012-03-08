From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rebase -i: new option --name-rev
Date: Thu, 08 Mar 2012 14:13:36 -0800
Message-ID: <7vipiebv1r.fsf@alter.siamese.dyndns.org>
References: <1331203358-28277-1-git-send-email-domq@google.com>
 <1331203358-28277-2-git-send-email-domq@google.com>
 <87399jnyxh.fsf@thomas.inf.ethz.ch> <7vaa3qewqw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Dominique Quatravaux <domq@google.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 23:13:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5lal-0001Ug-72
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 23:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758834Ab2CHWNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 17:13:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46807 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758831Ab2CHWNi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 17:13:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E03C262E6;
	Thu,  8 Mar 2012 17:13:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iJ3Na2ksicfF4Ze/M8T0jtstbZM=; b=grS5ww
	0w3dAhqVYic7s9zTLixU64yD5QxwwRj5epiX20ngB9OzSpv1ARtbX8A5axT3CJKR
	bvRno45US94Eq0mVmxEVkPuEMrUGugBdhbsBurFn+yixgZMI2I5fb4lpFn21pbaw
	79IL0nfhURl7lDpAjzqaQ+yjPbwtAs6ricqGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oR8M2hJXp1woqPqUNf4gRzA0WYfxi9FR
	QfZ+7hp+DKtTfJycvu92k5Mq/SUCmlrAqiIxjtxH0+OT8YG1/aZYgDC1IdbrRxNG
	hifGR1dqlItLg+zI8WHd3rbBWGWmWWXgFjgTMtF9Ze/mG87tj1vUp8cgy8m0bs/0
	/Q48YvGCf8o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D70B862E5;
	Thu,  8 Mar 2012 17:13:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6ABE762E3; Thu,  8 Mar 2012
 17:13:37 -0500 (EST)
In-Reply-To: <7vaa3qewqw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 08 Mar 2012 11:08:39 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4092FDE-696B-11E1-BC23-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192659>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> Dominique Quatravaux <domq@google.com> writes:
>>
>>> If set, the second column of the rebase todo contains named revisions (obtained
>>> with git name-rev) instead of short SHA1s.
>>
>> Hum.  I'm not sure yet if I find that very useful, since frequently the
>> names will just be 'topic', 'topic~1', ...., 'topic~N' if you are
>> rebasing a topic with N+1 commits not in master.  But you might, so who
>> am I to judge.
>
> I think the only use case where this might be useful is when you
> have totally undescriptive one-line description to your commits that
> they alone do not help distinguishing the commits being picked, e.g.
> ...

This may need a bit of clarification for readers from the future.
If you _were_ somehow interactively rebasing changes made on two or
more branches into a single branch, knowing which branch each commit
came from may have value, even if your commit titles are descriptive
enough.

Today's "git rebase -i" wouldn't do something like that, and we will
not know how the user would interact with such a yet-to-be-written
tool, so it is too early to judge if using "topic~1" is the desired
improvement or not at this point.
