From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] Add platform-independent .git "symlink"
Date: Sun, 17 Feb 2008 22:25:27 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802172224550.30505@racer.site>
References: <1203286456-26033-1-git-send-email-hjemli@gmail.com> <1203286456-26033-2-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 23:26:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQrxb-0006wj-Sw
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 23:26:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbYBQWZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 17:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753891AbYBQWZi
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 17:25:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:57896 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752818AbYBQWZh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 17:25:37 -0500
Received: (qmail invoked by alias); 17 Feb 2008 22:25:35 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp003) with SMTP; 17 Feb 2008 23:25:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1909zQRCnN0kzJLPp8B31IseLJhMyCun895rMmIv3
	acoZ5zqi786fog
X-X-Sender: gene099@racer.site
In-Reply-To: <1203286456-26033-2-git-send-email-hjemli@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74198>

Hi,

On Sun, 17 Feb 2008, Lars Hjemli wrote:

> @@ -302,6 +305,12 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  	 */
>  	offset = len = strlen(cwd);
>  	for (;;) {
> +		gitfile_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
> +		if (gitfile_dir && is_git_directory(gitfile_dir)) {
> +			if (set_git_dir(gitfile_dir))
> +				return NULL;

Should this not complain loudly?  Really loudly, as in die()?

Ciao,
Dscho
