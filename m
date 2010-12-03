From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 0/7] web--browse cleanup and extensions
Date: Fri,  3 Dec 2010 17:47:34 +0100
Message-ID: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 03 17:48:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POYnn-0006zs-Py
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 17:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340Ab0LCQsC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 11:48:02 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47167 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab0LCQsA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 11:48:00 -0500
Received: by wwa36 with SMTP id 36so10251895wwa.1
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 08:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=TvZ64BScRaxKTkYcXe+ePsMT5guIeFHbVcLiI832h6g=;
        b=h0B2I7N2v1+vGIxJqDg7ecNO7UzTyN1JBGEoDnFRzlCv7KR1FHiiyQMH4ABSeWR9z+
         TtYqEfUv13UZNtjJW7FnoRlABBlOIuC+ucivU3kcW6oxwHXjpXMPolgOqMY25DgBkVjf
         YdsOLS1iWGtgDKHzcdYQjgc8ZVeqO1Uv3vgng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=b3JrsSloeW8rjMAXygDCyG3mN4d6VcfRX9uoyTuSCVTXN69CpgRP3KFMHNclrBbS7F
         hVrgtEP3PMC5ZyrbHCxA9WFQp+Vyb7rH7slxOJ4ALBWcYOHclQJpe9ZSpHPny2vMGw/q
         Hw00YhIVXJhLXlTWnz6uZF3mvbN0EEmm50Irc=
Received: by 10.216.173.4 with SMTP id u4mr886834wel.87.1291394879187;
        Fri, 03 Dec 2010 08:47:59 -0800 (PST)
Received: from localhost (nat.ct.ingv.it [193.206.223.100])
        by mx.google.com with ESMTPS id x28sm975314weq.16.2010.12.03.08.47.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 08:47:46 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.664.g294b8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162806>

This second issue of the web--browse cleanup and extension patchset
has seen some stylistic changes in the first patches as discussed on the
ML, and a new patch to add support for the BROWSER env var. Support for
xdg-open is still missing, due to the lack of an obvious way to suggest
opening pages in new tabs (same reason why we don't directly support
Debian's sensible-browser).

I'm quite convinced that the first 4 patches (up to the "support opera,
seamonkey and elinks" patch, inclusive) are ready for merging.

The fifth patch is slightly more extensive than in the previous
iteration, including chromium-browser as a supported option, but still
looking for chromium-browser first even when browser=chromium.

The last two patches are more RFCish. I tried to include the changes
suggested by Christian, unless of course I forgot something. Suggestions
on possible ways to improve the proposed approach are welcome.

Giuseppe Bilotta (7):
  CodingGuidelines: mention whitespace preferences for shell scripts
  web--browse: coding style
  web--browse: split valid_tool list
  web--browse: support opera, seamonkey and elinks
  web--browse: better support for chromium
  web--browse: use (x-)www-browser if available
  web--browse: look at the BROWSER env var

 Documentation/CodingGuidelines    |    4 +
 Documentation/git-web--browse.txt |   10 ++
 git-web--browse.sh                |  276 +++++++++++++++++++++++++------------
 3 files changed, 203 insertions(+), 87 deletions(-)

-- 
1.7.3.2.664.g294b8.dirty
