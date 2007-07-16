From: David Kastrup <dak@gnu.org>
Subject: Re: "git clone" executed as root on solaris 10 shreds UFS (it is possible to create hardlinks for directories as root under solaris)
Date: Mon, 16 Jul 2007 12:48:21 +0200
Message-ID: <86ejj8aakq.fsf@lola.quinscape.zz>
References: <20070716100803.GA24036@cip.informatik.uni-erlangen.de> <20070716104342.GB24036@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 12:50:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAO9c-0002bw-9W
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 12:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757594AbXGPKuH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 06:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757491AbXGPKuG
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 06:50:06 -0400
Received: from main.gmane.org ([80.91.229.2]:46448 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756926AbXGPKuF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 06:50:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IAO9S-00012E-I9
	for git@vger.kernel.org; Mon, 16 Jul 2007 12:50:02 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 12:50:02 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 12:50:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:BBqkSXEg6ZR4kQpTgFbeL/KVgMg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52659>

Thomas Glanzmann <thomas@glanzmann.de> writes:

> Hello,
> I narrowed it down. It is in "git checkout" if I copy the ".git" dir via
> "cp -a" and type in "git checkout" it breaks. And it _only_ breaks for
> subdirectories:
>
>         (faui04a) [/var/tmp/shit] git checkout
>         D       profiles/icpc
>         D       profiles/sithglan
>         D       sources/boot.msg
>         D       sources/busybox-config
>         D       sources/config
>         D       sources/easix.logo.16
>         D       sources/easixdm
>         D       sources/f2
>         D       sources/home-faumachine.tar.gz
>         D       sources/home-icpc.tar.gz
>         D       sources/home-simigern.tar.gz
>         D       sources/home-sithglan.tar.gz
>         D       sources/home-sitowert.tar.gz
>         D       sources/linuxrc
>         D       sources/rc.local
>
> and I also see that _one_ file in each subdirectory is checked out but the
> others are not.

Ok, stupidly trying one of our most frequently encountered problems:

Does it help to say
export CDPATH=""
in your root shell?

-- 
David Kastrup
