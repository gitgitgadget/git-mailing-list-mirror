From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase -i and the reflog
Date: Wed, 10 Feb 2010 14:23:05 -0800
Message-ID: <7v3a183f3q.fsf@alter.siamese.dyndns.org>
References: <fabb9a1e1002101419x40844a42s21108aaa849430c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 23:23:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfKxq-0001g1-I4
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 23:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756625Ab0BJWXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 17:23:13 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133Ab0BJWXM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 17:23:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 495E298D54;
	Wed, 10 Feb 2010 17:23:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kx0QiIJme1jXMqo5HdcIz+M+/1I=; b=QJ+sOS
	QdclcLHsT7GVobCSDjlkRpBdBJEFG1YJZjII/nXZcwhju0L6K+x79q6cbIcEE/bv
	Wtv/BUo1OYC8IL+f3m1ERROZUMNxvmtd+bMpF/7ZSZB4sv0xga/JQgYPTaeltUqZ
	cn9Xk9x+nx3edAu7Bqdp/sSly2pwG2AMDyzpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dJkJXQbFUCCHKfLVtoT8kEtpUVL7gO4b
	a9oT/mAdRXwuhZ8wSyr0ifdWcAwh87YxH6MVupUOVYI0SbYGfHSJ4p8fAiQqE4bh
	3mZcafpZoJng/CCyVmMnSCQR/5R0r7LJw/albAI5QNYzZhGItCjb3s0gW92aTqiQ
	MxobXE35J88=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DA8C98D50;
	Wed, 10 Feb 2010 17:23:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 374DA98D4F; Wed, 10 Feb
 2010 17:23:07 -0500 (EST)
In-Reply-To: <fabb9a1e1002101419x40844a42s21108aaa849430c1@mail.gmail.com>
 (Sverre Rabbelier's message of "Wed\, 10 Feb 2010 23\:19\:59 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE8CF114-1692-11DF-AFFE-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139560>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> I use "git rebase -i" a lot, and as a result the output from 'git log
> -g' and 'git reflog' is a tad messy. That is, it's (afaik) not
> possible to check that after my rebasing did not mess things up using
> something like 'git diff HEAD@{1}'.

Yes and no.  I too suffer from it but only when I rebase a detached HEAD
state.  If you rebased a topic, "git diff topic@{1}" (or "git diff @{1}")
would give you what you want.
