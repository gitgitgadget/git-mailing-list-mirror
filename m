From: David Brown <git@davidb.org>
Subject: Re: hosting git on a nfs
Date: Wed, 12 Nov 2008 09:36:52 -0800
Message-ID: <20081112173651.GA9127@linode.davidb.org>
References: <200811121029.34841.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org, dabe@ymc.ch
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Wed Nov 12 18:38:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0JfO-00010O-VI
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 18:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbYKLRgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 12:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752013AbYKLRgy
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 12:36:54 -0500
Received: from linode.davidb.org ([72.14.176.16]:56331 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541AbYKLRgy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 12:36:54 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1L0Je8-0002R1-A6; Wed, 12 Nov 2008 09:36:52 -0800
Content-Disposition: inline
In-Reply-To: <200811121029.34841.thomas@koch.ro>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100779>

On Wed, Nov 12, 2008 at 10:29:34AM +0100, Thomas Koch wrote:

>finally I managed to convince a critical mass of developers (our chief
>dev :-) in our company so that we are starting to migrate to GIT.
>
>The final question is, whether GIT will life peacefully on our cluster
>fileservers. The GIT repository dir (/var/cache/git) should be mounted
>via NFS via PAN on top of DRBD (so I was told).
>
>Are there any known problems with this setup? We're asking, because
>there are problems with SVN on such a setup[1].

We had occasionally run into locking problems with 1.5.4.x with
renames between different directories.  This should be fixed in
1.6.0.3, but we have since migrated to a server model so I don't have
any way of testing this.

None of these problems ever caused repository corruption, only errors
during fetch/clone that were resolved by repeating the operation.

Using ssh: or git: does seem to be a bit faster than NFS.  The
configuration we did find completely unworkable was using git with the
work tree on NFS.

David
