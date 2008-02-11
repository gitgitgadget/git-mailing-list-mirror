From: Paul Gardiner <osronline@glidos.net>
Subject: Best way to specify all local branches and all remote branches.
Date: Mon, 11 Feb 2008 18:51:13 +0000
Message-ID: <47B09921.2070109@glidos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 19:52:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOdlA-0004vi-RA
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 19:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760066AbYBKSvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 13:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757088AbYBKSvV
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 13:51:21 -0500
Received: from mk-outboundfilter-1.mail.uk.tiscali.com ([212.74.114.37]:29863
	"EHLO mk-outboundfilter-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759960AbYBKSvU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2008 13:51:20 -0500
X-Trace: 38667639/mk-outboundfilter-1.mail.uk.tiscali.com/PIPEX/$MX-ACCEPTED/pipex-infrastructure/62.241.163.6
X-SBRS: None
X-RemoteIP: 62.241.163.6
X-IP-MAIL-FROM: osronline@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAHsnsEc+8aMG/2dsb2JhbACpYg
X-IP-Direction: IN
Received: from astro.systems.pipex.net ([62.241.163.6])
  by smtp.pipex.tiscali.co.uk with ESMTP; 11 Feb 2008 18:51:17 +0000
Received: from [10.0.0.24] (81-86-57-226.dsl.pipex.com [81.86.57.226])
	by astro.systems.pipex.net (Postfix) with ESMTP id B30E9E000085
	for <git@vger.kernel.org>; Mon, 11 Feb 2008 18:51:13 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73563>

New to git, and often finding it hard to specify the correct
refs for a command. Here's an example where I was converting
all the files in all the commits from unix line endings to
DOS line endings. You can see I've ended up using cd and ls.
I'm sure there must be a better way.

$ cd /home/public/tmp/git/
$ yes |rm -r vdos32
$ git clone /export/git/vdos32.git vdos32
$ cd vdos32/
$ for f in `(cd /export/git/vdos32.git/refs/heads; ls)|sed -e
    '/master/d' -e '/origin/d'`; do git fetch origin $f:$f; done
$ git-filter-branch --tag-name-filter cat --tree-filter 'find . -type f
    ! -name \*.gif ! -name \*.ico|xargs unix2dos -q' `(cd
    .git/refs/heads;ls)`



With git-filter-branch, I'm surprised I can't use --all.
The docs suggest that A --not B is permitted. I've
also seen refs/heads/* used in the docs but never
managed to get it to work. Most greatful for any
advice.

P.
