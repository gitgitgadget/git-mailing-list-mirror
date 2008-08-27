From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix a warning (on cygwin) to allow -Werror
Date: Wed, 27 Aug 2008 09:57:36 +0200
Message-ID: <48B508F0.70402@viscovery.net>
References: <48B4426D.3090801@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Aug 27 09:58:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYFvU-0006vP-KC
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 09:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbYH0H5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 03:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752727AbYH0H5o
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 03:57:44 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:27983 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbYH0H5n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 03:57:43 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KYFuK-0002NN-Nw; Wed, 27 Aug 2008 09:57:36 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 661BE6B7; Wed, 27 Aug 2008 09:57:36 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <48B4426D.3090801@ramsay1.demon.co.uk>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93867>

Ramsay Jones schrieb:
> Also, I noticed that git_ntohl() is still defined in compat/mingw.h; is this
> still required?  It's not a problem, just curious! (I don't have mingw
> installed, so I can't test myself)

Yes, it's still needed. The reason is that on Windows ntohl() returns
'unsigned long', and then gcc warns about

sha1_file.c:700: warning: unsigned int format, u_long arg (arg 3)

git_ntohl() is the workaround.

-- Hannes
