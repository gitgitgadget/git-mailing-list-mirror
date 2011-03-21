From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion: Add git help completion for aliases
Date: Mon, 21 Mar 2011 14:48:10 -0700
Message-ID: <7vhbawno11.fsf@alter.siamese.dyndns.org>
References: <4D871972.7080008@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	lee.marlow@gmail.com, markus.heidelberg@web.de, szeder@ira.uka.de,
	spearce@spearce.org, bebarino@gmail.com, ted@tedpavlic.com,
	tlikonen@iki.fi, trast@student.ethz.ch
To: Jakob Pfender <jpfender@elegosoft.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 22:48:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1my1-0002U4-Q1
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 22:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754648Ab1CUVsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 17:48:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34354 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583Ab1CUVsl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 17:48:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7F60952E0;
	Mon, 21 Mar 2011 17:50:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TUmd5us+ezORmnyQief6QDdx8mY=; b=FT1W4h
	oleGwe2eEAuf4m+436Qy+wv7VA0bGhs9P5S7GMV0CxmR45xNgzV2lSM2FEoMKhHp
	0wnAntr3cTZkgQKdBPaCxi9bXCPrhKQPCie7mIxtvTlUgPVXLNlxcRTHjM+awX/H
	swOMXOrX5n/PBGhYBEdynYxsMM1o0qmywwDDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sHe/eZ9ZNNc2ZIGqER5uv99c53LDovAw
	Xn9B0/LPqIkfpBJdMtlf/8I51PFsmYM62YnBn/uY/MRUbnm4oCDSnY5+CbjmYLm7
	SZDu3tWt57HUqlH5sxDeP8XBExYYI0T28+1TJDpjoqYgWcoDyJgg2bEf3LXq4xtM
	k7B/8XwHgSo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C62CA52DB;
	Mon, 21 Mar 2011 17:50:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D9A7352D6; Mon, 21 Mar 2011
 17:49:51 -0400 (EDT)
In-Reply-To: <4D871972.7080008@elegosoft.com> (Jakob Pfender's message of
 "Mon, 21 Mar 2011 10:25:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2EC35E7E-5405-11E0-8EAD-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169674>

Jakob Pfender <jpfender@elegosoft.com> writes:

> Enable bash completion for "git help <alias>", analogous to "git
> <alias>", which was already implemented.
>
> Signed-off-by: Jakob Pfender <jpfender@elegosoft.com>
> ---
>  contrib/completion/git-completion.bash |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash
> index 893b771..f9a74d3 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1506,7 +1506,7 @@ _git_help ()
>  		;;
>  	esac
>  	__git_compute_all_commands
> -	__gitcomp "$__git_all_commands
> +	__gitcomp "$__git_all_commands $(__git_aliases)
>  		attributes cli core-tutorial cvs-migration
>  		diffcore gitk glossary hooks ignore modules
>  		repository-layout tutorial tutorial-2

This patch may not be _wrong_ per-se, but it it useful in practice?

I dunno.

Don't people usually use aliases so that they do not have to type long
command names that would need completion?
