From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] update 'git apply' bash-completion according to its
 man  page
Date: Sat, 08 Aug 2009 12:50:11 -0700
Message-ID: <7vab2adr0s.fsf@alter.siamese.dyndns.org>
References: <9f50533b0908080157r6e58a6a4rf42ff684d095c002@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Emmanuel Trillaud <etrillaud@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 21:50:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZrw5-0000Vp-Ii
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 21:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136AbZHHTua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 15:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753114AbZHHTu3
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 15:50:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbZHHTu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 15:50:29 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8B7E822E91;
	Sat,  8 Aug 2009 15:50:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1338022E8F; Sat,  8 Aug 2009
 15:50:22 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BA4CA702-8454-11DE-8EF0-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125302>

Emmanuel Trillaud <etrillaud@gmail.com> writes:

> ---
>  contrib/completion/git-completion.bash |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash
> index 8ba1249..c08422c 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -694,9 +694,15 @@ _git_apply ()
>  	--*)
>  		__gitcomp "
>  			--stat --numstat --summary --check --index
> -			--cached --index-info --reverse --reject --unidiff-zero
> -			--apply --no-add --exclude=
> +			--cached
> +			--build-fake-ancestor=
> +			--index-info --reverse --reject --unidiff-zero
> +			--apply --no-add
> +			--exclude=
> +			--include=
>  			--whitespace= --inaccurate-eof --verbose
> +			--recount
> +			--directory=

I'd rather suggest dropping --no-add that is script-only and not useful in
interactive use.  I also won't add --build-fake-ancestor for the same
reason.
