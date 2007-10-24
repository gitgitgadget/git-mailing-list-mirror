From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-{diff,ls}-files from a subdirectory fails ...
Date: Wed, 24 Oct 2007 11:06:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710241104560.25221@racer.site>
References: <20071024012038.GA31326@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 12:07:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikd93-0004sT-Eq
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 12:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882AbXJXKHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 06:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbXJXKHN
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 06:07:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:46078 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751583AbXJXKHM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 06:07:12 -0400
Received: (qmail invoked by alias); 24 Oct 2007 10:07:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 24 Oct 2007 12:07:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+syXAkBVSsIcIP+T0m4t5NiXJI2xA1CFxqpIkLjd
	QRt07Ggmwf4RUN
X-X-Sender: gene099@racer.site
In-Reply-To: <20071024012038.GA31326@diana.vm.bytemark.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62203>

Hi,

On Wed, 24 Oct 2007, Karl Hasselstr?m wrote:

> ... when GIT_DIR is specified.
> 
> I have a repository at ~/stgit-lib. With cwd at the top of the tree,
> things work as expected when I set all those fancy envoronment
> variables:
> 
>   kha@yoghurt:~/stgit-lib> git-diff-files --name-only
>   stgit/utillib.py
> 
>   kha@yoghurt:~/stgit-lib> GIT_DIR=/home/kha/stgit-lib/.git GIT_INDEX_FILE=/home/kha/stgit-lib/.git/index GIT_WORK_TREE=/home/kha/stgit-lib git-diff-files --name-only
>   stgit/utillib.py
> 
> However, it doen't seem to work from a subdirectory:
> 
>   kha@yoghurt:~/stgit-lib/stgit> git-diff-files --name-only
>   stgit/utillib.py
> 
>   kha@yoghurt:~/stgit-lib/stgit> GIT_DIR=/home/kha/stgit-lib/.git GIT_INDEX_FILE=/home/kha/stgit-lib/.git/index GIT_WORK_TREE=/home/kha/stgit-lib git-diff-files --name-only | wc
>       170     170    3560

>From looking at it (very) briefly, it seems that you encountered the same 
bug that was fixed in

dd5c8af176bb935a0b01a7dc2d5e022565c3aac3(Fix setup_git_directory_gently() 
with relative GIT_DIR & GIT_WORK_TREE).

IOW if you run git version v1.5.3.4-14-gdd5c8af or newer, you should not 
experience this.

Hth,
Dscho
