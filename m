From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 01/18] rebase -i: Make the condition for an "if" more
 transparent
Date: Tue, 26 Jan 2010 14:11:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001261410340.4641@intel-tinevez-2-302>
References: <cover.1263447037.git.mhagger@alum.mit.edu> <aa37ee8a68d460df172b23b4999fbe4ce7d77c1e.1263447037.git.mhagger@alum.mit.edu> <alpine.DEB.1.00.1001251927460.8733@intel-tinevez-2-302> <4B5EE257.8060204@alum.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 26 14:11:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZlCL-0007eo-G6
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 14:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147Ab0AZNLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 08:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106Ab0AZNLI
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 08:11:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:57317 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752366Ab0AZNLH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 08:11:07 -0500
Received: (qmail invoked by alias); 26 Jan 2010 13:11:04 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp070) with SMTP; 26 Jan 2010 14:11:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18tP+1B5+gt2/16QLlHCGhymyc5rwx3ayxowV6Oy5
	XJUsxAM8a3S3bU
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4B5EE257.8060204@alum.mit.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58999999999999997
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138037>

Hi,

On Tue, 26 Jan 2010, Michael Haggerty wrote:

> Johannes Schindelin wrote:
> > On Thu, 14 Jan 2010, Michael Haggerty wrote:
> > 
> >> @@ -166,7 +166,8 @@ pick_one () {
> >>  	parent_sha1=$(git rev-parse --verify $sha1^) ||
> >>  		die "Could not get the parent of $sha1"
> >>  	current_sha1=$(git rev-parse --verify HEAD)
> >> -	if test "$no_ff$current_sha1" = "$parent_sha1"; then
> >> +	if test -z "$no_ff" -a "$current_sha1" = "$parent_sha1"
> > 
> > Rather use &&, right?
> 
> Yes, that mistake was caused by my own ignorance about the portability
> issues.  This problem was already discussed [1] and the change has been
> integrated into master.

Thanks for the clarification, and sorry for not reviewing your series 
before Junio applied it.

Ciao,
Dscho
