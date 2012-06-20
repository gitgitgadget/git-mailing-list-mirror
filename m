From: Michael Hertling <mhertling@online.de>
Subject: Missing hyperlinks in HTML docs
Date: Wed, 20 Jun 2012 22:43:08 +0200
Message-ID: <4FE235DC.9080202@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 20 22:41:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShRiJ-0005sZ-Gc
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 22:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822Ab2FTUlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 16:41:14 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:56697 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab2FTUlO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 16:41:14 -0400
Received: from [192.168.178.21] (p57A28F78.dip0.t-ipconnect.de [87.162.143.120])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MfjDI-1SVOTl021E-00NBdc; Wed, 20 Jun 2012 22:41:13 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101211 Lightning/1.0b2 Lanikai/3.1.7
X-Provags-ID: V02:K0:EZxY3BOpKrD+hq4VtoDxRpgnlUQ/JFT8UC4hCj7j4uM
 S8vdB7unqu7hXtCq7P6njhUZyNxR4gv8zNsgw15RSZ4ExEkqgj
 DvgNNPj9licXOQqaXVC9xyYQnwvoENbBwydfTsm3xIADGTrcab
 SYIZXnnJm1uhUKaHXFfG7OXLRn7jtqRfmtOvAQg44Wdtictbvi
 dhVwWBUxZxWxzamsw6c+1IwwZ3wIdoPJBzkoGG3PeRvXIO4pwx
 gVXChTuAJCoyXj1DlnXKbi+LUhU1UgbbiL15S0vi82izfyglgT
 QQiBf++FUTGTCYvuPmQdK9YJBZb55Qqgj3eY8zLMoFphUi1iwi
 Lnptj0CXvt7J6IwqAsFU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200359>

Dear Git community,

beginning with v1.7.11-rc3, some HTML docs built along with Git
are lacking hyperlinks on my system. Steps to reproduce, e.g.:

gunzip -c git-1.7.11.rc3.tar.gz | tar xf -
(cd git-1.7.11.rc3 && ./configure && make -C Documentation git.html)

The resulting git.html does not have hyperlinks to the individual
Git commands, making this file somewhat useless. Doing the same
with v1.7.11-rc2, i.e.

gunzip -c git-1.7.11.rc2.tar.gz | tar xf -
(cd git-1.7.11.rc2 && ./configure && make -C Documentation git.html)

shows that git.html does have the expected hyperlinks; e.g., diffing
git-1.7.11.rc{2,3}/Documentation/git.html reveals the following hunk:

@@ -964,7 +964,6 @@
 <h3 id="_main_porcelain_commands">Main porcelain commands</h3>
 <div class="dlist"><dl>
 <dt class="hdlist1">
-<a href="git-add.html">git-add(1)</a>
 </dt>
 <dd>
 <p>

Other files, e.g. git-add.html, are affected, too.

AFAICS, this is caused by fe77b41, more precisely the change of the
Documentation/asciidoc.conf file. Indeed, reverting that commit on
v1.7.11-rc3 results in git.html containing hyperlinks as expected.

Can anyone confirm this? If so, is this intended behaviour? So far,
I haven't found any clues in the release notes / mailing list / etc.
Am I doing something wrong? Do I miss something? Thanks for any hint.

Regards,

Michael
