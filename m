From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cherry-pick applies some other changes than the specified one?
Date: Mon, 21 Mar 2011 13:21:21 -0700
Message-ID: <7v62rcp6m6.fsf@alter.siamese.dyndns.org>
References: <AANLkTikE5AqJyShN+GfFYe0kBS=ShGnKQcnwbarNZrjm@mail.gmail.com>
 <7vwrjssbfk.fsf@alter.siamese.dyndns.org> <4D877FAD.9000807@viscovery.net>
 <4D879516.3060204@gmail.com> <20110321195846.GA4277@elie>
 <4D87B00D.2010905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:21:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1lbg-0007SH-U9
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 21:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564Ab1CUUVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 16:21:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65500 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab1CUUVe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 16:21:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2224D478E;
	Mon, 21 Mar 2011 16:23:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pb7jOoQL068YWtugDqOGoaTqfT8=; b=CbyUiC
	2k9ntYkIcG8Ami3eqv4OvETlNkwvpOhczVrewKEYMMBeDqJS1CvYOc6EpSPeF5n+
	GLG9AuGWa4qDAFTRHZOr9t/0pm+m2sD59ifhvyyN2Zh7hciG1IXJ7o7ZQyYKuKZr
	SeLWdz6i5oTZmDtjht1XY6KfGF03oPalYLwWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pO/I5/1tnyjmjCbocHhh30gtRk22b67u
	qHE8JPAe84D5PWS0KD1109u5E64jArDUq67L++u/iFAtGoa1v3tKqiYNuDeRv/Nn
	ztcVKkg+XTsfmKnhI5c82h/zbRglnobfimCqs+egjeNgc7EqExNw3wdXDbJtZKiJ
	PJy/wb4EF4I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D4754478C;
	Mon, 21 Mar 2011 16:23:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8815C478B; Mon, 21 Mar 2011
 16:23:02 -0400 (EDT)
In-Reply-To: <4D87B00D.2010905@gmail.com> (Piotr Krukowiecki's message of
 "Mon, 21 Mar 2011 21:07:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 089F99F8-53F9-11E0-A771-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169661>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

>> Sure.  The index contains multiple competing versions, which you can
>> see with "git ls-files -u".  To compare the working tree and one of
>> those use "git diff --base / --ours / --theirs" (or -1 / -2 / -3).
>
> Thanks, didn't know about that (and it's not documented in diff man page).

These "compare a particular stage against working tree file" modes
only make sense when you are comparing the index and the working tree, so
the description is in "git diff-files" manpage but hasn't been ported to
the documentation of generic "git diff" frontend.

Perhaps we should.
