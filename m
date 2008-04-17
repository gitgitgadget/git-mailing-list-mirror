From: Remi Vanicat <vanicat@debian.org>
Subject: [BUGS] test failure in t4014-format-patch.sh with master
Date: Thu, 17 Apr 2008 11:30:25 +0200
Message-ID: <87od88eslq.dlv@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 14:34:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmTID-0002dp-Df
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 14:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756705AbYDQMb5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2008 08:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756552AbYDQMb5
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 08:31:57 -0400
Received: from neuf-infra-smtp-out-sp604006av.neufgp.fr ([84.96.92.121]:37290
	"EHLO neuf-infra-smtp-out-sp604006av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756499AbYDQMb4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 08:31:56 -0400
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Apr 2008 08:31:56 EDT
Received: from neuf-infra-smtp-out-sp604012av.neufgp.fr ([10.110.56.125])
	by neuf-infra-smtp-out-sp604006av.neufgp.fr with neuf telecom
	id EYAY1Z00b2i69Vm060NZ00; Thu, 17 Apr 2008 14:26:22 +0200
Received: from maison.homelinux.org ([84.101.56.102])
	by neuf-infra-smtp-out-sp604012av.neufgp.fr with neuf telecom
	id EcSE1Z0062CKh6U0C00000; Thu, 17 Apr 2008 14:26:21 +0200
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <vanicat.remi@neuf.fr>)
	id 1JmQRl-0006yt-HK; Thu, 17 Apr 2008 11:30:29 +0200
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: vanicat.remi@neuf.fr
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on maison.homelinux.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NO_RELAYS
	autolearn=ham version=3.2.4
X-SA-Exim-Version: 4.2.1 (built Tue, 21 Aug 2007 23:39:36 +0000)
X-SA-Exim-Scanned: Yes (on maison.homelinux.org)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79790>

Hello,

While trying to wrote a test for git, I discover that there is a test
failure in master on my computer:

$ ./t4014-format-patch.sh
[....]
* FAIL 8: replay did not screw up the log message

 git cat-file commit rebuild-1 | grep "^Side .* with .* backslash-n"


It seem that now, somewhere a \n has been interpreted as a newline.

Bisecting point the problem to the 2e6e3e82 commit "git-am: cope
better with an empty Subject: line"


--=20
R=C3=A9mi Vanicat
