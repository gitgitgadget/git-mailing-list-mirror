From: Thomas Rast <trast@student.ethz.ch>
Subject: URL decoding changed semantics of + in URLs
Date: Fri, 23 Jul 2010 15:18:30 +0200
Message-ID: <201007231518.31071.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <jstpierre@mecheye.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 23 15:19:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcI9a-0007Le-7R
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 15:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759119Ab0GWNSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 09:18:54 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:11825 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759480Ab0GWNSx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 09:18:53 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 23 Jul
 2010 15:18:51 +0200
Received: from thomas.localnet (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.0.702.0; Fri, 23 Jul
 2010 15:18:30 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.93; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151529>

Hi Jeff

As pointed out by Jasper St. Pierre on #git, it is no longer possible
to clone

  git://git.gnome.org/gtk+

because your 9d2e942 (decode file:// and ssh:// URLs, 2010-05-23)
decodes + characters in URLs to spaces in the http style.  It was
later fixed by ce83eda (url.c: "<scheme>://" part at the beginning
should not be URL decoded, 2010-06-23) but the later part of the url
still decodes + as space.

The tests that go along with the commit make it clear that it was an
intended change.  But the interesting thing is, I cannot find any
reference in any RFC that + must have this meaning.  In particular,

  http://www.ietf.org/rfc/rfc2396.txt

doesn't say much about + and the only escaping defined is the usual
%xx style.  So is there a standard that mandates this, or was it just
a well-meaning but unnecessary backwards incompatible change?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
