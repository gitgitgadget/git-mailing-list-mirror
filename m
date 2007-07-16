From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: "git clone" executed as root on solaris 10 shreds UFS (it is
	possible to create hardlinks for directories as root under solaris)
Date: Mon, 16 Jul 2007 14:39:13 +0200
Message-ID: <20070716123913.GJ24036@cip.informatik.uni-erlangen.de>
References: <20070716100803.GA24036@cip.informatik.uni-erlangen.de> <20070716104342.GB24036@cip.informatik.uni-erlangen.de> <86644kaaf1.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 14:39:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAPrC-0001UX-UR
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 14:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756371AbXGPMjP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 08:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755995AbXGPMjP
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 08:39:15 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:55574 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755295AbXGPMjO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 08:39:14 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id AF6AE3F426; Mon, 16 Jul 2007 14:39:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <86644kaaf1.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52668>

Hello David,
as I mentioned and showed in my original e-mail:

        git checkout /path/to/repo

triggers the problem also. So no, "cp -a" has nothing todo with it
because root is able to read _all_ files no matter who the files are
owned by and what the permissions of these files are[1]. This happens on
a _local_ fileystem. And what worries me is that git does something that
breaks the _hard link counter_ of a directory.

        Thomas

[1] Notes
        Of course that doesn't apply to all filesystems. For example AFS
        and NFS. But as I said before it happens on a _UFS_ filesystem.
