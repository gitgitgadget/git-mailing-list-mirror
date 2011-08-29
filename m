From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: What's the difference between =?utf-8?b?YGdpdA==?= show branch:file =?utf-8?b?fA==?= diff -u - =?utf-8?b?ZmlsZWA=?= vs =?utf-8?b?YGdpdA==?= diff branch =?utf-8?b?ZmlsZWA/?=
Date: Mon, 29 Aug 2011 14:48:05 +0000 (UTC)
Message-ID: <loom.20110829T155805-331@post.gmane.org>
References: <loom.20110823T091132-107@post.gmane.org> <CACsJy8DMqjMfb5wVMnsrZhP8yv2rF1wyQ6LM6b-PVcYY1SXkcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 16:48:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy38V-0006Ln-1a
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 16:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604Ab1H2OsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 10:48:22 -0400
Received: from lo.gmane.org ([80.91.229.12]:36472 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878Ab1H2OsU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 10:48:20 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Qy38L-0006IY-9o
	for git@vger.kernel.org; Mon, 29 Aug 2011 16:48:19 +0200
Received: from 195.218.191.171 ([195.218.191.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Aug 2011 16:48:17 +0200
Received: from marat by 195.218.191.171 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Aug 2011 16:48:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 195.218.191.171 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.112 Safari/534.30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180311>

Nguyen Thai Ngoc Duy <pclouds <at> gmail.com> writes:
>  - is "file" above at top repo, or is it actually very/deep/path/to/a/file?
3 levels deep. Most parent dir (one after repo root) contains 20k files.

>  - how many entries in the tree that contain "file"?
Sorry, didn't understand this.

>  - how is "git ls-files | wc -l"?
$ time git ls-files | wc -l
603137

real    0m0.417s
user    0m0.440s
sys     0m0.060s

>  - how about "time git diff branch another-branch -- file >/dev/null"?
> That'd remove unpack-trees code.
Pretty fast:
$ time git diff branch:file other_branch:file > /dev/null

real    0m0.278s
user    0m0.210s
sys     0m0.060s

One more test:
git diff HEAD branch -- file > /dev/null 

real    0m0.276s
user    0m0.240s
sys     0m0.030s

So the only troubled variant is `git diff branch -- file`.
