From: Marat Radchenko <marat@slonopotamus.org>
Subject: What's the difference between =?utf-8?b?YGdpdA==?= show branch:file =?utf-8?b?fA==?= diff -u - =?utf-8?b?ZmlsZWA=?= vs =?utf-8?b?YGdpdA==?= diff branch =?utf-8?b?ZmlsZWA/?=
Date: Tue, 23 Aug 2011 07:25:17 +0000 (UTC)
Message-ID: <loom.20110823T091132-107@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 09:25:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvlMi-0000cf-1H
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 09:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624Ab1HWHZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 03:25:36 -0400
Received: from lo.gmane.org ([80.91.229.12]:48266 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254Ab1HWHZf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 03:25:35 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QvlMb-0000b0-52
	for git@vger.kernel.org; Tue, 23 Aug 2011 09:25:33 +0200
Received: from 195.218.191.171 ([195.218.191.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Aug 2011 09:25:33 +0200
Received: from marat by 195.218.191.171 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Aug 2011 09:25:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 195.218.191.171 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.112 Safari/534.30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179926>

$ time git show branch:file | diff -u - file > /dev/null 

real    0m0.003s
user    0m0.000s
sys     0m0.000s

$ time git diff branch -- file > /dev/null 

real    0m31.442s
user    0m31.040s
sys     0m0.380s

What does git diff do so it takes that much time? And is there any flag to git 
diff so that it will work as fast as show + diff? I thought these two are 
equivalent but from run time it is obvious that they aren't.

gprof output: http://slonopotamus.org/git-diff/git-diff-branch.gprof.txt
