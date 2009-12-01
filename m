From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-pull.sh: Fix call to git-merge for new command
 format
Date: Tue, 01 Dec 2009 15:54:46 -0800
Message-ID: <7vmy22qmgp.fsf@alter.siamese.dyndns.org>
References: <1259707451-20661-1-git-send-email-vonbrand@inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Wed Dec 02 00:55:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFcYf-0005Lj-5R
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 00:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782AbZLAXyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 18:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754747AbZLAXyt
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 18:54:49 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61470 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754717AbZLAXys (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 18:54:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 03C2F1391;
	Tue,  1 Dec 2009 18:54:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3NxVY6HE3e34xBVjy7fsDwe8esw=; b=LhEE5w
	4MHOT+r0mI7ZF54GZHRILA9XkUnHhzyfT61fku8BMxK0JIuM7Dn5l1C9AP837KOQ
	02ziSXlkxXhdJcoEIsTwGVvZoQZpJLuniW6XI53UyOXWzeaB0EQHMW1i8FA5CSpP
	z/X9waqAfPCEsQcBYWhgqLVzwCpK4LhhcKn3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PkvnYVb1sNqaKU8b3smZQhbJNI++9OrA
	nwrZ9zbx8+nd3sdaG+8ab7QlOUpYXmSnfNTM+EdGQsCqNOzrUK1wOh7JFePvWlqS
	q6v81J1AkLWNuHjBg8CU7hq3fo985/3yBUFY5yZc58/zs1m+OJYaUvnoyfnUqOQr
	Op2eDzsGOSE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CC5D31390;
	Tue,  1 Dec 2009 18:54:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17DE01388; Tue,  1 Dec
 2009 18:54:47 -0500 (EST)
In-Reply-To: <1259707451-20661-1-git-send-email-vonbrand@inf.utfsm.cl> (Horst
 H. von Brand's message of "Tue\,  1 Dec 2009 19\:44\:11 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E9FF62B6-DED4-11DE-850E-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134269>

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:

> Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
> ---
>  git-pull.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-pull.sh b/git-pull.sh
> index bfeb4a0..a875809 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -218,5 +218,5 @@ merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
>  test true = "$rebase" &&
>  	exec git-rebase $diffstat $strategy_args --onto $merge_head \
>  	${oldremoteref:-$merge_head}
> -exec git-merge $diffstat $no_commit $squash $no_ff $ff_only $log_arg $strategy_args \
> -	"$merge_name" HEAD $merge_head $verbosity
> +exec git-merge  $verbosity -m $diffstat $no_commit $squash $no_ff $ff_only $log_arg $strategy_args \
> +	"$merge_name" $merge_head
> -- 
> 1.6.6.rc0.114.gc8648

Heh, embarrasing.

But I think you wanted to have -m immediately before "$merge_name", no?
