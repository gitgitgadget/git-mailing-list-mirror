From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-help: add -w|--web option to display html man page in a browser.
Date: Thu, 06 Dec 2007 09:05:33 -0800
Message-ID: <7vve7bda8y.fsf@gitster.siamese.dyndns.org>
References: <20071202060755.4d6d5ec8.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Wong <normalperson@yhbt.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Dec 06 18:06:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0KAq-00008N-Iy
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 18:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753793AbXLFRFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 12:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbXLFRFu
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 12:05:50 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:49953 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793AbXLFRFt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 12:05:49 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id AB70A2FC;
	Thu,  6 Dec 2007 12:06:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id DE1A59D87B;
	Thu,  6 Dec 2007 12:06:01 -0500 (EST)
In-Reply-To: <20071202060755.4d6d5ec8.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sun, 2 Dec 2007 06:07:55 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67304>

Christian Couder <chriscool@tuxfamily.org> writes:

> diff --git a/help.c b/help.c
> index 0f1cb71..ecc8c66 100644
> --- a/help.c
> +++ b/help.c
> @@ -297,7 +303,14 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>  	const char *help_cmd = argc > 1 ? argv[1] : NULL;
>  	check_help_cmd(help_cmd);
>  
> -	if (!strcmp(help_cmd, "--info") || !strcmp(help_cmd, "-i")) {
> +	if (!strcmp(help_cmd, "--web") || !strcmp(help_cmd, "-w")) {
> +		help_cmd = argc > 2 ? argv[2] : NULL;
> +		check_help_cmd(help_cmd);
> +
> +		show_html_page(help_cmd);
> +	}
> +
> +	else if (!strcmp(help_cmd, "--info") || !strcmp(help_cmd, "-i")) {
>  		help_cmd = argc > 2 ? argv[2] : NULL;
>  		check_help_cmd(help_cmd);

Isn't this "check-help-cmd" duplication ugly, by the way?
