From: uli <uli.heller@daemons-point.com>
Subject: Re: git svn fetch segfault on exit
Date: Mon, 2 Sep 2013 00:40:16 -0700 (PDT)
Message-ID: <1378107616368-7595155.post@n2.nabble.com>
References: <51E7B382.8050302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 02 09:40:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGOkJ-0008KG-Dw
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 09:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756289Ab3IBHkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 03:40:17 -0400
Received: from sam.nabble.com ([216.139.236.26]:34236 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288Ab3IBHkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 03:40:16 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <uli.heller@daemons-point.com>)
	id 1VGOkC-0005mV-C7
	for git@vger.kernel.org; Mon, 02 Sep 2013 00:40:16 -0700
In-Reply-To: <51E7B382.8050302@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233629>

I'm facing the same issue. I'm using git-1.8.4 and subversion 1.8.3 on
Ubuntu.

I'm proposing a different modification to Ra.pm:



Jonathan's modifications basically disable the use of $RA. The modifications
above ensure that the destructor of $RA is called before doing an
apr_terminate().

Best regards, Uli.



--
View this message in context: http://git.661346.n2.nabble.com/git-svn-fetch-segfault-on-exit-tp7592205p7595155.html
Sent from the git mailing list archive at Nabble.com.
