From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] user-manual: Document that "git merge" doesn't like
 uncommited changes.
Date: Sun, 22 Nov 2009 15:57:52 -0800
Message-ID: <7vy6lyaz9b.fsf@alter.siamese.dyndns.org>
References: <1258732767-12741-1-git-send-email-Matthieu.Moy@imag.fr>
 <1258732767-12741-3-git-send-email-Matthieu.Moy@imag.fr>
 <7vk4xlvtib.fsf@alter.siamese.dyndns.org> <vpqljhyi4oi.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Nov 23 00:58:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCMJj-0005FB-Cs
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 00:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755864AbZKVX54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 18:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755861AbZKVX54
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 18:57:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53566 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857AbZKVX5z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 18:57:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 798698280B;
	Sun, 22 Nov 2009 18:58:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q9ItLB4DOjlb5BbPIt57YKOv4tE=; b=AlkCLI
	rkgQVxCuMVa6WkP5dHAPc6e4Z1Ld5bAjIIt3oGm+2nuil86p4fXdirXQaeAti/NT
	CG3AIfOfoCXWqKPX2uGXkJrKFr9q81RLI+tdZS8XtFXgXt5tmbmKveGlJVKti+rb
	/w8+RjxJv3V8S6svDWPtzStizsRbm4q7OMR1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q3tk0U+Vt8z4asrbc7EBl7YUFxRf5rXE
	MahAY0VImT52tBKjJahUGp77/2dJpsWExZUSZQkQdLaHaPWr2Q0EgSgqdJjXD0OP
	mknrsB8antlVjNcIylJQSvw6L4BQxcXXESQlilp7ezNW2PPgUCFU/cXZylWKUZcC
	Zj2xGqbRKcs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 587D88280A;
	Sun, 22 Nov 2009 18:57:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7620782809; Sun, 22 Nov
 2009 18:57:54 -0500 (EST)
In-Reply-To: <vpqljhyi4oi.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sun\, 22 Nov 2009 23\:18\:53 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DC0EB076-D7C2-11DE-8B2A-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133468>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "but not the working tree itself" is not incorrect per-se, but misses the
>> point.  How about...
>>
>> 	A merge is made by combining the changes made in "branchname" and
>>         the changes made up to the latest commit in your current branch
>>         since their histories forke.  The work tree is overwritten by the
>>         result of the merge when this combining is done cleanly, or
>>         overwritten by a half-merged results when this combining results
>>         in conflicts.  Therefore, ...
>
> Maybe better. OTOH, it reveals another problem: Your "the work tree is
> overwritten by ..." tend to imply that the result is not commited,
> while the normal case is indeed to create a merge commit
> automatically.

Fair enough.  How about changing this part

>>         since their histories forke.  The work tree is overwritten by the
>>         result of the merge when this combining is done cleanly, or
>>         overwritten by a half-merged results when this combining results

to

	The work tree is overwritten by the result of the
        merge when this combining is done cleanly, and the result is
        committed. Otherwise it is
	overwritten by a half-merged results when this combining results

?        
