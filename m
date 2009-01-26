From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Documentation: simplify refspec format description
Date: Sun, 25 Jan 2009 22:24:06 -0800
Message-ID: <7viqo2a8l5.fsf@gitster.siamese.dyndns.org>
References: <1232927133-30377-1-git-send-email-mail@cup.kalibalik.dk>
 <1232927133-30377-2-git-send-email-mail@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Mon Jan 26 07:25:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRKug-00010G-CI
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 07:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbZAZGYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 01:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbZAZGYN
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 01:24:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbZAZGYM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 01:24:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A9B7A1D4EE;
	Mon, 26 Jan 2009 01:24:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CAA4E1D4EC; Mon,
 26 Jan 2009 01:24:07 -0500 (EST)
In-Reply-To: <1232927133-30377-2-git-send-email-mail@cup.kalibalik.dk>
 (Anders Melchiorsen's message of "Mon, 26 Jan 2009 00:45:31 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F21D6A9E-EB71-11DD-865B-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107170>

Anders Melchiorsen <mail@cup.kalibalik.dk> writes:

> diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
> index ebdd948..820c140 100644
> --- a/Documentation/pull-fetch-param.txt
> +++ b/Documentation/pull-fetch-param.txt
> @@ -5,10 +5,10 @@
>  	of a remote (see the section <<REMOTES,REMOTES>> below).
>  
>  <refspec>::
> -	The canonical format of a <refspec> parameter is
> -	`+?<src>:<dst>`; that is, an optional plus `{plus}`, followed
> -	by the source ref, followed by a colon `:`, followed by
> -	the destination ref.
> +	The format of a <refspec> parameter is an optional plus
> +	`{plus}`, followed by the source ref <src>, followed
> +	by a colon `:`, followed by the destination ref <dst>.
> +	Find various forms of refspecs in examples section.
>  +
>  The remote ref that matches <src>
>  is fetched, and if <dst> is not empty string, the local

I think this is *much* nicer, but I do not think git-fetch.txt has
examples to fall back on.

The patch to git-push.txt would not have this issue; the exmaple is there
in the page itself.

But I think it might be even better to briefly describe what it means,
like this patch on top of yours does to git-push.txt.  The fetch/pull side
already has the corresponding description immediately after that, so I'd
suggest just removing the reference to non-existing examples section.

I found your 2/3 and 3/3 good improvements.

 Documentation/git-push.txt         |    3 ++-
 Documentation/pull-fetch-param.txt |    3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git i/Documentation/git-push.txt w/Documentation/git-push.txt
index 3fd4bbb..ea45935 100644
--- i/Documentation/git-push.txt
+++ w/Documentation/git-push.txt
@@ -36,7 +36,8 @@ OPTIONS
 	The format of a <refspec> parameter is an optional plus
 	`{plus}`, followed by the source ref <src>, followed
 	by a colon `:`, followed by the destination ref <dst>.
-	Find various forms of refspecs in examples section.
+	It is used to specify with what <src> object the <dst> ref
+	in the remote repository is to be updated.
 +
 The <src> side represents the source branch (or arbitrary
 "SHA1 expression", such as `master~4` (four parents before the
diff --git i/Documentation/pull-fetch-param.txt w/Documentation/pull-fetch-param.txt
index 820c140..f9811f2 100644
--- i/Documentation/pull-fetch-param.txt
+++ w/Documentation/pull-fetch-param.txt
@@ -8,12 +8,11 @@
 	The format of a <refspec> parameter is an optional plus
 	`{plus}`, followed by the source ref <src>, followed
 	by a colon `:`, followed by the destination ref <dst>.
-	Find various forms of refspecs in examples section.
 +
 The remote ref that matches <src>
 is fetched, and if <dst> is not empty string, the local
 ref that matches it is fast forwarded using <src>.
-Again, if the optional plus `+` is used, the local ref
+If the optional plus `+` is used, the local ref
 is updated even if it does not result in a fast forward
 update.
 +
