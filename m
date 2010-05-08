From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Add [] as an alias for a reference to the empty tree
Date: Fri, 07 May 2010 22:24:57 -0700
Message-ID: <7vhbmjc6dy.fsf@alter.siamese.dyndns.org>
References: <1273250247-20762-1-git-send-email-pkj@axis.com>
 <20100508045319.GD14998@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 08 07:25:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAcXL-00054K-Nd
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 07:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361Ab0EHFZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 01:25:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53826 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab0EHFZH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 01:25:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4452AB1CC6;
	Sat,  8 May 2010 01:25:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i+oQFYxfvrQ2iQJrIHE1kn0BJDY=; b=yWRQmP
	Dvcp6zCwVuzwWh4PpXdWWQDI9nRWz7h/gUxloxaHxeSAAHZEhSlhUHpsZ/d6mD4s
	gXPvKhtQwcZjIGGRBC7W9AgmoFJzXbGlSDEG6yUGd8046uL1jusiNA1b69U5tFLb
	J9Xtz98FOWWR8hGzRcj00+aZgB7AxTg2zLuYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fkxEhj5/TOoYueSdlDoxTC9Y3EkZoark
	W0iWgyzkxXAw7ctKvSCpYvffZ5lRn/F7kPLPKadp2jm8Ns+RXU6j2KvzXH2N8JOs
	UzDEZW63plg5L9hY9G+tor5t95QB8RMnZTFIUNwuiQmdFfCM+TtE4dEzxJee6avR
	L9oEEuPyX5E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 12276B1CC5;
	Sat,  8 May 2010 01:25:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B9BCB1CC4; Sat,  8 May
 2010 01:24:58 -0400 (EDT)
In-Reply-To: <20100508045319.GD14998@coredump.intra.peff.net> (Jeff King's
 message of "Sat\, 8 May 2010 00\:53\:20 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0D46E628-5A62-11DF-9AD0-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146640>

Jeff King <peff@peff.net> writes:

> Based on past discussions, I suspect other people would be interested
> in:
>
>   $ git diff [index] HEAD
>   $ git diff HEAD [index]
>   $ git diff [working-tree] [index]
>
> etc. I don't think I would want to type those all the time,...

If you go that route, why not use INDEX and WORKTREE (all caps) to at
least avoid the brackets?  I am not personally interested in [] at all,
but as part of that repertoire of syntactic sugar tokens EMPTY might be
able to sneak in [*1*]

[Footnote]

*1* Without that "[]" syntax, the feature is "Meh" for me, but with the
syntax, it becomes "Yuck".  The reason I am not interested in the feature
is because I don't see much value in running "git diff EMPTY <anything>".
Perhaps "git archive" might be what the user really wants to find.
