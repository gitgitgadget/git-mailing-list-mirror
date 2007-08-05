From: David Kastrup <dak@gnu.org>
Subject: Bug in update-index?
Date: Sun, 05 Aug 2007 10:42:09 +0200
Message-ID: <85vebubcf2.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 10:42:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHbhH-000441-7r
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 10:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759617AbXHEIm1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 04:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756375AbXHEIm0
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 04:42:26 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:47205 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759600AbXHEImU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 04:42:20 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id D22A91ECF78
	for <git@vger.kernel.org>; Sun,  5 Aug 2007 10:42:18 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id B6D3C23D296
	for <git@vger.kernel.org>; Sun,  5 Aug 2007 10:42:18 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-057-031.pools.arcor-ip.net [84.61.57.31])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 10B893425E5
	for <git@vger.kernel.org>; Sun,  5 Aug 2007 10:42:17 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 72FDA1C4F932; Sun,  5 Aug 2007 10:42:10 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3857/Sun Aug  5 08:20:59 2007 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54968>


Hi, the following bombs out:

 time git --work-tree=/usr/local/texlive/2007/texmf-dist ls-files -z -m -o .|git --work-tree=/usr/local/texlive/2007/texmf-dist update-index --add -z --stdin
error: bibtex/bib/IEEEtran/IEEEabrv.bib: does not exist and --remove not passed
fatal: Unable to process path bibtex/bib/IEEEtran/IEEEabrv.bib

It would appear that update-index is not finding the listed file in
spite of the --work-tree argument.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
