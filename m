From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: warn_unused_result problem, and a solution
Date: Wed, 25 Mar 2009 17:34:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903251731000.26370@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 17:37:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmW6o-000601-My
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 17:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbZCYQfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 12:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752861AbZCYQfG
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 12:35:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:42351 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752167AbZCYQfE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 12:35:04 -0400
Received: (qmail invoked by alias); 25 Mar 2009 16:35:01 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp036) with SMTP; 25 Mar 2009 17:35:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19r4uV4WPprcscqoLop7FWwTiT9+4by/WVtD9cWRc
	wl/8KLmi/m+LFZ
X-X-Sender: schindel@intel-tinevez-2-302
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114622>

Hi,

when I updated one of my Ubuntu machine's packages, it automatically 
updated libc6 to a newer version.

I was in for a surprise: the output is littered with spurious warnings 
about lack of handling of return values to all kinds of functions.

It took me a while to figure out what had happened, and it took me even 
longer to find this:

	https://bugs.launchpad.net/ubuntu/+source/glibc/+bug/305176

Apparently, the good Ubuntu people think it is fine that people who 
compile stuff themselves are drowned in warnings.

To make a long story less long: I have this in my config.mak for now:

	CFLAGS += -U_FORTIFY_SOURCE

Hopefully, this helps others, too.

Ciao,
Dscho
