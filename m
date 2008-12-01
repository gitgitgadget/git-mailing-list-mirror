From: neale@lanl.gov (Neale T. Pickett)
Subject: Re: git configure script
Date: 01 Dec 2008 12:12:10 -0700
Message-ID: <njxk5aj3e2d.fsf@cfl-sunray1.lanl.gov>
References: <njx4p1ub7zz.fsf@cfl-sunray1.lanl.gov>
	<vpq7i6q8azp.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Dec 01 20:15:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7EEq-0006Xv-T2
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 20:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbYLATN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 14:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbYLATN2
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 14:13:28 -0500
Received: from proofpoint3.lanl.gov ([204.121.3.28]:43717 "EHLO
	proofpoint3.lanl.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbYLATN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 14:13:26 -0500
Received: from mailrelay2.lanl.gov (mailrelay2.lanl.gov [128.165.4.103])
	by proofpoint3.lanl.gov (8.13.8/8.13.8) with ESMTP id mB1JCG4N001346;
	Mon, 1 Dec 2008 12:12:16 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailrelay2.lanl.gov (Postfix) with ESMTP id 01F2815D910A;
	Mon,  1 Dec 2008 12:12:16 -0700 (MST)
X-NIE-2-Virus-Scanner: amavisd-new at mailrelay2.lanl.gov
Received: from ccn-mail.lanl.gov (ccn-mail.lanl.gov [128.165.4.105])
	by mailrelay2.lanl.gov (Postfix) with ESMTP id E281B15D9160;
	Mon,  1 Dec 2008 12:12:15 -0700 (MST)
Received: from cfl-sunray1.lanl.gov (cfl-sunray1.lanl.gov [128.165.5.23])
	by ccn-mail.lanl.gov (Postfix) with ESMTP id 47D611D0006;
	Mon,  1 Dec 2008 12:12:10 -0700 (MST)
In-Reply-To: <vpq7i6q8azp.fsf@bauges.imag.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
X-NIE-2-MailScanner-Information: Please see http://network.lanl.gov/email/virus-scan.php
X-NIE-2-MailScanner: Found to be clean
X-NIE-2-MailScanner-From: neale@lanl.gov
X-Spam-Status: No
X-Proofpoint-Virus-Version: vendor=fsecure engine=4.65.7400:2.4.4,1.2.40,4.0.164 definitions=2008-12-01_03:2008-11-24,2008-12-01,2008-12-01 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102078>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> It does, since it includes config.mak.autogen which overrides prefix
> defined in Makefile.
>
> I'm 99% sure you did something wrong. You should investigate by
> looking into config.mak.autogen after running configure.

This gave me the tip I needed.  I was doing this in my Makefile:

    make -C git-1.6.0.4 install

Instead of this:

    cd git-1.6.0.4 && make install

Since the include was prefixed with "-", I didn't get any warnings or
errors about not being able to find config.mak.autogen, and it fell back
to the default.

I'm not sure using the -C option to make is "something wrong", but then
again I am apparently the first person to run into this problem, so it's
probably not a big deal.

Thanks for your help :)

Neale
