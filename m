From: Jonas 'Sortie' Termansen <Sortie@Maxsi.org>
Subject: Re: [PATCH 2/9] autoconf: Check for timer_t
Date: Thu, 28 Aug 2014 14:03:06 +0200
Message-ID: <53FF1A7A.6000808@Maxsi.org>
References: <1409187862-21257-1-git-send-email-sortie@maxsi.org> <1409187862-21257-3-git-send-email-sortie@maxsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 14:10:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMyX6-0001Gm-GX
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 14:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbaH1MKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 08:10:24 -0400
Received: from csmtp3.one.com ([91.198.169.23]:37035 "EHLO csmtp3.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbaH1MKX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 08:10:23 -0400
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Aug 2014 08:10:23 EDT
Received: from [192.168.1.2] (0133301021.0.fullrate.dk [95.166.189.26])
	by csmtp3.one.com (Postfix) with ESMTPA id DF42940013983
	for <git@vger.kernel.org>; Thu, 28 Aug 2014 12:03:06 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1409187862-21257-3-git-send-email-sortie@maxsi.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256078>

It would appear that Darwin does not have timer_t, at least from looking
at the public libc and XNU headers online.

A quick additional change is needed in config.mak.uname:

ifeq ($(uname_S),Darwin)
...
 	HAVE_DEV_TTY = YesPlease
+	NO_TIMER_T = UnfortunatelyYes
 	COMPAT_OBJS += compat/precompose_utf8.o
...
endif

I'll include that proper in V2 of my patch series.

Jonas
