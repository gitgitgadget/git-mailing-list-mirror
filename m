From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: speeding up git-svn when directories are copied?
Date: Tue, 24 Apr 2007 12:01:00 +0200
Message-ID: <20070424100100.GA23811@diana.vm.bytemark.co.uk>
References: <20070423141601.GA5797@diana.vm.bytemark.co.uk> <20070424015405.GA7232@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Apr 24 12:01:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgHps-0006ta-GI
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 12:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbXDXKBV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Apr 2007 06:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbXDXKBV
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 06:01:21 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1470 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932344AbXDXKBU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 06:01:20 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HgHpU-0006bI-00; Tue, 24 Apr 2007 11:01:00 +0100
Content-Disposition: inline
In-Reply-To: <20070424015405.GA7232@untitled>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45437>

On 2007-04-23 18:54:05 -0700, Eric Wong wrote:

> Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > When importing a whole repository, git-svn currently takes a _lot_
> > of time. Almost all of it seems to be spent getting the full text
> > of each and every file when a tag or new branch is created.
>
> Try SVN 1.4.3 with my patch[1] to get do_switch() working. trunk
> should work without the patch.
>
> [1] - http://svn.haxx.se/dev/archive-2007-01/0936.shtml
>
> do_switch() is broken otherwise, and do_update() is extremely
> inefficient.

Thanks for the help. I applied your patch to a clean 1.4.3 tree, and
built subversion itself plus the perl bindings. But git-svn is still
slow, and the testcase you gave in that thread still fails.

(I'm pretty sure that I'm actually using the bindings I've built; I
install them to a nonstandard location, so if I don't set PERL5LIB
they aren't found at all, and perl complains. When I do set it to my
patched bindings, perl accepts it but your testcase fails.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
