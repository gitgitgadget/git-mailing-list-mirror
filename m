From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: Fix file name pattern in .gitattributes.
Date: Tue, 24 Feb 2009 00:44:15 -0800
Message-ID: <7vskm4jkbk.fsf@gitster.siamese.dyndns.org>
References: <1235462493-8761-1-git-send-email-j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 09:46:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbsvJ-0006Xg-AR
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 09:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbZBXIoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 03:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752338AbZBXIoZ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 03:44:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35172 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbZBXIoY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 03:44:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 705512BD18;
	Tue, 24 Feb 2009 03:44:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1F1E42BD17; Tue,
 24 Feb 2009 03:44:16 -0500 (EST)
In-Reply-To: <1235462493-8761-1-git-send-email-j6t@kdbg.org> (Johannes Sixt's
 message of "Tue, 24 Feb 2009 09:01:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 554C718E-024F-11DE-9119-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111238>

Johannes Sixt <j6t@kdbg.org> writes:

> The pattern for the *.po files was anchored at the repository's root, but
> this would match the files only in the git-gui repository itself, but
> not in the version that is subtree-merged into git.git.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  .gitattributes |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/.gitattributes b/.gitattributes
> index f96112d..c69f4a0 100644
> --- a/.gitattributes
> +++ b/.gitattributes
> @@ -1,3 +1,3 @@
>  *           encoding=US-ASCII
>  git-gui.sh  encoding=UTF-8
> -/po/*.po    encoding=UTF-8
> +po/*.po     encoding=UTF-8

Hmm, really?

    $ pwd
    /pub/git/git.git
    $ git check-attr encoding git-gui/po/xx.po
    git-gui/xx/ja.po: encoding: UTF-8
    $ git check-attr encoding git-gui/funk/po/xx.po
    git-gui/funk/po/xx.po: encoding: US-ASCII
