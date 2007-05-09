From: Panagiotis Issaris <takis.issaris@uhasselt.be>
Subject: GIT on Windows
Date: Wed, 9 May 2007 12:29:07 +0000 (UTC)
Message-ID: <loom.20070509T142518-558@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 14:29:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HllIT-0007zl-QB
	for gcvg-git@gmane.org; Wed, 09 May 2007 14:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756314AbXEIM32 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 08:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756147AbXEIM32
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 08:29:28 -0400
Received: from main.gmane.org ([80.91.229.2]:46358 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753152AbXEIM31 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 08:29:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HllIF-0005xr-Fm
	for git@vger.kernel.org; Wed, 09 May 2007 14:29:19 +0200
Received: from edm-005.edm.uhasselt.be ([193.190.10.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 May 2007 14:29:19 +0200
Received: from takis.issaris by edm-005.edm.uhasselt.be with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 May 2007 14:29:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.190.10.5 (Mozilla/5.0 (Windows; U; Windows NT 5.1; nl; rv:1.8.1.3) Gecko/20070309 Firefox/2.0.0.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46702>

Hi,

As someone in the FFmpeg project asked about GIT's availability on other
operating systems, and it was mentioned that Mercurial worked fine
on Windows, I wanted to have a look whether it was already possible to run GIT
on Windows.

I first had a go at getting it working on MSys/MinGW, but as no binaries
appeared to be available and compilation wasn't trivial, I figured I'd
take the easier path using CygWin. When looking for packages to resolve the GIT
build dependencies, I noticed that a GIT package was
already available from within the CygWin installer! :-)

I tried some basic stuff, creating a repository, adding files, committing,
diffing and found out all this worked fine. I noticed that gitk also works fine.

Then I wanted to try the same on some real repository (meaning with more then
the 10 commits my testrepository contained).

I tried cloning a repository of my own but this resulted in a crash:

git clone http://lumumba.uhasselt.be/takis/git/ffmpeg-pi.git/
...
walk 5c90e2f63a0d46c6f2ab6c30bdfe1e0212ca46ff
walk 77a6e87c60a59b9aea1d2441b7092a55a66f5f6e
walk bb588b310f6d4313b7e979a7291dda5ed7150f24
walk 43ede2c8f98a8d089be1d94a03ad25a442aaf70a
walk 7c8107ced46b499daaac7b31e9316b3ce02d5b97
walk 645d04783e96d519b04aa079152330ca583c06e1
walk 2a4b277efcaa4ccb2ce0c4e2db1359d4d9de50b3
walk a364a4c1b3dfcaa65b39a09162f71dbdedcdaa9d
walk a4ba211235ab711a6d626c6b1c58762067d24308
walk 6ba58730a9d61bcac2a1585d646670a50a75acb0
walk a805a8dc64b86bb1235b1a0016647f604f145441
walk b12275479b67093f8b399e6e1461c14b55889b3f
walk 8400d62a2dc5242baf76a47ffb2705a0809dbeaa
walk 64f8fbdfe9a4810987bf22ce1255cfdb9772e07a
walk 9ac44cb9aa52e0b2befa5e54c78ea36ff85bfa71
walk 41f92f338d79cd404e430832a6cbba601b00ad08
      8 [main] git-http-fetch 3436 _cygtls::handle_exceptions: Error while dumpi
ng state (probably corrupted stack)
/usr/bin/git-clone: line 33:  3436 Segmentation fault      (core dumped) git-htt
p-fetch $v -a -w "$tname" "$sha1" "$1"
rm: cannot remove directory `/cygdrive/c/Documents and Settings/pissaris/src/ffm
peg-pi/.git/clone-tmp': Directory not empty


The resulting directory contains only the following:

pissaris@pissaris ~/src/ffmpeg-pi$ ls .git/ -la
total 0
drwxr-xr-x+ 3 pissaris mkgroup-l-d 0 May  9 14:02 .
drwxr-xr-x+ 3 pissaris mkgroup-l-d 0 May  9 14:02 ..
drwxr-xr-x+ 2 pissaris mkgroup-l-d 0 May  9 14:02 clone-tmp

pissaris@pissaris ~/src/ffmpeg-pi


pissaris@pissaris ~/src/ffmpeg-pi
$ git --version
git version 1.5.1.3

I'll see if 1.5.1.4 solves this crash, and will most likely have a go at getting
the MinGW version compiled too.


Any clues on the reason for this crash? Is anyone already using GIT on Windows
on real repositories?



With friendly regards,
Takis
