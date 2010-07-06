From: Junio C Hamano <gitster@pobox.com>
Subject: Re: messages confusing
Date: Mon, 05 Jul 2010 23:21:47 -0700
Message-ID: <7v630t5dvo.fsf@alter.siamese.dyndns.org>
References: <20100706053543.GA13054@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Jul 06 08:22:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW1Xc-00019H-3F
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 08:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002Ab0GFGVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 02:21:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55012 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743Ab0GFGVy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 02:21:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A13DFC01F7;
	Tue,  6 Jul 2010 02:21:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8S1wmRDLcFkZLIGxQiOQBdfpx50=; b=oSGuyu
	FJExoRKTTYPRG50xideO6KxvbD9Lx+PC4nDfj822aWs8cACyzPi1vxeRyTWjBSCL
	fZkuEe5Z0K7MiC3ehegctPkaQLry7h4Ys23CSF2eElB92nQUNBaJOHbwvplePi9d
	ge8Cc5PdStIF0e5ndPNjLyifU9CGNun2KrFRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TOwODKCVP+L9Edz9TiyHmMqCJDXObV1O
	zjO1BNAJ3/4qqml0oGqS/oMo1o2oErkLNDLeOOnbG7+zEy910njfJhoUc/BMt5fC
	cTjHCUAGSWL2RxF6IWO9s6aoKHRKr52RXlLYVaartJkK+kiXw35TdYxS8Of/MjO8
	+lkvHXxIEck=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EFB5C01F3;
	Tue,  6 Jul 2010 02:21:51 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6EEBC01F2; Tue,  6 Jul
 2010 02:21:48 -0400 (EDT)
In-Reply-To: <20100706053543.GA13054@vidovic> (Nicolas Sebrecht's message of
 "Tue\, 6 Jul 2010 07\:35\:43 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C3D6AEAE-88C6-11DF-8F43-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150325>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> I had those messages today
>
>   % git merge origin/master
>     Already uptodate!
>     Merge made by recursive.
>   %

This is quite an old message; I don't think it has much to do with 1.7-ness
of your version.

The first "uptodate" refers to your tree state being up-to-date.  You
already had the necessary changes the other history wanted you to
have---they were acquired in your history before you started this merge by
some other means.  Perhaps merging from other trees, or picking up
equivalent patches from mailing list, etc.

A merge commit is still created in this case, in order to record the fact
that everything origin/master wanted to do to your history has already
been reconciled to your history.  Otherwise "git log ..origin/master" will
still show commits your history does not have.
