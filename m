From: Christoph Haas <haas@debian.org>
Subject: Strange merge failure (would be overwritten by merge / cannot merge)
Date: Fri, 04 Sep 2009 22:28:36 +0200
Organization: Debian - the universal operating system
Message-ID: <4AA17874.7090905@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 04 22:36:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjfVr-0008MI-HZ
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 22:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933971AbZIDUfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 16:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933957AbZIDUfv
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 16:35:51 -0400
Received: from torf.workaround.org ([212.12.58.129]:57371 "EHLO
	torf.workaround.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933854AbZIDUfu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 16:35:50 -0400
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Sep 2009 16:35:50 EDT
Received: from aldi.workaround.org (aldi.workaround.org [212.12.58.130])
	by torf.workaround.org (Postfix) with ESMTPS id A07871015BC2
	for <git@vger.kernel.org>; Fri,  4 Sep 2009 22:28:37 +0200 (CEST)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
X-Enigmail-Version: 0.95.0
X-Virus-Scanned: ClamAV 0.94.2/9773/Thu Sep  3 09:38:27 2009 on torf.workaround.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127768>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dear list,

I'm struggling with a pretty simple Git repository where I maintain one
of my Debian packages. It has two branches:

 - upstream (contains the unaltered original software unpacked from
   a .tar.gz)
 - master (derived from upstream plus Debian specific changes)

Now I imported a new upstream version into the upstream branch. And then
tried to merge the 'upstream' branch into the 'master' branch to work on
it. And suddenly I get this error:

   error: Entry 'cream-abbr-eng.vim' would be overwritten by merge.
   Cannot merge.

So it looks like the 'cream-abbr-eng.vim' file has been altered. And it
contains some non-ASCII characters (it's a VIM script file) so perhaps
automatic merging fails. But can't I just tell Git to screw my file in
the 'master' branch and just overwrite my file? No merge strategy helped
me accomplish that.

To reproduce my problem:

  $> git clone git://git.workaround.org/cream
  $> cd cream
  $> git merge origin/upstream
  error: Entry 'cream-abbr-eng.vim' would be overwritten by merge.
  Cannot merge.
  fatal: merging of trees 70008c82f82a7985531aa2d039c03fdf944ea267 and
  78d3a35e300434d6369424dd873bb587beacfaa4 failed

Help welcome. I'm no Git guru and totally at a loss here. As a last
resort I would start from scratch losing all of my Git history.

Kindly
 Christoph

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkqheHQACgkQCV53xXnMZYZSaQCdF4JovwKUx1FIOq82+joGUIlq
a7UAoIoC2mm2L6Pv7MvZGzOIRNgktb2B
=pklM
-----END PGP SIGNATURE-----
