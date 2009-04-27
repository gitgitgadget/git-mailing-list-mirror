From: Ingo Molnar <mingo@elte.hu>
Subject: [spurious parallel build bug] make -j fails with: "mv: mv: cannot
	stat `perl.mak': No such file or directory"
Date: Mon, 27 Apr 2009 11:48:43 +0200
Message-ID: <20090427094843.GA5849@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 27 14:01:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyNSy-0007xf-Fk
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 11:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755009AbZD0Js5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 05:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754927AbZD0Js4
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 05:48:56 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:51833 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755097AbZD0Jsz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 05:48:55 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1LyNSB-0006nM-1C
	from <mingo@elte.hu>
	for <git@vger.kernel.org>; Mon, 27 Apr 2009 11:48:54 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id E56533E2138; Mon, 27 Apr 2009 11:48:40 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117665>


I got this when i built v1.6.3-rc3 for the first time:

$ make -j
[...]
    CC builtin-annotate.o
    CC builtin-apply.o
    CC builtin-archive.o
    CC builtin-bisect--helper.o
mv: mv: cannot stat `perl.mak': No such file or directory
mv: cannot stat `perl.mak': No such file or directory
    CC builtin-blame.o
mv: cannot stat `perl.mak': No such file or directory
mv: cannot stat `perl.mak': No such file or directory
cannot stat `perl.mak': No such file or directory

a plain 'make' worked.

Interestingly, a second attempt to reproduce it after a 'make clean' 
failed to trigger the bug. So it's either timing sensitive or 
there's some other weirdness that caused this.

	Ingo
