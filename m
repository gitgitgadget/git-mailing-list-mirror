From: Ralph Seichter <git-ml@seichter.de>
Subject: How to limit bandwidth used by git over SSH ?
Date: Sun, 17 Jul 2011 12:22:47 +0200
Message-ID: <4E22B7F7.4020701@seichter.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 17 12:32:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiOe3-0006h1-9M
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 12:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755725Ab1GQKbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 06:31:41 -0400
Received: from seth.horus-it.com ([178.63.73.87]:48698 "EHLO seth.horus-it.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276Ab1GQKbk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 06:31:40 -0400
X-Greylist: delayed 526 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jul 2011 06:31:40 EDT
Received: from localhost (localhost [127.0.0.1])
	by seth.horus-it.com (Postfix) with ESMTP id 593E9334035
	for <git@vger.kernel.org>; Sun, 17 Jul 2011 12:22:52 +0200 (CEST)
Authentication-Results: seth.horus-it.com (amavisd-new);
	dkim=pass (1024-bit key) reason="pass (just generated, assumed good)"
	header.d=seichter.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=seichter.de; h=
	content-transfer-encoding:content-type:content-type:subject
	:subject:mime-version:user-agent:from:from:date:date:message-id;
	 s=jul2011; t=1310898169; x=1313490170; bh=g00ZJigwYcVHJnfS7+P9t
	z3CrAlVrOQY/qzuCcvwjWg=; b=D1H/nMipwG7NLJkK0FL+ltBIiX4bTpoOJ/6Vp
	blYnxD/JN4X+ZSpbLBACqarpRg/sN+dy/3zzngtYippQUphSo0zULltEBftwlx9A
	eP7V3/57ndU1F2BAthPLm1exjjzSKEZcjpcVQJb6QLzSxmERDkkmxK3BQ1jebk5X
	LnRzNo=
X-Virus-Scanned: at seth.horus-it.com
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:5.0) Gecko/20110624 Thunderbird/5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177293>

Hello list,

I'm not really sure if this is a git or SSH issue, but I haven't figured
out a solution yet. To transfer my data between two machines, I use

  git-push ssh://machineB.tld/foo/proj.git master

from machineA. Unfortunately, the machines are connected by a very low-
bandwidth connection, which is completely choked by git-push. From what
I've read so far, I guess this is the result of SSH setting TOS to
"minimize delay", which prevents almost all other traffic during the
push operation. Not good.

I haven't yet found a way of telling git (or SSH) to use no more than a
given maximum bandwidth, like I could do with "scp -l {limit}". Did I
miss something in the documentation?

Your help is appreciated.

-Ralph
