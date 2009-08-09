From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Hash algorithm choice
Date: Sun, 09 Aug 2009 20:44:53 +0200
Message-ID: <vpq1vnkddy2.fsf@bauges.imag.fr>
References: <f448a46a0908090907v68542e4dw1f1c4f610cb46ca2@mail.gmail.com>
	<f448a46a0908090917s102b4c83pbad6f298a8e127cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jerome Baum <jerome@jeromebaum.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 20:48:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaDRx-0000gn-FW
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 20:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbZHISsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 14:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbZHISsn
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 14:48:43 -0400
Received: from imag.imag.fr ([129.88.30.1]:61567 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464AbZHISsn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 14:48:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n79Iiruw014722
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 9 Aug 2009 20:44:54 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MaDO1-0000zT-Sh; Sun, 09 Aug 2009 20:44:53 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MaDO1-0003AV-RP; Sun, 09 Aug 2009 20:44:53 +0200
In-Reply-To: <f448a46a0908090917s102b4c83pbad6f298a8e127cc@mail.gmail.com> (Jerome Baum's message of "Sun\, 9 Aug 2009 18\:17\:01 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 09 Aug 2009 20:44:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125365>

Jerome Baum <jerome@jeromebaum.com> writes:

> How difficult would it be to allow users to choose a hash function
> during git-init which is then globally used in the repo?

There's at least one really difficult thing: how do you merge two
projects using two different hash functions? The Git repository, for
example, has several (I don't remember how many) root repository, and
was originally made of several projects (git, gitk, git gui, ...). If
these projects had started using different hash functions, then,
either:

* Git would have needed to learn how to merge, and record the merge
  history, of projects using different hash functions.

* One of the projects would have been forced to be converted to
  another hash function, which means changing all its identifiers (so,
  for example, finding a message on gmane telling that commit 1ab23cde
  fixes your problem wouldn't help much anymore ...).

-- 
Matthieu
