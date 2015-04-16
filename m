From: Andreas Mohr <andi@lisas.de>
Subject: Issue: repack semi-frequently fails on Windows (msysgit) -
 suspecting file descriptor issues
Date: Thu, 16 Apr 2015 12:03:59 +0200
Message-ID: <20150416100359.GA19951@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 12:10:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YigkX-0004Mo-UX
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 12:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbbDPKKO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Apr 2015 06:10:14 -0400
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:59027 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964853AbbDPKKK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 06:10:10 -0400
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Apr 2015 06:10:10 EDT
Received: by rhlx01.hs-esslingen.de (Postfix, from userid 102)
	id 115D04A248; Thu, 16 Apr 2015 12:03:59 +0200 (CEST)
Content-Disposition: inline
X-Priority: none
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267274>

Hi all,

over the years I've had the same phenomenon with various versions of ms=
ysgit
(now at 1.9.5.msysgit.0, on Windows 7 64bit), so I'm now sufficiently
confident of it being a long-standing, longer-term issue and thus I'm
reporting it now.

Since I'm doing development in a sufficiently rebase-heavy manner,
I seem to aggregate a lot of objects.
Thus, when fetching content I'm sufficiently frequently greeted with
a git gc run.
This, however, does not work fully reliably:

    Auto packing the repository for optimum performance. You may also
    run "git gc" manually. See "git help gc" for more information.
    Counting objects: 206527, done.
    Delta compression using up to 4 threads.
    Compressing objects: 100% (27430/27430), done.
    Writing objects: 100% (206527/206527), done.
    Total 206527 (delta 178632), reused 206527 (delta 178632)
    Unlink of file '.git/objects/pack/pack-ab1712db0a94b5c55538d3b4cb36=
60cedc264c3c.pack' failed. Should I try again? (y/n) n
    Unlink of file '.git/objects/pack/pack-ab1712db0a94b5c55538d3b4cb36=
60cedc264c3c.idx' failed. Should I try again? (y/n) n
    Checking connectivity: 206527, done.

A workable workaround for this recurring issue
(such a fetch will fail repeatedly,
thereby hampering my ability to update properly)
is to manually do a "git gc --auto"
prior to the fetch (which will then succeed).




--=20
=BFumop apisdn upside down?
(by daniweb.com user Bench)
