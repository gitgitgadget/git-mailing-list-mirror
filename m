From: Brad Roberts <braddr@puremagic.com>
Subject: Re: git reveals a bug in (some versions) BSD diff
Date: Sat, 13 Aug 2005 03:42:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.44.0508130335300.2136-100000@bellevue.puremagic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Aug 13 12:42:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3tT7-0002su-7f
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 12:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbVHMKmJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 06:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbVHMKmJ
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 06:42:09 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:63721 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S1751323AbVHMKmI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2005 06:42:08 -0400
Received: from bellevue.puremagic.com (localhost [127.0.0.1])
	by bellevue.puremagic.com (8.13.4/8.13.4/Debian-3) with ESMTP id j7DAg63N027992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sat, 13 Aug 2005 03:42:06 -0700
Received: from localhost (braddr@localhost)
	by bellevue.puremagic.com (8.13.4/8.13.4/Submit) with ESMTP id j7DAg6Pf027988
	for <git@vger.kernel.org>; Sat, 13 Aug 2005 03:42:06 -0700
X-Authentication-Warning: bellevue.puremagic.com: braddr owned process doing -bs
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I'm seeing this on a standard os/x 10.3.9 install which seems to have an
old, but still GNU based, diff.

$ which diff
/usr/bin/diff

$ diff --version
diff - GNU diffutils version 2.7

$ sh ./t4101-apply-nonl.sh
*   ok 1: apply diff between 0 and 1
*   ok 2: apply diff between 0 and 2
*   ok 3: apply diff between 0 and 3
*   ok 4: apply diff between 1 and 0
*   ok 5: apply diff between 1 and 2
*   ok 6: apply diff between 1 and 3
*   ok 7: apply diff between 2 and 0
*   ok 8: apply diff between 2 and 1
* FAIL 9: apply diff between 2 and 3
        git-apply <diff.2-3 && diff frotz.3 frotz
*   ok 10: apply diff between 3 and 0
*   ok 11: apply diff between 3 and 1
* FAIL 12: apply diff between 3 and 2
        git-apply <diff.3-2 && diff frotz.2 frotz
* failed 2 among 12 test(s)

For what it's worth, this is the only test failing on this box (after the
application of the TZ patch I just sent).

Later,
Brad
