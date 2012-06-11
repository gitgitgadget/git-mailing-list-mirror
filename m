From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "remote-tracking branch"?
Date: Mon, 11 Jun 2012 09:31:32 -0700
Message-ID: <7vr4tl7qu3.fsf@alter.siamese.dyndns.org>
References: <4FD6068D.1010509@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 18:31:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se7Wl-00012r-6Q
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 18:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755279Ab2FKQbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 12:31:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53598 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755083Ab2FKQbe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 12:31:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CB4C83A7;
	Mon, 11 Jun 2012 12:31:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dj7UBX3Ze9yxlE8NDvoSlyr95cE=; b=P27OaS
	gJLoOAaM4Li5YqBm5UwGmYeiqSvejuTS7C1JP0qs4MaGcHDE1Be+gOoPuszMvDkw
	PEV3F6qXJ6QhYpereDqPyxNXTZbmc8odNgeQAgraUqYAnsnYYLEzF0Ityov+ZtHB
	y3Z6zlzMOCfAC7a+jx17o7LGJklwO2hjuEEmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rm8LP6LS+/351PxAZZMiwGlvbSPYwy4M
	S3/b2n9Nop2H8g24OSo7rlBXlbufpzAO0BPD7meh3eV5Z9o7lmOZ58qKx50nwqdk
	Yi5RjKKHzHFetH1Ge20dSzud1n1402O0i+x4yLDLpBHqBjEIFJI8TbeXtQE101SJ
	aYmCbmAZ4U0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23BF183A5;
	Mon, 11 Jun 2012 12:31:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B149483A1; Mon, 11 Jun 2012
 12:31:33 -0400 (EDT)
In-Reply-To: <4FD6068D.1010509@xiplink.com> (Marc Branchaud's message of
 "Mon, 11 Jun 2012 10:54:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8318D02-B3E2-11E1-895A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199672>

Marc Branchaud <marcnarc@xiplink.com> writes:

> When I first read this I was confused by the term "remote-tracking branch".
> I see that the docs for "git remote" and "git branch" use this term for
> branches like 'origin/master', as does the glossary.
> ...
> I feel my interpretation is reinforced by the --track/--no-track options in
> "git branch".

They were added long after "remote tracking branch" terminology has
been established to mean the copies of last observed values of refs
at remotes, and back then nobody noticed that these misnamed options
were potential sources of this kind of confusion.  If anything,
these options need to be renamed if you want to avoid confusion.

Unfortunately, no concensus terminology for them exist; I find
myself calling them "the branch you integrate with upstream's
master", "the branch you forked from origin's topic", etc.
