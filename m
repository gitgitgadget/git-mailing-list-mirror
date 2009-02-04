From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Recovering the index after a git crash?
Date: Wed, 04 Feb 2009 09:36:30 +0100
Message-ID: <vpqljsma99t.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 04 09:43:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUdLs-0001Py-Q3
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 09:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbZBDIl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 03:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbZBDIlz
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 03:41:55 -0500
Received: from imag.imag.fr ([129.88.30.1]:62778 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604AbZBDIly (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 03:41:54 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n148aU58029627
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 4 Feb 2009 09:36:30 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LUdFG-0004HT-7C; Wed, 04 Feb 2009 09:36:30 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LUdFG-0006iT-3z; Wed, 04 Feb 2009 09:36:30 +0100
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 04 Feb 2009 09:36:30 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108312>

Hi,

I'm debugging a git assertion failure, which leaves a .git/index.lock
in the way. After running the failed command, git refuses to do
anything in this directory, complaining with:

  fatal: unable to create '.git/index.lock': File exists

What I'm doing then is just "rm .git/index.lock". Is it safe to do it?
I guess I should just make sure there's no git process running, but is
there anything else to check?

I'll write a FAQ entry on the wiki with answers, and that would
probably be a good idea to give indication to the user directly in the
error message too, otherwise, the problem can be blocking for
beginners.

Thanks,

<my life>
I had to support students using SVN for a month in January, and even
when SVN says:

  svn: run 'svn cleanup' to remove locks (type 'svn help cleanup' for details)

it's still hard for many students to understand that they have to run
"svn cleanup" and prefer sending me a mail saying "it doesn't work
anymore" :-(.
</my life>

-- 
Matthieu
