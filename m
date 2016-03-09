From: Anders Kaseorg <andersk@mit.edu>
Subject: Re: [PATCH] rebase -p: avoid grep on potentailly non-ASCII data
Date: Tue, 8 Mar 2016 21:31:01 -0500 (EST)
Message-ID: <alpine.DEB.2.10.1603082127230.2674@buzzword-bingo.mit.edu>
References: <alpine.DEB.2.10.1603080255030.2674@buzzword-bingo.mit.edu> <56DEC4B4.2000902@web.de> <56DED770.4050603@drmicha.warpmail.net> <20160308143556.GA10153@sigill.intra.peff.net> <xmqqio0wk151.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 03:36:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adTz7-0006eH-Uq
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 03:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbcCICgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 21:36:22 -0500
Received: from dmz-mailsec-scanner-1.mit.edu ([18.9.25.12]:56423 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750766AbcCICgV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2016 21:36:21 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Mar 2016 21:36:21 EST
X-AuditID: 1209190c-083ff70000006043-59-56df8ae803b5
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	(using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by  (Symantec Messaging Gateway) with SMTP id 63.02.24643.8EA8FD65; Tue,  8 Mar 2016 21:31:04 -0500 (EST)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id u292V3pj014740;
	Tue, 8 Mar 2016 21:31:03 -0500
Received: from localhost (buzzword-bingo.mit.edu [18.9.64.24])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id u292V1Gh021982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 8 Mar 2016 21:31:03 -0500
In-Reply-To: <xmqqio0wk151.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixG6novui636YwaWvvBZdV7qZLBp6rzA7
	MHlcvKTs8XmTXABTFJdNSmpOZllqkb5dAlfG4herGQvWMVVc2ZfTwPiNsYuRk0NCwETi/Jfn
	zF2MXBxCAm1MEh2fr7FAOBsYJb7uewPl7GKSeN9+lL2LkYODRUBLYt6BQJBuNgE1iQ9Hv7KC
	2CJA9sS2QywgNrOAuMSm5W+YQGxhAQ+JLSsegG3jFLCWmLnwBDOIzSvgLnG+ZzEjxPznjBKT
	zx4FaxAV0JU49O8PG0SRoMTJmU+ghmpJLJ++jWUCI/8sJKlZSFILGJlWMcqm5Fbp5iZm5hSn
	JusWJyfm5aUW6Rrq5WaW6KWmlG5iBAUdpyTPDsYzb7wOMQpwMCrx8G5wux8mxJpYVlyZe4hR
	koNJSZT3jhRQiC8pP6UyI7E4I76oNCe1+BCjBAezkghvAjDUhXhTEiurUovyYVLSHCxK4ryF
	+0+HCQmkJ5akZqemFqQWwWRlODiUJHijQBoFi1LTUyvSMnNKENJMHJwgw3mAhm/rBBleXJCY
	W5yZDpE/xajLseDH7bVMQix5+XmpUuK8RSBFAiBFGaV5cHPAyYLTQeIVozjQW8K8/CDreICJ
	Bm7SK6AlTEBLXrTeA1lSkoiQkmpg3LOn4Ytz55tgHb6CxgsTzxZlKL5bVFu7cN3Ei8Wxmxwu
	cMrWPxRo59hucaXdX9Dm8+2bV/itn7/+5j6z9o7LJ5b/xiyrr4UZBx+d6Br15PC+lVYn+fcs
	XpKS9JP1u/6Ngt/q9e7FTksFvu/0ztod9ozrcnmankeWz4OtVStCXrU2Vl87wt7K 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288472>

The autoconf support you committed as 67f1790a has a small bug (the else 
cause should omit -a):

+if grep -a ascii configure.ac >/dev/null; then
+  AC_MSG_RESULT([Using 'grep -a' for sane_grep])
+  SANE_TEXT_GREP=-a
+else
+  SANE_TEXT_GREP=-a
+fi
+GIT_CONF_SUBST([SANE_TEXT_GREP])

Anders
