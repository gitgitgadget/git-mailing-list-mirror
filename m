From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: [BUG] git mv file directory/ creates the file directory
Date: Mon, 02 Dec 2013 11:04:06 +0100
Message-ID: <vpqli03sh61.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 02 11:04:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnQMW-0003hl-Jr
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 11:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777Ab3LBKEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 05:04:14 -0500
Received: from mx1.imag.fr ([129.88.30.5]:55810 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606Ab3LBKEL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 05:04:11 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id rB2A46jG001584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 2 Dec 2013 11:04:06 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id rB2A460p026116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 2 Dec 2013 11:04:07 +0100
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 02 Dec 2013 11:04:06 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: rB2A46jG001584
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1386583447.91744@P/TSuom3hzwsjKLy83x86A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238622>

Hi,

When directory/ does not exist, I'd expect this to fail:

  git mv existing-file directory/

(note the trailing slash, to make it clear that directory/ is a
directory). Unix's mv does fail:

  $ mv existing-file directory/
  mv: cannot move `existing-file' to `directory/': Not a directory

Instead, "git mv" seems to do the equivalent of

  git mv existing-file directory # without trailing slash

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
