From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Spurious warning when moving a file in presence of submodules
Date: Fri, 11 Oct 2013 16:29:10 +0200
Message-ID: <vpq38o7nao9.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 11 16:29:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUdiY-0004bh-PT
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 16:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757385Ab3JKO3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 10:29:23 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36863 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754708Ab3JKO3W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 10:29:22 -0400
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r9BETCfD022159
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Oct 2013 16:29:12 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id r9BETA3P028627
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 11 Oct 2013 16:29:14 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 11 Oct 2013 16:29:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r9BETCfD022159
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1382106556.40806@H4aePledmTp/lTfO4ezgUg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235906>

Hi,

I'm getting this warning:

  warning: Could not find section in .gitmodules where path=XXX

whenever I use "git mv" to move a file in a repository containing a
submodule. The file is outside the submodule and is completely
unrelated, so I do not understand the intent of the warning.

My understanding (without looking at the code in detail) is that Git
tries to be clever about submodule renames, hence checks whether the
source file is a submodule. But then if the lookup fails, it should just
silently move on to "normal file move" mode I guess...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
