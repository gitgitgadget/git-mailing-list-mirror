From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-archive --worktree-attributes (1.8.2)
Date: Tue, 09 Apr 2013 14:12:35 -0700
Message-ID: <7vk3obpfwc.fsf@alter.siamese.dyndns.org>
References: <CAFGOX=VXifkn4oNkqLLF_WG5Dzf4rjd15EV7C=9a_H9CTM+w2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Amit Bakshi <ambakshi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 23:12:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPfqN-0007b9-R6
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 23:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935039Ab3DIVMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 17:12:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59710 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934733Ab3DIVMi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 17:12:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5667C15625;
	Tue,  9 Apr 2013 21:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/2aO04uibFQHdjyw+bbNrYwKBLY=; b=n+9Vth
	M4i0xgJbIwAUiOhcsNiybVd+1BhO66/1k66Kbzd8mfpyrsg3F2IE1fK29P3LPMvJ
	wzJ+x0gcXS1hTgbkOQFNCoDcjoAjiaWpNH2q4K17IIus50dDjExJ6NkFIR3FZsrR
	PwHiR7PSjmdc15b/bnBBNEbHUfpudtsBaPudQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rlS8a0n1tjw3vDuhWjqNS6Q4L962ckQk
	Xehrsh3dxj1NPwDQjcO5R3camaeb8c99lXsJlRLqbbgO6v7GkUv7mKhnp0w5ouOL
	9Oo8cW4FhQ01GKLhArHYlLlOO8XNTzdFtyHGql5cCwJm4PcsJiNleipSFNa+IW2t
	nQ4Wu2GrXfg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A41B15624;
	Tue,  9 Apr 2013 21:12:37 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8DF4C15622; Tue,  9 Apr
 2013 21:12:36 +0000 (UTC)
In-Reply-To: <CAFGOX=VXifkn4oNkqLLF_WG5Dzf4rjd15EV7C=9a_H9CTM+w2Q@mail.gmail.com> (Amit
 Bakshi's message of "Tue, 9 Apr 2013 13:43:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 33FD4C5C-A15A-11E2-9266-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220635>

Amit Bakshi <ambakshi@gmail.com> writes:

> Hi,
>
>  In the help for git-archive it states:
>
>        --worktree-attributes
>            Look for attributes in .gitattributes in working directory too.
> ...

The worktree-attributes should read from the worktree.  It should
not pay any attention to where you are in the directory hierarchy,
i.e. your current working directory (aka $cwd).

> Would you accept a patch that either adds an option to explicitly set
> the .gitattributes file or would let --worktree-attributes look in
> $PWD.

The former, possibly, if accompanied with a good justification and
implemented cleanly.

The latter, definitely not.
