From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/7 v2] git_extract_argv0_path(): Move check for valid argv0 from caller to callee
Date: Sun, 18 Jan 2009 20:16:54 +0100
Message-ID: <200901182016.56395.j6t@kdbg.org>
References: <1232280015-8144-1-git-send-email-prohaska@zib.de> <1232280015-8144-3-git-send-email-prohaska@zib.de> <1232280015-8144-4-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 20:18:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOdAB-0002ul-B9
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 20:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076AbZARTRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 14:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752666AbZARTRE
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 14:17:04 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:25618 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752700AbZARTRD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 14:17:03 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 351032C4004;
	Sun, 18 Jan 2009 20:16:57 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 5985457DB4;
	Sun, 18 Jan 2009 20:16:57 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <1232280015-8144-4-git-send-email-prohaska@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106261>

On Sonntag, 18. Januar 2009, Steffen Prohaska wrote:
> This simplifies the calling code.

But it could really be squashed into the previous patch, after fixing...

> @@ -23,6 +23,9 @@ const char *system_path(const char *path)
>
>  const char *git_extract_argv0_path(const char *argv0)
>  {
> +	if (!argv0 || !*argv0)
> +		return 0;
> +
>  	const char *slash = argv0 + strlen(argv0);

... this declaration after statement.

-- Hannes
