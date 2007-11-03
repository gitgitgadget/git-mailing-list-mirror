From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add missing inside_work_tree setting in setup_git_directory_gently
Date: Sat, 3 Nov 2007 11:38:51 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711031138150.4362@racer.site>
References: <20071103100323.GA25305@laptop>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-2078109368-1194089931=:4362"
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 12:39:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoHM3-0006Av-3e
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 12:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbXKCLjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 07:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752691AbXKCLjk
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 07:39:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:51759 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752538AbXKCLjj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 07:39:39 -0400
Received: (qmail invoked by alias); 03 Nov 2007 11:39:37 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp056) with SMTP; 03 Nov 2007 12:39:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/6oMwh7HT68GbkR7oOmZLqxDZ/AREoAq8TI/POSo
	s5qplaNYdOtvPX
X-X-Sender: gene099@racer.site
In-Reply-To: <20071103100323.GA25305@laptop>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63238>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-2078109368-1194089931=:4362
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 3 Nov 2007, Nguyễn Thái Ngọc Duy wrote:

> Without this, work_tree handling code in setup_git_directory
> will be activated. If you stay in root work tree (no prefix),
> it does not harm. It does if you work from a subdirectory though.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Turns out my patch on NEED_WORK_TREE is fixing a wrong place.
> 
>  setup.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/setup.c b/setup.c
> index 145eca5..6f8f769 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -240,6 +240,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  			if (chdir(work_tree_env) < 0)
>  				die ("Could not chdir to %s", work_tree_env);
>  			strcat(buffer, "/");
> +			inside_work_tree = 1;

I really have to wonder why this is needed, as it should be deduced 
(correctly!) when you ask is_inside_work_tree().

Ciao,
Dscho
--8323584-2078109368-1194089931=:4362--
