From: John Williams <john.williams@petalogix.com>
Subject: Wierd git over http behaviour
Date: Fri, 20 Feb 2009 16:13:20 +1000
Message-ID: <1d3f23370902192213g560020b3h7a2459c1439e5e5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 07:14:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaOew-0005r2-1M
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 07:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444AbZBTGNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 01:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752406AbZBTGNV
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 01:13:21 -0500
Received: from wf-out-1314.google.com ([209.85.200.174]:35293 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbZBTGNV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 01:13:21 -0500
Received: by wf-out-1314.google.com with SMTP id 28so974015wfa.4
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 22:13:20 -0800 (PST)
Received: by 10.143.12.11 with SMTP id p11mr239252wfi.19.1235110400591; Thu, 
	19 Feb 2009 22:13:20 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110802>

Hi,

We have a git tree that accesses fine via the git protocol, however I have
also opened up http support for it as some of our users are behind
git-unfriendly corporate firewalls.

I know http transport is not encouraged, but not much I can do about that.

Strange thing is, when doing an http fetch of said tree, it gets no updates
to the tree later than about Jan 13 this year, even though the tree itself
has many, many commits since then (its origin is Linus's tree and we pull
regularly).  Heads created later than that date are also not visible (doing
git branch -a) in the clone pulled over http.  Clones made using git: are
fine.

Anything I can look for in the .git repo on the server, permissions or
similar that might be relevant?  It's almost like there's a single commit in
there that somehow is making the http fetch puke.  If you browse the http
tree with a web browser, it's all there as expected.

For reference here are the URLs:

git://developer.petalogix.cmo/linux-2.6-microblaze

http://developer.petalogix.com/git2/linux-2.6-microblaze

Initially the http reference was a symlink on the server to the actual git
tree, but I also tried just rsync'ing it across to /var/www/html/git2 to
make sure it wasn't the symlink breaking things - no change.

Am I misunderstanding something or is this just flakey behaviour of the http
protocol support?

Thanks,

John
