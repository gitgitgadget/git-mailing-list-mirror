From: David Kastrup <dak@gnu.org>
Subject: Re: "git clone" executed as root on solaris 10 shreds UFS (it is possible to create hardlinks for directories as root under solaris)
Date: Mon, 16 Jul 2007 14:58:27 +0200
Message-ID: <86myxw8pzg.fsf@lola.quinscape.zz>
References: <20070716100803.GA24036@cip.informatik.uni-erlangen.de> <20070716104342.GB24036@cip.informatik.uni-erlangen.de> <86644kaaf1.fsf@lola.quinscape.zz> <20070716123913.GJ24036@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 14:59:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAQAV-0007eO-T3
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 14:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757260AbXGPM6r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 08:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757032AbXGPM6r
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 08:58:47 -0400
Received: from main.gmane.org ([80.91.229.2]:48038 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757321AbXGPM6q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 08:58:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IAQ9u-000757-14
	for git@vger.kernel.org; Mon, 16 Jul 2007 14:58:38 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 14:58:38 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 14:58:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:3IasJHX38wWtNIfjE9hELHH5LM0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52671>

Thomas Glanzmann <thomas@glanzmann.de> writes:

> Hello David,
> as I mentioned and showed in my original e-mail:
>
>         git checkout /path/to/repo
>
> triggers the problem also. So no, "cp -a" has nothing todo with it
> because root is able to read _all_ files no matter who the files are
> owned by and what the permissions of these files are[1]. This happens on
> a _local_ fileystem. And what worries me is that git does something that
> breaks the _hard link counter_ of a directory.

Hm?  The hard link counter is "broken" by creating or not creating
subdirectories, since their ".." is a hard link.

-- 
David Kastrup
