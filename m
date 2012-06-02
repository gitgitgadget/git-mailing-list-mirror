From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix many comment typos
Date: Sat, 02 Jun 2012 16:01:33 -0700
Message-ID: <7vmx4lz5bm.fsf@alter.siamese.dyndns.org>
References: <8762baf8do.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sun Jun 03 01:01:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaxKG-00028T-J2
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 01:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702Ab2FBXBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jun 2012 19:01:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51352 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756051Ab2FBXBf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 19:01:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 855B78EBF;
	Sat,  2 Jun 2012 19:01:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VlHDkm/MNAJwVWdGwBw9fvtIuxY=; b=NTEQbw
	fClf59adbe5BH88kQL4R2onirq+C7tVDay61VUxRncE+x4LpTithVNv/xVXpPD4q
	Tkk3Nir/FkRydOIuk0HZG50248Tn9zBeJ1WIS7EnxKh5jNzfvOAyOCkVM+6XXKkB
	oRoICCt8vOOAdpXGZi3tKRdfJsNzoILRDN6fQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c41k6ModXLaEGPJOrCYPIl1psiTE4nml
	pDg+j+yhTnXNG6i2okms6izOTpjpKH2kNdij+NLcGEw+YiwRiM3g5DQyso8ZypcD
	hQy8b0aAmrURtljJgVb+GK49y115ahN/dqfySUz62veHiqlHOA59fliQtTE7Kvcs
	Jk5ScDMpaYc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B7CC8EBE;
	Sat,  2 Jun 2012 19:01:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0860C8EBD; Sat,  2 Jun 2012
 19:01:34 -0400 (EDT)
In-Reply-To: <8762baf8do.fsf@rho.meyering.net> (Jim Meyering's message of
 "Sat, 02 Jun 2012 10:03:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E6BE22F6-AD06-11E1-B87A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199063>

Jim Meyering <jim@meyering.net> writes:

> Use http://github.com/lyda/misspell-check to identify many typos.
> Culprits identified and fixed automatically using these commands,
> converting diagnostics to single-quote-safe sed -i commands:
>
> git ls-files|misspellings -f -|perl -nl \
>   -e '/^(.*?)\[(\d+)\]: (\w+) -> "(.*?)"$/ or next;' \
>   -e '($file,$n,$l,$r)=($1,$2,$3,$4); $q="'\''"; $r=~s/$q/$q\\$q$q/g;'\
>   -e 'print "sed -i $q${n}s!$l!$r!$q $file"' \
>  | grep -vE '\.po$|pt_BR' > k
>
> Filter out s/seeked/sought/ false positives (they relate to cg-seek):
>   grep -vE 'seeked' k > j && mv j k

??
> diff --git a/Documentation/RelNotes/1.5.4.4.txt b/Documentation/RelNotes/1.5.4.4.txt
> index 323c1a8..83453db 100644
> --- a/Documentation/RelNotes/1.5.4.4.txt
> +++ b/Documentation/RelNotes/1.5.4.4.txt
> @@ -21,7 +21,7 @@ Fixes since v1.5.4.3
>
>   * "git send-email" in 1.5.4.3 issued a bogus empty In-Reply-To: header.
>
> - * "git bisect" showed mysterious "won't bisect on seeked tree" error message.
> + * "git bisect" showed mysterious "won't bisect on sought tree" error message.

??
