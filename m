From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there a way to cherry-pick a merge?
Date: Fri, 14 Jun 2013 14:54:40 -0700
Message-ID: <7vobb8mk7z.fsf@alter.siamese.dyndns.org>
References: <7v7ghwo4u4.fsf@alter.siamese.dyndns.org>
	<20130614213656.6813.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "George Spelvin" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 23:54:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnbxH-0001WN-OU
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 23:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480Ab3FNVyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 17:54:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33038 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063Ab3FNVyn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 17:54:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF65E28F9A;
	Fri, 14 Jun 2013 21:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ixQ/5Q7tVgsPYvY8ydWc13ZzNsE=; b=Jf5+8d
	0HQ0QhHxPz9Ul3S6AxGjYLXarCsWr8a1kPyvY1Y+s+Xvxxgw4EQ29NPxKOJxYBum
	AXiPQm9ljNFfhDx1rjV+GLr9RLTsFHi8cnZrsmA6otCDlrcX8JmnvZndMAKHrdDy
	YiRTZ3Tr+D7KoHyy8zZWzDZgbxQiKHlSm/S4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jRRE1doWWzO3sbp6YWpA9w6EGs6bzbed
	vOKmpmjjbQFj4QQY1CkaQLXhOQxUqDSYqXTJ68JQhr/9Xlyo/Qsv+YPvD9e2/VZK
	l5GjoNjk0BP42ZXwGCZwDHkjC+G3ve/hT+Vu06kz72IuqZGr5vDjav0x2RJT9xC2
	EnLDpVLHRh0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E51A728F99;
	Fri, 14 Jun 2013 21:54:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65BA828F98;
	Fri, 14 Jun 2013 21:54:42 +0000 (UTC)
In-Reply-To: <20130614213656.6813.qmail@science.horizon.com> (George Spelvin's
	message of "14 Jun 2013 17:36:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 04C4D7B8-D53D-11E2-8184-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227923>

"George Spelvin" <linux@horizon.com> writes:

> "George Spelvin" <linux@horizon.com> writes:
>>> Sometimes I'd like to repeat a previously performed merge, preserving
>>> the commit message.  And, if possible, the conflict resolutions.
>> 
>> Is it "git merge commit^2"?
>
> I suppose that was an obvious one to leave out of my alternatives list.
>
> This is what I've been doing, but it requires I cut and paste the commit
> message.  Preserving timestamps, author, etc. is even more awkward.

In the meantime, "git commit --amend -C commit" would be a
workaround, I would guess.
