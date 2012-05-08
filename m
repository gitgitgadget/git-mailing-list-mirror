From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git fetch/pull stopped working
Date: Tue, 08 May 2012 12:37:18 -0700
Message-ID: <7v8vh2v501.fsf@alter.siamese.dyndns.org>
References: <CADB4Qb1BhWpm1mAwiHy+edySvo7P+YcvrSiTSc8dVzKQsnNCfQ@mail.gmail.com>
 <7vehqv36aw.fsf@alter.siamese.dyndns.org>
 <CADB4Qb35FfTL=XX04iR71+2Rg8p4s2roqAF8b_BdFNP9YN=sfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Egor Ryabkov <egor.ryabkov@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 21:37:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRqDv-00059s-W8
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 21:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756646Ab2EHThX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 15:37:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60921 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756625Ab2EHThW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 15:37:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F04637AB7;
	Tue,  8 May 2012 15:37:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WsncfeLnWh5Z/fQZbpJdO7M5MPo=; b=wkJ0mM
	Kyf3ecje6UIygH11AGKFkLHS8KZuAEmfRDlQtb6Pmvbd+BdOZp9ap3qgJBSJUjso
	EHOQge8JNoWtIjZN5+QbcRq1uUA3vYbLVoSH/0MolVmiiKG8dr7sP1pyeKteJzVA
	oxH4axy6JID+K65q9D9hTY7um3qGOL+u/HF1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wGcix3BQpSEt510VM1TtyBznnO5CFasR
	S33ZNeUgooCEa/vDOjlKUatBpwD3yET+6FjyK8mju0hmMbTmHAbydxWyFog7VtaG
	1lscKS4/7D41P1t1p0qSC8NwtTNA+Nj0sFKyJDswr48lkTMNEf29cmEe4i5UvA+d
	6jVBsInlzLw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8DE17AB6;
	Tue,  8 May 2012 15:37:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 614C97AB3; Tue,  8 May 2012
 15:37:20 -0400 (EDT)
In-Reply-To: <CADB4Qb35FfTL=XX04iR71+2Rg8p4s2roqAF8b_BdFNP9YN=sfA@mail.gmail.com> (Egor
 Ryabkov's message of "Tue, 8 May 2012 17:59:05 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A1527B8-9945-11E1-B120-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197417>

Egor Ryabkov <egor.ryabkov@gmail.com> writes:

>>> "$ GIT_TRACE=1 git fetch" gives somewhat different output on local PC
>>> and server:
>>> http://pastecode.com/bd3fc1a79f8e9d1eaf30911d9895938051c472f4
>> ...
> Did you imply that it's better to paste logs directly in the email?

No, I did not *imply* it; it just didn't "click" that the above was a
URL to a pastebin.

> ############# AWS results #############
>
> $ GIT_TRACE=1 git fetch
> trace: built-in: git 'fetch'
> trace: run_command: 'ssh' 'git@github.com' 'git-upload-pack
> '\''(username)/(reponame).git'\'''
> ERROR: Repository not found.
> fatal: The remote end hung up unexpectedly

Assuming that these "(REDACTED)" are not hiding some crucial difference
between the two destinations, it seems to be the git client installed on
the latter one seems to be the one that is at fault.

But as I said, "ERROR: Repository not found." does not seem to match any
message of the released version of Git, so I cannot even tell where it is
failing.

It could be that the message is coming from a customized version of ssh
login handler github uses to shard and map the user accounts to
directories (it would have said "fatal: '/var/tmp/xx' does not appear to
be a git repository" if they were running the vanilla Git), and if that is
the case, perhaps the argument thrown at git-upload-pack from your local
box and the problematic box somehow look different to Github, but that is
in the "(REDACTED)" part, so I cannot tell from what was pasted in the
pastebin.

Incidentally, oogling [github "ERROR: Repository not found."] seems to
give quite a many hits.
