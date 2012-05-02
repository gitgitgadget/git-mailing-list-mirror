From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] stash: make "saved" message translatable
Date: Wed, 02 May 2012 09:42:06 -0700
Message-ID: <7vpqamilgh.fsf@alter.siamese.dyndns.org>
References: <cover.1335966202.git.trast@student.ethz.ch>
 <abd19c2c02ba6d1e8eac8a1f3df055e9ad8ea969.1335966202.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Thielow <ralf.thielow@googlemail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed May 02 18:42:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPcd4-0004TD-6h
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 18:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753617Ab2EBQmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 12:42:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50149 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752885Ab2EBQmI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 12:42:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23F506815;
	Wed,  2 May 2012 12:42:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2TklHpM6BiA+vZgCpQBsDDPOvvc=; b=HJFrJ/
	xURMfVPCNNHCT9dO7Tsy0T6+CQcCdP0zzKKpeGqFYiglhcVXV7fDTWA6WDzzbOiG
	f5bIYsctd5c9GWENahl3ptKyrS3QLYvI0GdrOk22nxUurJoIfzTj+vywAJ3GB7PQ
	Zs0aZ3voVzxL2wf3DgLxw5go2P0RhVfmpQf6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oQJ1pma66034J4GaSp8yTXEqG2bnDRx4
	N7n5srjS7l5JlY6rlTTk4lZWHmNbNYt1BwoJwyR2zfRvs19zCGun8sBE78dhXFNH
	1zgRdHAhq77yM7/baKYwOB0dJKl45XEsC+dOiDjNEAWBH8v5IpkzYvKYMcxBfXEL
	+THqLh4jZZA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A3C36814;
	Wed,  2 May 2012 12:42:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A26646812; Wed,  2 May 2012
 12:42:07 -0400 (EDT)
In-Reply-To: <abd19c2c02ba6d1e8eac8a1f3df055e9ad8ea969.1335966202.git.trast@student.ethz.ch> (Thomas Rast's message of "Wed, 2 May 2012 15:49:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C186FA8E-9475-11E1-8AFD-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196840>

Thomas Rast <trast@student.ethz.ch> writes:

> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  git-stash.sh |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index 4e2c7f8..e614eb7 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -233,7 +233,7 @@ save_stash () {
>  
>  	git update-ref -m "$stash_msg" $ref_stash $w_commit ||
>  		die "$(gettext "Cannot save the current status")"
> -	say Saved working directory and index state "$stash_msg"
> +	say "$(eval_gettext "Saved working directory and index state \"\$stash_msg\"")"

Do you need backslashes before double quotes here?
