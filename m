From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t3412: clean up GIT_EDITOR usage
Date: Sun, 1 Feb 2009 23:24:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902012322490.3586@pacific.mpi-cbg.de>
References: <200901302343.39921.trast@student.ethz.ch> <1233355621-4783-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Feb 01 23:25:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTkkb-0003Vc-Ox
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 23:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbZBAWXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 17:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbZBAWXr
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 17:23:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:38226 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752480AbZBAWXq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 17:23:46 -0500
Received: (qmail invoked by alias); 01 Feb 2009 22:23:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 01 Feb 2009 23:23:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX185PF5cj7E5OJUNS06QOIJvDMqf+3MjHXIr3Frx6B
	CJOc9aGbkks4Z8
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1233355621-4783-1-git-send-email-trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108013>

Hi,

On Fri, 30 Jan 2009, Thomas Rast wrote:

> a6c7a27 (rebase -i: correctly remember --root flag across --continue,
> 2009-01-26) introduced a more portable GIT_EDITOR usage, but left the
> old tests unchanged.
> 
> Since we never use the editor (all tests run the rebase script as
> proposed by rebase -i), just disable it outright, which simplifies the
> tests.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  t/t3412-rebase-root.sh |   38 +++++++++++++-------------------------
>  1 files changed, 13 insertions(+), 25 deletions(-)
> 
> diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
> index 9fc528f..8a9154a 100755
> --- a/t/t3412-rebase-root.sh
> +++ b/t/t3412-rebase-root.sh
> @@ -6,6 +6,10 @@ Tests if git rebase --root --onto <newparent> can rebase the root commit.
>  '
>  . ./test-lib.sh
>  
> +# we always run the interactive rebases unchanged, so just disable the editor
> +GIT_EDITOR=:
> +export GIT_EDITOR
> +

According to my analysis, this is unneeded.  Just leave GIT_EDITOR alone 
in the whole test.

Ciao,
Dscho
