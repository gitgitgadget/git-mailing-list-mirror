From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase : knowing where I am...
Date: Wed, 10 Apr 2013 11:13:43 -0700
Message-ID: <7vvc7umey0.fsf@alter.siamese.dyndns.org>
References: <1124759476.1420642.1365583233806.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Jeremy Rosen <jeremy.rosen@openwide.fr>
X-From: git-owner@vger.kernel.org Wed Apr 10 20:13:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPzWp-0007lQ-98
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 20:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936047Ab3DJSNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 14:13:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38114 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765595Ab3DJSNq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 14:13:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5CEE1598F;
	Wed, 10 Apr 2013 18:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9nqr9Tt6VRgxXsiZr6/I7wneJbM=; b=QEwnL2
	8FJOzUZ1lKi/nmHRNDj9s1XOiTLj4gnezY4wsidIZaaT+twndMKO51TnBVQRgXuw
	HFfzkcCsNxrhj1aDHXXYJnvbYWoLLhMc99fQgKEEqsNoflv5OlEXGRayUpouRNAD
	fLGVMDIKSpkjyWCqt/ax1MYTfmxbtnt0QqYTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=owL1MPVwmdHA58P+cnm5PU4svfwwQAn+
	IAzyVsHbZvpZ+keQEAq8eBlsSAyEtt/NKZkiu3i7zBMknevc9Kj1XWo0bP8TQ3Ib
	na6o+9lHRxRRZmog5bkjoiDCrFp3yQcs6YwFd0/NM3ijjG+vLW+Hb/ce77TBA8hr
	RKiAMus/0nI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDE7F1598E;
	Wed, 10 Apr 2013 18:13:45 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3742D1598A; Wed, 10 Apr
 2013 18:13:45 +0000 (UTC)
In-Reply-To: <1124759476.1420642.1365583233806.JavaMail.root@openwide.fr>
 (Jeremy Rosen's message of "Wed, 10 Apr 2013 10:40:33 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6203F0A0-A20A-11E2-9BC3-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220712>

Jeremy Rosen <jeremy.rosen@openwide.fr> writes:

> is there some way to know how far you are within a rebase when the
> rebase is interupted by a conflict other than the message given by
> git rebase when it was interrupted ?

I do not think there is a "git $anything" command to do that, but in
the meantime you could "cat .git/rebase-*/git-rebase-todo" or
something.

Recent trend is to teach "git status" more about these internal states,
so with time the command may learn to include this in its output.
