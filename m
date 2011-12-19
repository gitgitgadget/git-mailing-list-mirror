From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How can I do an automatic stash when doing a checkout?
Date: Mon, 19 Dec 2011 14:24:57 -0800
Message-ID: <7vy5u8kxmu.fsf@alter.siamese.dyndns.org>
References: <jcki8u$oip$1@dough.gmane.org>
 <84ty4ycdcc.fsf@cenderis.demon.co.uk> <jckvpk$i8v$1@dough.gmane.org>
 <4EEF736A.4070802@ira.uka.de> <jcobbo$jab$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: DeMarcus <demarcus@hotmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 23:25:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcldr-0006o8-7P
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 23:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764Ab1LSWZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 17:25:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61253 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667Ab1LSWZA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 17:25:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50C726FE4;
	Mon, 19 Dec 2011 17:24:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lHrdRl9FdP0W3JJQ2DY4S+Zp6C8=; b=xzX+bm
	Sp5W+puByijEkKl4DRNzfknEHHIcnmlsC0ELPORJ19YypLA6xTeHgPK8AeLGS8Mv
	9uCrZslaCyiOg/P9FvwYtMqe5xmXZZGCQxNbMgY+kphHwOHQuvvdvoA9F0qsZ6eO
	+rPKyvY1ZY4eSBA5ZgW+TArCTcxmMTZeBfeQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z3jhyoEvJBSext2n4lCzA2Hu4ga1RIEx
	j41rVayrDHDIagBMmdz70z3dWm/9sXwTD8DeSenp4x+M7hITeeJXKtg3RgsaxeDm
	5K0GzZhl2LosD80mMFd7EKLTlxfqgg5oUNfx7dEb2rrpyo8rcsKKnhtFANHnr1pa
	3/q3/tmJY6g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 442B16FE3;
	Mon, 19 Dec 2011 17:24:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C39466FE2; Mon, 19 Dec 2011
 17:24:58 -0500 (EST)
In-Reply-To: <jcobbo$jab$1@dough.gmane.org> (demarcus@hotmail.com's message
 of "Mon, 19 Dec 2011 22:46:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 491CEF58-2A90-11E1-AD7F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187480>

DeMarcus <demarcus@hotmail.com> writes:

> ... I don't really like to go back rearranging. I prefer to keep things
> spread out at first and then inserted properly when it's time. But maybe
> I'm just unused to the git workflow.

That does not have to do much with "the" git workflow.

If you are a kind of person who likes to work on N things concurrently
without ever making and recording mistakes but would rather keep
unfinished work without committing until done, you would need to have them
in your working trees. By definition you would need to use N working
trees, each of which permanently checks out its own branch, instead of a
single working tree where you checkout one of N branches at a time to work
on.

That is also a perfectly fine git workflow that we support with the
contributed script git-new-workdir.
