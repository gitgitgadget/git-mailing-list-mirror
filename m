From: jidanni@jidanni.org
Subject: git-clone --how-much-disk-space-will-this-cost-me? [--depth n]
Date: Tue, 16 Dec 2008 07:53:42 +0800
Message-ID: <878wqhxaex.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 16 00:55:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCNHE-0006jC-SD
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 00:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbYLOXxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 18:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbYLOXxq
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 18:53:46 -0500
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:44808 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753282AbYLOXxp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Dec 2008 18:53:45 -0500
Received: from jidanni2.jidanni.org (122-127-35-251.dynamic.hinet.net [122.127.35.251])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id BBDBE119E1C
	for <git@vger.kernel.org>; Mon, 15 Dec 2008 15:53:44 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103218>

The git-clone manpage should mention how to determine how much disk
space will be used.

You see we beginners (who haven't learned git yet, so no patches
forthcoming, thank you) are often told "Just do git-clone
git://git.example.org/bla/ to get started!". Being smart, we read up on
--depth 1 to limit potential disk occupation, but we still have no
idea of how much disk space we will need. We cant just use HEAD(1)
because this is not HTTP.

Therefore the git-clone man page, one of the main entry points for the
beginner, should say how to determine how much disk space we will need
for git-clone or git-clone --depth 1 etc.

And don't tell us to just figure it out from the progress messages
after the download begins, and hit ^C if we don't like it.

Let's take a look at those messages while were at it,
$ git-clone --depth 1 git://git.sv.gnu.org/coreutils/
Initialized empty Git repository in /usr/local/src/jidanni/coreutils/.git/
remote: Counting objects: 26240, done.
remote: Compressing objects: 100% (14001/14001), done.
remote: Total 26240 (delta 21577), reused 15354 (delta 12095)
Receiving objects: 100% (26240/26240), 15.76 MiB | 26 KiB/s, done.
Resolving deltas: 100% (21577/21577), done.
$ du -sh
27M  .
Nope, nowhere does it directly say "You Holmes, are in for 27
Megabytes (on your piddly modem)". There obviously is math involved to
figure it out... math!

Also add examples of how one first probes a remote tree one has been
told about, determines what parts of it he might want, and then
finally git-clones just those parts.

Also document what --depth 0 or even -1 will do.
