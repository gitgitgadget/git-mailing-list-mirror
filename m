From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [usability bug] git branch -a does not disambiguate remote and
 local branches
Date: Mon, 15 Dec 2008 20:09:16 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812152005490.30769@pacific.mpi-cbg.de>
References: <85647ef50812151015t4d5bc2b8p4ea53a0e4ad25e64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 20:02:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCIhc-0007cl-AC
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 20:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303AbYLOTAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 14:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755566AbYLOTAm
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 14:00:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:49178 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751587AbYLOTAl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 14:00:41 -0500
Received: (qmail invoked by alias); 15 Dec 2008 19:00:36 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp061) with SMTP; 15 Dec 2008 20:00:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19XcFtaQ5BXCAUFPXyJnuOZWzBoH8hSelHGHz+qtF
	6tD7Knl3+er+PT
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <85647ef50812151015t4d5bc2b8p4ea53a0e4ad25e64@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103196>

Hi,

On Mon, 15 Dec 2008, Constantine Plotnikov wrote:

> Let's consider the following scenario:
> 
> mkdir bare.git
> mkdir local
> cd bare.git
> git --bare init
> cd ../local
> git init
> echo test > test.txt
> git add test.txt
> git commit -m test
> git remote add origin `pwd`/../bare.git
> git push --all
> git checkout -b origin/master master
> echo updated > test.txt
> git add test.txt
> git commit -m updated
> 
> Note that that in this scenario, the user has created local branch in
> the folder with the same name as a remote branch. While the supposed
> user here is apparently shooting itself in the foot, the scenario is
> still supported by git, and might happen as a result of more logical
> git operations (like git fetch).

It is only half-supported, and Git will complain, saying that there are 
ambiguous branches.

IMHO it is better to be nice to the many users who do not try to shoot 
themselves in the foot, by showing them the nice short names that will 
work.

The others are warned when they use the ambiguous short names anyway.

Ciao,
Dscho
