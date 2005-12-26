From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: cg-update does not work with argument specified
Date: Mon, 26 Dec 2005 17:02:22 +0300
Message-ID: <200512261702.22747.snake@penza-gsm.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 26 15:03:55 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eqsx4-0002Mb-L6
	for gcvg-git@gmane.org; Mon, 26 Dec 2005 15:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVLZOC0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Dec 2005 09:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVLZOC0
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Dec 2005 09:02:26 -0500
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:40110
	"HELO penza-gsm.ru") by vger.kernel.org with SMTP id S1750724AbVLZOC0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Dec 2005 09:02:26 -0500
Received: (qmail 13798 invoked from network); 26 Dec 2005 14:02:24 -0000
Received: from unknown (HELO snake) (192.168.0.20)
  by fileserver.penza-gsm.ru with SMTP; 26 Dec 2005 14:02:23 -0000
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.7.2
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on fileserver
X-Spam-Level: 
X-Spam-Status: No, score=-102.8 required=5.0 tests=ALL_TRUSTED,AWL,
	USER_IN_WHITELIST autolearn=unavailable version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14052>

Documentation/tutorial-script/script.sh line 117 fails when trying to execute
cg-update bobswork

The error message is:
cg-fetch: where to fetch from?

Quick investigation showed that cg-update runs cg-fetch as:
cg-fetch "$force" "$name"

When tried it manually with
cg-fetch "" bobswork got the same error.
Removing "" works fine.

Further investigation showed that cg-fetch uses 
name="${ARGS[0]}"
line to find out branch name but ARGS[0] contains empty string.

Probably something should be fixed about lines 391-404 in cg-Xlib where
ARGS is set but I do not know this bash feature so unfortunately can't write 
patch myself.

Hope this helps.

P.S. Please Cc: me I'm not following the list closely.

-- 
Respectfully
Alexey Nezhdanov
