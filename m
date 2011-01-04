From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: PostScript files: textconv and "git add -p"
Date: Tue, 04 Jan 2011 16:50:44 +0100
Message-ID: <vpqy670brcb.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 04 16:50:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pa99z-0001fo-6S
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 16:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353Ab1ADPuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 10:50:50 -0500
Received: from mx1.imag.fr ([129.88.30.5]:52445 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989Ab1ADPuu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 10:50:50 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p04FohZ5024277
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 4 Jan 2011 16:50:43 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Pa99o-0000C9-SC; Tue, 04 Jan 2011 16:50:44 +0100
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 04 Jan 2011 16:50:43 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p04FohZ5024277
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1294761046.67665@lXQf4cysVTLbFgBhNgImSQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164498>

Hi (and happy new year everybody !),

I have trouble setting up a comfortable configuration to version
PostScript files. The particularity they have is that they are "text
files" (i.e. git does not detect them as binary files by default, and
neither do tools like less, diff, ...), but not meant to be
human-readable.

If I do this:

,----[ .gitattributes ]
| *.ps diff=ps
`----

,----[ .gitconfig ]
| [diff "ps"]
|       textconv=ps2ascii
`----

then I get the textconv niceness when running "git diff", which is
cool, but "git add -p" still proposes me to stage hunks one by one,
which isn't.

If I set "*.ps binary" in .gitattributes, "git add -p" becomes quiet,
but textconv is disabled.

I want "git diff" to run the textconv filter, and "git add -p" to
consider the file as binary. Is there a way to do this?

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
