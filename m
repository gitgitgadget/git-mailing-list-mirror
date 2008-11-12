From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] contrib/hooks/post-receive-email: send individual
 mails to recipients
Date: Wed, 12 Nov 2008 18:08:43 +0100
Message-ID: <491B0D9B.7080306@viscovery.net>
References: <E1L0Iv1-00BwsF-Jh@intern.SerNet.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Adam <obnox@samba.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 18:10:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0JEL-0005NR-Ip
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 18:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbYKLRIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 12:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752770AbYKLRIu
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 12:08:50 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:57188 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621AbYKLRIt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 12:08:49 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L0JCu-0002og-Aj; Wed, 12 Nov 2008 18:08:44 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0606A4E4; Wed, 12 Nov 2008 18:08:43 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <E1L0Iv1-00BwsF-Jh@intern.SerNet.DE>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100770>

Michael Adam schrieb:
> This changes the behaviour of post-receive-email when a list of recipients
> (separated by commas) is specified as hooks.mailinglist. With this modification,
> an individual mail is sent out for each recipient entry in the list, instead
> of sending a single mail with all the recipients in the "To: " field.

I don't think this is well-behaved:

- The load multiplies for the sender (typically a repository server).

- And wouldn't each recipient get a new Message-Id? This would break
threading if further communication takes place among the recipients.

But I may be wrong on both accounts.

-- Hannes
