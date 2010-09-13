From: Yann Dirson <dirson@bertin.fr>
Subject: git-subtree:  bug, and ideas for doc improvements
Date: Mon, 13 Sep 2010 13:57:05 +0200
Organization: Bertin Technologies
Message-ID: <20100913135705.36f8217b@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 14:12:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ov7tM-0003YL-Hm
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 14:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965Ab0IMMME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 08:12:04 -0400
Received: from blois.bertin.fr ([195.68.26.9]:39953 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755089Ab0IMMMD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 08:12:03 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Sep 2010 08:12:03 EDT
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 0185354358
	for <git@vger.kernel.org>; Mon, 13 Sep 2010 14:04:34 +0200 (CEST)
Received: from YPORT1 (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id D3B5B5434D
	for <git@vger.kernel.org>; Mon, 13 Sep 2010 14:04:33 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0L8O003K8PJLD150@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Mon, 13 Sep 2010 14:04:33 +0200 (CEST)
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8200-6.0.0.1038-17634.007
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156085>

Hi Avery,

Here are a couple of remarks from trying to work out how to convert
an imported-with-local-changes kernel to git-subtree.

* When reading the doc, it looks like my use case would require --onto,
  but although it is documented *when* to we are expected to use that
  flag, it is not explained *what* it does (which tends to make be both
  curious and nervous about it ;)

* In addition, describing "what git subtree is expecting" without
  --onto would probably be useful

* If I first run "split" without --onto, then "reset --hard HEAD^" and
  rerun the same split with an additional --onto, then:
  - although a new set of split commits is created, the new branch
    ref is set to the old one
  - the split then aborts saying that the new branch ref is not an
    ancestor
 => this does not happen if I remove the old branch ref first, so it
 does not look tied to the subtree-cache, only to the reachability of
 the old split branch ?  FWIW, old branch (without --onto) is named
 "linux-2.6" and new one (with --onto) is "linux-2.6b".

* If I run "split --onto=XXX" where XXX is as specified in the manpage
  "the first revision of the subproject's history that was imported
  into your project", then the split history looks exactly the same,
  appart from:
  - without --onto, the root of the split branch has no parent
  - with --onto, the split branch is forked off the specified commit,
    which is itself not split.  The "--onto" name makes that result
    understandable, but shouldn't the doc tell to use "the last commit
    before the subproject's history was imported into your project"
    instead ?

Best regards,
-- 
Yann Dirson - Bertin Technologies
