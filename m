From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re: Gitk --all error when there are more than 797 refs
 in a repository
Date: Mon, 21 Sep 2009 18:39:55 -0700
Message-ID: <7v1vlzvjtg.fsf@alter.siamese.dyndns.org>
References: <6F87406399731F489FBACE5C5FFA04584BFA53@ex2k.bankofamerica.com>
 <878wgcbb52.fsf@users.sourceforge.net>
 <19124.8378.975976.347711@cargo.ozlabs.ibm.com>
 <6F87406399731F489FBACE5C5FFA0458518DE8@ex2k.bankofamerica.com>
 <4AB78910.7010402@viscovery.net>
 <6F87406399731F489FBACE5C5FFA0458518E11@ex2k.bankofamerica.com>
 <4AB7A2E7.5000601@viscovery.net> <874oqvc0n3.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"Murphy\, John" <john.murphy@bankofamerica.com>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Sep 22 03:40:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpuMg-0001xu-Rx
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 03:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbZIVBkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 21:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbZIVBkI
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 21:40:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64166 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbZIVBkH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 21:40:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B451F3BFBC;
	Mon, 21 Sep 2009 21:40:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oIhIMFzwg7LAgrouBy5alSxtoz0=; b=of5V3l
	h8Z0MGooo+iT99yJ+rVRGvCOxI+AoaPwmF0ppYPpnoPQEaACV2Q05Kt7tRpiY6pS
	pvCrKAf5ZSlRyDLLreUhJE+Sfu0+3Jw7Iv/91+88eG/VX4cTng9wPaMeH81/L+aR
	b7UrPyXO7VdqBVlOeSaHStaAUCsz4iZPmudIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dVks7AertNYsaAp+gXg+2n+Er+46cgwa
	ALWm1DkLWWS+yFA8ExQFSO6SO+GD29aA96gd4ixK8jBiBsbswgajRF6NySXxLSpM
	mUwPDAIOYHnRVbNnixGmoQYfs9EfnPUoMZT9XZyozhfbsG+z+MDvYWpOQ42GxecA
	WTV9byUsA3A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 73D783BFB8;
	Mon, 21 Sep 2009 21:40:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 694003BFB7; Mon, 21 Sep
 2009 21:39:57 -0400 (EDT)
In-Reply-To: <874oqvc0n3.fsf@users.sourceforge.net> (Pat Thoyts's message of
 "22 Sep 2009 00\:56\:48 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DA7ECE7E-A718-11DE-AFE0-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128917>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> commit 7f289ca8370e5e2f9622a4fbc30b934eb97b984f
> Author: Pat Thoyts <patthoyts@users.sourceforge.net>
> Date:   Tue Sep 22 00:55:50 2009 +0100
>
>     Avoid expanding --all when passing arguments to git log.
>     There is no need to expand --all into a list of all revisions as
>     git log can accept --all as an argument. This avoids any
>     command-line
>     length limitations caused by expanding --all into a list of all
>     revision ids.
>
>     Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
>
> diff --git a/gitk b/gitk
> index a0214b7..635b97e 100755
> --- a/gitk
> +++ b/gitk
> @@ -241,6 +241,8 @@ proc parseviewrevs {view revs} {
>
>      if {$revs eq {}} {
>         set revs HEAD
> +    } elseif {$revs eq "--all"} {
> +        return $revs
>      }

That looks like an ugly hack (aka sweeping the issue under the rug).

What if there are many tags and the user used --tags?  Don't you have
exactly the same problem?  Likewise, what if $revs were "..master"?

The right approach would be to understand what limit it is busting (it is
not likely to be the command line length limit for this particular "exec",
as it only gets "git" "rev-parse" "--all") first, and then fix that.

>      if {[catch {set ids [eval exec git rev-parse $revs]} err]} {
>         # we get stdout followed by stderr in $err
