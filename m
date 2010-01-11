From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] filter-branch: Fix to allow replacing submodules
 with another content
Date: Mon, 11 Jan 2010 19:02:06 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001111901380.4985@pacific.mpi-cbg.de>
References: <1263227634-11259-1-git-send-email-sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Michal Sojka <sojkam1@fel.cvut.cz>
X-From: git-owner@vger.kernel.org Mon Jan 11 18:59:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUOXb-0000L5-5S
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 18:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072Ab0AKR6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 12:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753271Ab0AKR6z
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 12:58:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:39418 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753072Ab0AKR6y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 12:58:54 -0500
Received: (qmail invoked by alias); 11 Jan 2010 17:56:38 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 11 Jan 2010 18:56:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX194Es9Mrap4Oq3ZtgL/L3UGjsTIeRlLJOWl745T0l
	8N59VKysvx1gzW
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1263227634-11259-1-git-send-email-sojkam1@fel.cvut.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136647>

Hi,

On Mon, 11 Jan 2010, Michal Sojka wrote:

> When git filter-branch is used to replace a submodule with another
> content, it always fails on the first commit. Consider a repository with
> directory submodule containing a submodule. If I want to remove the
> submodule and replace it with a file, the following command fails.
> 
> git filter-branch --tree-filter 'rm -rf submodule &&
> 				 git rm -q submodule &&
> 				 mkdir submodule &&
> 				 touch submodule/file'
> 
> The error message is:
> error: submodule: is a directory - add files inside instead
> 
> The reason is that git diff-index, which generates a part of the list of
> files to update-index, emits also the removed submodule even if it was
> replaced by a real directory.
> 
> Adding --ignored-submodules solves the problem for me and
> tests in t7003-filter-branch.sh passes correctly.

Have you tested replacing one revision of a submodule with another?

Ciao,
Dscho
