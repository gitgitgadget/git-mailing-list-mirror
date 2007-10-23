From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 9/9] git-svn: Make fetch ~1.7x faster
Date: Tue, 23 Oct 2007 09:01:57 +0200
Message-ID: <471D9C65.6090106@viscovery.net>
References: <1193118397-4696-1-git-send-email-aroben@apple.com> <1193118397-4696-2-git-send-email-aroben@apple.com> <1193118397-4696-3-git-send-email-aroben@apple.com> <1193118397-4696-4-git-send-email-aroben@apple.com> <1193118397-4696-5-git-send-email-aroben@apple.com> <1193118397-4696-6-git-send-email-aroben@apple.com> <1193118397-4696-7-git-send-email-aroben@apple.com> <1193118397-4696-8-git-send-email-aroben@apple.com> <1193118397-4696-9-git-send-email-aroben@apple.com> <1193118397-4696-10-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 09:02:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkDmL-0000Pc-M1
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 09:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbXJWHCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 03:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbXJWHCD
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 03:02:03 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:33421 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbXJWHCB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 03:02:01 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IkDll-0003Sq-Vb; Tue, 23 Oct 2007 09:01:42 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8E4EA6C4; Tue, 23 Oct 2007 09:01:57 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1193118397-4696-10-git-send-email-aroben@apple.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62117>

Adam Roben schrieb:
> We were spending a lot of time forking/execing git-cat-file and
> git-hash-object. We now use command_bidi_pipe to keep one instance of each
> running and feed it input on stdin.

I appreciate this. It's certainly going to be a much bigger win on Windows, 
although git svn doesn't work (in the MinGW port) at this time because of 
the old perl and the missing SVN module.

-- Hannes
