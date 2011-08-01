From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: remove extra space from reflog message
Date: Mon, 01 Aug 2011 16:04:24 -0700
Message-ID: <7vk4awhgxz.fsf@alter.siamese.dyndns.org>
References: <4e3260f8.41d0e30a.741c.51cb@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ori Avtalion <ori@avtalion.name>
X-From: git-owner@vger.kernel.org Tue Aug 02 01:04:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo1XJ-0002xA-FZ
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 01:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656Ab1HAXEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 19:04:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55220 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752579Ab1HAXEc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 19:04:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3300223DB;
	Mon,  1 Aug 2011 19:04:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bqakcKuFi/Acx+UOoBZXdMXErFI=; b=I6Yveo
	a8Z7NO5T3K2MXdM6Qchxj9N9+8/px3JnCQ20FHu8g1szMzKbhDqs2rf66dS8bMNI
	uyAKGR6CbRbathyjUwPf2Q9IItmVogFj98JOuZkza35EwOjjkn4SDcOb6IeeIdpP
	tI6xCCURk1LDnGxOH2uTq1nPhseMNEFy1Zggk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JdIz0qNXcJwDPcuopiG3rdLOvPTop1Lj
	fmxXC+zLLxdAJrq7TvkBc/TmWmeo3VZNeVBtzvwqFJ1eTrRcvbYBjGIW+iPmDO9s
	LJNz1kBSObPRXd1fkvhoZDmDPpBBQe9yKY4jVjXhZKPedn/WI4n+6Uz30vm48uqv
	t5kpfMIiw7k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B11423DA;
	Mon,  1 Aug 2011 19:04:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C1C723D9; Mon,  1 Aug 2011
 19:04:28 -0400 (EDT)
In-Reply-To: <4e3260f8.41d0e30a.741c.51cb@mx.google.com> (Ori Avtalion's
 message of "Fri, 29 Jul 2011 10:19:26 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9BC67114-BC92-11E0-8C4F-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178425>

Ori Avtalion <ori@avtalion.name> writes:

> When executing "git pull" with no arguments, the reflog message was:
>   "pull : Fast-forward"
>
> Signed-off-by: Ori Avtalion <ori@avtalion.name>
> ---
>
> This is a correction of my earlier patch, based on the suggestion
> by Andreas Schwab
>
>  git-pull.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-pull.sh b/git-pull.sh
> index a10b129..eec3a07 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -10,7 +10,7 @@ SUBDIRECTORY_OK=Yes
>  OPTIONS_SPEC=
>  . git-sh-setup
>  . git-sh-i18n
> -set_reflog_action "pull $*"
> +set_reflog_action "pull${1+ $*}"
>  require_work_tree
>  cd_to_toplevel

Thanks, will queue.

I wonder if we have any test in the contents of the reflog messages,
though.
