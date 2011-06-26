From: Christof =?ISO-8859-1?Q?Kr=FCger?= <git@christof-krueger.de>
Subject: Re: Deleted file is back - how to investigate?
Date: Sun, 26 Jun 2011 16:10:23 +0200
Message-ID: <1309097423.11860.76.camel@oxylap>
References: <20110626103218.GQ30255@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: vmiklos@frugalware.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 26 16:10:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qaq32-0002Of-3J
	for gcvg-git-2@lo.gmane.org; Sun, 26 Jun 2011 16:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927Ab1FZOKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 10:10:41 -0400
Received: from vserver.localhost.li ([85.214.46.152]:39856 "EHLO
	mail.localhost.li" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922Ab1FZOKi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2011 10:10:38 -0400
Received: from p5794cbe3.dip.t-dialin.net ([87.148.203.227]:35775 helo=[192.168.0.126])
	by mail.localhost.li with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <git@christof-krueger.de>)
	id 1Qaq2j-0005JE-JJ; Sun, 26 Jun 2011 16:10:33 +0200
X-Mailer: Evolution 2.30.3 
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176324>

Hi,

In this particular case, it seems that the offending commit is indeed a
merge commit (a5f45ee4). But it rather looks like user error and not a
git bug to me.  When I checkout its first parent (a5e830ee) and merge
its second parent (93b01c6c) myself, I get some conflicts, but the
ogle-gui file stays deleted.

As to how to detect what pulled the file back in:
I added --graph to your command line which implies parent rewriting.
This includes merges and should give you some information about the
"topology" of the history graph, leaving out irrelevant commits
in-between.  I wouldn't call myself a history simplification exptert, so
there might still be cases where this does not help, but in this case it
indeed shows the offending merge commit.

Regards,
  Chris
