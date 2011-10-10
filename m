From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Fix some "variable might be used uninitialized"
 warnings
Date: Mon, 10 Oct 2011 16:59:53 -0700
Message-ID: <7vty7gieiu.fsf@alter.siamese.dyndns.org>
References: <4E6D0E74.1020801@ramsay1.demon.co.uk>
 <7vpqj6olfa.fsf@alter.siamese.dyndns.org>
 <4E6FDBA4.6050505@ramsay1.demon.co.uk> <4E90751C.4030409@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Oct 11 02:00:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDPlK-0004mY-1z
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 02:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564Ab1JJX75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 19:59:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59173 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061Ab1JJX74 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 19:59:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 012BB55C8;
	Mon, 10 Oct 2011 19:59:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=/uFyt+HkDxw67SBM+r8O/6ro2PU=; b=t2nnSkfVOFe33bDVv9lK
	qlxmfIH+nGe+CKPP4KK6d48w9yiaVbwsqV8VLnD2vDZCoL7xi9lTMf8E2hbXVHae
	84iiqyDmVJ0Kf0BX29HKWSspmhu2songssh1t6KW4Db1SvNs930pKxrxgmPmLMT4
	iPuf1aaxuH/x7RxKOOnexF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=pgEMcb30jubDsP+r6Ti9IqB5yuHZhYI0frm2egHayPP6hq
	DGUwCCo7nUDYAHBx8V4QRhpU4AQFn/bU3I/51P7AtkcFb3mWeHpRV9c11NGTQPtB
	ptkhtowrF9lh+XhDnZ39lRmvz61rRB5i2CsfCCTWY6CeNhqWVl8DoGIgnZ93k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECF8155C7;
	Mon, 10 Oct 2011 19:59:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5782A55C6; Mon, 10 Oct 2011
 19:59:55 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F39C18A4-F39B-11E0-B2EF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183271>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

>> [I don't think traverse_trees() would ever be called with n == 0 anyway; the call
>> site in builtin/merge-tree.c is called with the constant 3, and the call-chains(s)
>> which start from unpack_trees() are protected by "if (len)", where 'len' is unsigned.]
>
> When patches don't even make it to pu I just assume you hate them so much that
> there is not much chance of them being applied and simply forget about them.
> In this case, since compiler warnings are a bugbear of mine, I'm hoping that
> you just forgot about this one ... :-D  [if not, sorry for the noise].

Thanks for a reminder.

The reason a patch may not hit 'pu', unless I or other people whose
judgement I trust explicity say "the approach taken by the patch is
utterly wrong" is either because (1) the discussion for or against the
topic is still going strong and there is little chance of it getting
forgotten by everybody, (2) I do not see much discussion for or against
the topic, and I am indifferent, or (3) the patch was just lost in the
noise.

So a good default strategy for a series that do not hit 'pu' is to
re-post. Such a perseverance was what took format-patch to hit Linus's
tree in June-July 2005 timeframe---we wouldn't have the command today, had
I given up back then ;-).
