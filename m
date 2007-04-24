From: Eric Wong <normalperson@yhbt.net>
Subject: Re: speeding up git-svn when directories are copied?
Date: Mon, 23 Apr 2007 18:54:05 -0700
Message-ID: <20070424015405.GA7232@untitled>
References: <20070423141601.GA5797@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 03:54:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgAEP-00071s-F1
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 03:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbXDXByK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 23 Apr 2007 21:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030694AbXDXByK
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 21:54:10 -0400
Received: from hand.yhbt.net ([66.150.188.102]:60035 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030419AbXDXByJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 21:54:09 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 1153D7DC0A0;
	Mon, 23 Apr 2007 18:54:07 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 23 Apr 2007 18:54:05 -0700
Content-Disposition: inline
In-Reply-To: <20070423141601.GA5797@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45402>

Karl Hasselstr=F6m <kha@treskal.com> wrote:
> When importing a whole repository, git-svn currently takes a _lot_ of
> time. Almost all of it seems to be spent getting the full text of eac=
h
> and every file when a tag or new branch is created.

Try SVN 1.4.3 with my patch[1] to get do_switch() working.
trunk should work without the patch.

[1] - http://svn.haxx.se/dev/archive-2007-01/0936.shtml

do_switch() is broken otherwise, and do_update() is extremely
inefficient.

--=20
Eric Wong
