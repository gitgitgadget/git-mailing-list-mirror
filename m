From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Behavior of 'git add \*.txt': bug or feature?
Date: Wed, 16 Sep 2009 21:46:51 +0200
Message-ID: <vpqljke7jv8.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 16 21:47:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo0T0-0006fT-KU
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 21:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754481AbZIPTqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 15:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753235AbZIPTqx
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 15:46:53 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44968 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752363AbZIPTqw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 15:46:52 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n8GJgf9k028987
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 16 Sep 2009 21:42:41 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Mo0Sp-0005Fo-Hx; Wed, 16 Sep 2009 21:46:51 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Mo0Sp-0000mx-Gk; Wed, 16 Sep 2009 21:46:51 +0200
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 16 Sep 2009 21:42:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8GJgf9k028987
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1253734962.13362@sBeIMcEYJ1aAUBbjvi6N1Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128672>

Hi,

I find the behavior of 'git add \*.txt' strange: for adding untracked
files, it considers \*.txt as a pattern to match, but for updating
existing file's staged content, it seems to consider it as a filename:

$ git status
# On branch master
# Changed but not updated:
#
#       modified:   three.txt
#       modified:   two.txt
#
# Untracked files:
#
#       one.txt
no changes added to commit (use "git add" and/or "git commit -a")
$ git add -v '*.txt'
add 'one.txt'
$ git add -v '*.txt'
$ 

I would have expected this "git add -v '*.txt'" to update the staged
content of two.txt and three.txt too.

It this the intended behavior? If so, what's the rationale for this?

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
