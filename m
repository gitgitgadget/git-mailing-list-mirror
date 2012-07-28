From: "Michael G. Schwern" <schwern@pobox.com>
Subject: Canonicalize the git-svn path & url accessors
Date: Sat, 28 Jul 2012 02:38:25 -0700
Message-ID: <1343468312-72024-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 28 11:39:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv3Un-0007Xk-Tl
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 11:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547Ab2G1Jiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 05:38:52 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50635 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab2G1Jiv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 05:38:51 -0400
Received: by pbbrp8 with SMTP id rp8so6493452pbb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 02:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=xbPFn8ngYRGccaQXs3re6O1Fk8MkTKa/3SI60jVy/g4=;
        b=DkiuDBpMdgGdaYdNeoQkEUEnbACZavSIegAdJ3qubV7Ej/TH26T9t1NClNstnxxRZr
         4fpdSzuWVenbrOlA+Z/kFSwDRj1FRwvItdnJD3Nvg8WantS55f8UspvL0RJhyqlTqtj6
         mwwd5IE8m9zqKYfQqLDAEfLFTQGjKQZPxAMYoCceHiHLPaYnvdMMX0JDittX5yv0Vkbc
         UGv41m0fr7F9ERtbnhVDUdttx6qJdPyop06w+cRssagyzQiwqGX9nDkyPEg/pLyEjQQG
         3j8lTiqtX0hy8i8wVJzbIK/uqrcRuT/E3WleZLZxrrzMsRX9cLeVWIsGxZVOGhdLhJnw
         y0fA==
Received: by 10.66.85.135 with SMTP id h7mr11042408paz.75.1343468331350;
        Sat, 28 Jul 2012 02:38:51 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id rs4sm3689907pbc.0.2012.07.28.02.38.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 02:38:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202411>

This patch turns on canonicalization in the Git::SVN and Git::SVN::Ra
path and url accessors.

It also makes the canonicalizers use the SVN API when available.

All patches pass with SVN 1.6.  Next patch series will fix SVN 1.7.

This should be placed on top of the previous patch series which added
path and url accessors.
