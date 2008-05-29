From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 6/5] NUL hack to create_file()
Date: Thu, 29 May 2008 08:33:32 +0200
Message-ID: <483E4E3C.90805@viscovery.net>
References: <1212020246-26480-1-git-send-email-gitster@pobox.com> <1212020246-26480-2-git-send-email-gitster@pobox.com> <1212020246-26480-3-git-send-email-gitster@pobox.com> <1212020246-26480-4-git-send-email-gitster@pobox.com> <1212020246-26480-5-git-send-email-gitster@pobox.com> <1212020246-26480-6-git-send-email-gitster@pobox.com> <1212020246-26480-7-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 08:34:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1biX-0003zx-65
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 08:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbYE2Gdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 02:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbYE2Gdh
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 02:33:37 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:53382 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbYE2Gdg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 02:33:36 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K1bhd-0008Q7-9x; Thu, 29 May 2008 08:33:33 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id F2DB16D9; Thu, 29 May 2008 08:33:32 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1212020246-26480-7-git-send-email-gitster@pobox.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83178>

Junio C Hamano schrieb:
> This is not meant for application to the mainline.  It allows your git to
> refuse to create a blob whose name is "nul".

It's not just about "nul"; these won't work either: "aux", "prn", "con",
"com\d+", "lpt\d+", neither do "$one_of_these.$some_extension". And all of
that regardless of the case!

See http://msdn.microsoft.com/en-us/library/aa365247(VS.85).aspx

Definitely, we don't ever want to have such special-casing somewhere in git.

-- Hannes
