From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation: config: add "browser.<tool>.path".
Date: Sun, 27 Jan 2008 23:36:08 -0800
Message-ID: <7v1w82wgev.fsf@gitster.siamese.dyndns.org>
References: <20080128080223.de8a67d2.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jan 28 08:37:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJOYD-0004Og-7k
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 08:37:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbYA1HgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 02:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbYA1HgW
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 02:36:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51614 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbYA1HgV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 02:36:21 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E5006378;
	Mon, 28 Jan 2008 02:36:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id ACC976377;
	Mon, 28 Jan 2008 02:36:16 -0500 (EST)
In-Reply-To: <20080128080223.de8a67d2.chriscool@tuxfamily.org> (Christian
	Couder's message of "Mon, 28 Jan 2008 08:02:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71857>

Christian Couder <chriscool@tuxfamily.org> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/config.txt |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 877eda9..c2fedd1 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -367,6 +367,10 @@ branch.<name>.rebase::
>  	it unless you understand the implications (see linkgit:git-rebase[1]
>  	for details).
>  
> +browser.<tool>.path::
> +	Override the path for the given tool that may be used to
> +	browse help. See linkgit:git-help[1].
> +

Thanks.

I wonder if we want to stress the fact that this is about
rendering HTML version of the manual.  IOW, the <tool>.path
is about the path the chosen HTML renderer program is at, and
not consulted at all unless "git help -w help" is run.

Also, do we want to list the repertoire of <tool>?  Unlike
<name> in "remote.<name>.url" and "branch.<name>.remote", this
is not something the end user can arbitrarily name.

Incidentally, I notice that git-help manual page does not list
what browsers are supported (except that it hints that firefox
is usable by having an example "browser.firefox.path"), even
though it tells how the browser is picked via "*.browser".
