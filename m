From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] - git-read-tree segfaults
Date: Tue, 10 Mar 2009 21:21:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903102120290.14295@intel-tinevez-2-302>
References: <35476bd20903101234q71bc520fh18828d7170a4a2f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jiri Olsa <olsajiri@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 21:36:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh8ge-0002rr-Nq
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 21:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755119AbZCJUe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 16:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755020AbZCJUe4
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 16:34:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:48178 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752999AbZCJUe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 16:34:56 -0400
Received: (qmail invoked by alias); 10 Mar 2009 20:21:30 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 10 Mar 2009 21:21:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+MBIFSsZWMhGQ9knYI+NguDBmhuWQCyZJ+OtDqlw
	nc0CKWRl5rfaYy
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <35476bd20903101234q71bc520fh18828d7170a4a2f5@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112847>

Hi,

On Tue, 10 Mar 2009, Jiri Olsa wrote:

> mb=$($GIT merge-base HEAD yyy)
> $GIT read-tree $mb HEAD yyy

While I agree that it is a bad thing for Git to segfault, I think this 
here is a pilot error.  You try to read 3 trees at the same time, but not 
perform a merge.  IMHO you want to add -m at least.

Ciao,
Dscho
