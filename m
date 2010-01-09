From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] Support relative .git file in a submodule
Date: Sat, 09 Jan 2010 09:20:18 -0800
Message-ID: <7vhbqvry99.fsf@alter.siamese.dyndns.org>
References: <32541b131001081524g43d54a44i582dd286c1dfe7a5@mail.gmail.com>
 <1263008201-27429-1-git-send-email-brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Lars Hjemli <hjemli@gmail.com>
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 18:20:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTezR-0008Ge-SO
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 18:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731Ab0AIRUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 12:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752263Ab0AIRUe
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 12:20:34 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712Ab0AIRUe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 12:20:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E511F8F924;
	Sat,  9 Jan 2010 12:20:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=HgOQ9+uckcpKSn17Y42tzsk+bnE=; b=IAhLHMXVI35VhN+rQJ9fhwH
	uC9QaSbdZv7Hxv/g0tMMkLHYEmDs3Rel7khf7N4CbcaI8w7FelVgvHRNb2JJ6LIf
	9/nJ7tJ1Gysw0dprAaJnelIj4tgaSULbtrusaAcSZ9nltiKpjqa8zMaKpbqQUY/w
	5tDYGdKJPK0b/QHjyM/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=LwPSqtdglO4zENe5jp16gCJrk+8QNuY+nBzZ/xXO7r7r/TS/A
	Rx8nStKFZuto4dhI8HMsCGfz2KeKLqDkS7n9zyjI1b5gX2VkwK2mOVuVj+Zban3w
	MygnpZt3nj9wZp4mT48Fc0tP8/+ND8NlpbF7mkBSgipyXbZSItT03rJqas=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BF018F920;
	Sat,  9 Jan 2010 12:20:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBF748F91E; Sat,  9 Jan
 2010 12:20:19 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 45F60232-FD43-11DE-8F42-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136535>

Brad King <brad.king@kitware.com> writes:

> Exactly.  In fact the experiment I was doing involved creating submodule
> repos inside the main .git and linking to them from the work tree
> subdirectories.  I'm looking into combining the approach with that of
> git-new-workdir to keep submodules in the same object database.

Nice.

I recall we discussed design ideas to allow moving the submodule worktree
and repository more easily using "gitdir:" when we first discussed the
patch series.  I am glad to see finally it is going forward.
