From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Newbie experience with push over ssh
Date: Wed, 14 Feb 2007 15:07:06 +0100
Message-ID: <vpq64a4bzp1.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 15:07:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHKnE-0001K1-3Z
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 15:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbXBNOHY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 09:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbXBNOHY
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 09:07:24 -0500
Received: from imag.imag.fr ([129.88.30.1]:37881 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371AbXBNOHX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 09:07:23 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l1EE76j6026736
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 14 Feb 2007 15:07:07 +0100 (CET)
Received: from olympe.imag.fr ([129.88.43.60])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HHKmo-00051C-BR
	for git@vger.kernel.org; Wed, 14 Feb 2007 15:07:06 +0100
Received: from moy by olympe.imag.fr with local (Exim 4.50)
	id 1HHKmo-0000Zc-8w
	for git@vger.kernel.org; Wed, 14 Feb 2007 15:07:06 +0100
Mail-Followup-To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 14 Feb 2007 15:07:07 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39644>

Hi,

I'm playing a bit with git (still ~ total beginner).

I could create a local repository, commit in it, but then, I tried to
push it to a remote machine, on which git is installed.

I would have expected "push" to do this, but:

$ git push ssh://machine.fr/tmp/foo 
fatal: '/tmp/foo': unable to chdir or not a git archive
fatal: The remote end hung up unexpectedly

Then, I tried "clone":

$ git clone . ssh://machine.fr/tmp/foo
Initialized empty Git repository in /tmp/foo/ssh:/machine.fr/tmp/foo/.git/
remote: Generating pack...
remote: Done counting 3 objects.
remote: Deltifying 3 objects.
 100% (3/3) done/3) done
remote: Total 3 (delta 0), reused 0 (delta 0)
Indexing 3 objects.
 100% (3/3) done

Gosh, "push" seems to know what a URL is, but not "clone", which
considers the _file_ ssh:/machine.fr/tmp/foo ...

Then only, I understood that I would have to log onto the remote
machine, and mkdir + git init manually. At least, this should be
mentionned in the git-push man page, but indeed, is there any reason
why git-push could not just create the remote repository? And any
reason why clone doesn't deal with URLs?

Thanks,

-- 
Matthieu
