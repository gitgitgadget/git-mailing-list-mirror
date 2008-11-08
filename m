From: Junio C Hamano <gitster@pobox.com>
Subject: Re: absurdly slow git-diff
Date: Sat, 08 Nov 2008 13:02:52 -0800
Message-ID: <7vr65maq2r.fsf@gitster.siamese.dyndns.org>
References: <20081107200126.GA20284@toroid.org>
 <alpine.LFD.2.00.0811071335010.3468@nehalem.linux-foundation.org>
 <alpine.DEB.1.10.0811071503120.8736@alien.or.mcafeemobile.com>
 <alpine.DEB.1.10.0811071517280.8736@alien.or.mcafeemobile.com>
 <alpine.LFD.2.00.0811071540340.3468@nehalem.linux-foundation.org>
 <alpine.DEB.1.10.0811071547080.8736@alien.or.mcafeemobile.com>
 <alpine.LFD.2.00.0811071554590.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Davide Libenzi <davidel@xmailserver.org>,
	Abhijit Menon-Sen <ams@toroid.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Nov 08 22:04:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyuyu-0001BN-8X
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 22:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbYKHVDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 16:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbYKHVDQ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 16:03:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63454 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbYKHVDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 16:03:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 03883946D1;
	Sat,  8 Nov 2008 16:03:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 68AE0946C1; Sat, 
 8 Nov 2008 16:02:54 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0811071554590.3468@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Fri, 7 Nov 2008 15:57:23 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A85A9188-ADD8-11DD-9150-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100427>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Junio, the time difference is quite big for Abhijit's admittedly odd 
> test-case:
> ...
> with no difference in output.

In git.git history, "git-whatchanged -m -p -1" gives different output for
the following commits, with and without the patch:

        c0e9892637e8144f10f2c408e276a470520f3601
        d6b3e3a33f71910526ccf80af6c13a230363cd89
        cecb98a9c3ed9271b0974bb6d7edbcf16e8a68f3
        ce18135d862b5dbc731d203b27c279529e58b54b
        36b5b3c65948694d9a92de5a17f2b97c3cd84879
        767e130915015f897fb87b939843b4882212574b
        927a503cd07718ea0f700052043f383253904a56

I've sampled a few (but not all) of them and they are different only
because just how common lines are matched up, which is expected.
