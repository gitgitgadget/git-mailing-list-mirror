From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH] Fixed compilation with Visual Studio by including poll.h
Date: Fri, 20 Apr 2012 23:26:33 +0200
Message-ID: <4F91D489.8050402@tu-clausthal.de>
References: <4F91C8FF.7070402@tu-clausthal.de> <20120420204722.GD13103@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 23:26:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLLLi-00081w-9x
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 23:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895Ab2DTV0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 17:26:33 -0400
Received: from mailrelay1.rz.tu-clausthal.de ([139.174.2.42]:20389 "EHLO
	mailrelay1.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753593Ab2DTV0c (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2012 17:26:32 -0400
Received: from hades.rz.tu-clausthal.de (mailrelay1.rz.tu-clausthal.de [139.174.2.42])
	by mailrelay1.rz.tu-clausthal.de (Postfix) with ESMTP id 0F5814305C1;
	Fri, 20 Apr 2012 23:26:30 +0200 (CEST)
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id DD27F422136;
	Fri, 20 Apr 2012 23:26:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=sKeQEJqdZSR4Tih4vzoY23IhNqM=; b=gzPDbUnUiOgR7Y+9A2xFm37eL6II
	DKMFHCyMVKaV3SETGejDU6lpll/1MWYFEzJbcctOQ9AFUhGtO7MTf6e2qVJMh7ev
	xo6x+pTOE7FF3zsaDg1TBt3ak85wjBu+tZl0lD8KZh3O5TAVDsA7kpVsVWpSNq0O
	C6uFOY+FrmDpm4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=VesvPLc8rENycS4Q3ramx1+hxzoJycA9aVEdiUkl8+BkbBf1wBP9out
	Oj0m+VgRyNikSIYrc/e7r/ch4be/BKwZNjuJbNl2/tSF+u9hqjlMBDmThz2b4WMT
	3GfovibCj7dnc3QT6jZhR4n8Nz332cOYWre+tgfx7VfGkAB62CWk=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 647324220BF;
	Fri, 20 Apr 2012 23:26:29 +0200 (CEST)
Received: from [91.3.185.188] (account sstri@tu-clausthal.de HELO [192.168.178.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 31005577; Fri, 20 Apr 2012 23:26:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <20120420204722.GD13103@sigill.intra.peff.net>
X-Enigmail-Version: 1.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1100_1199 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, CT_TEXT_PLAIN_UTF8_CAPS 0, __ANY_URI 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __SANE_MSGID 0, __TO_MALFORMED_2 0, __URI_NO_MAILTO 0, __URI_NO_PATH 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196025>

Windows does not have sys/poll.h. I have to use the one from compat/win32.

The problem is that
    NO_SYS_POLL_H
is defined in compat/msvc.h in my environment.
And in git-compat-util.h
    #ifndef NO_SYS_POLL_H
    #include <sys/poll.h>
    #else
    #include <poll.h>
    #endif
is before
    #elif defined(_MSC_VER)
    #include "compat/msvc.h"
. Moving it down, solves the issue for me. (Suppose this is a fix for my
scenario only).

diff --git a/git-compat-util.h b/git-compat-util.h
index ed11ad8..a96849c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -111,11 +111,6 @@
 #include <regex.h>
 #include <utime.h>
 #include <syslog.h>
-#ifndef NO_SYS_POLL_H
-#include <sys/poll.h>
-#else
-#include <poll.h>
-#endif
 #if defined(__MINGW32__)
 /* pull in Windows compatibility stuff */
 #include "compat/mingw.h"
@@ -152,6 +147,11 @@
 #define _ALL_SOURCE 1
 #endif
 #endif
+#ifndef NO_SYS_POLL_H
+#include <sys/poll.h>
+#else
+#include <poll.h>
+#endif

 #ifndef NO_LIBGEN_H
 #include <libgen.h>
-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
