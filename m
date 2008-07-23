From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] git daemon: avoid waking up too often
Date: Wed, 23 Jul 2008 08:51:47 +0200
Message-ID: <4886D503.7030106@viscovery.net>
References: <alpine.DEB.1.00.0807222251570.8986@racer> <alpine.DEB.1.00.0807222302440.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 08:52:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLYDU-0007SN-0V
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 08:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbYGWGvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 02:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbYGWGvv
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 02:51:51 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:27161 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbYGWGvu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 02:51:50 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KLYCS-0004DT-8e; Wed, 23 Jul 2008 08:51:48 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DCB8E6B7; Wed, 23 Jul 2008 08:51:47 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.DEB.1.00.0807222302440.8986@racer>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89604>

Johannes Schindelin schrieb:
> To avoid waking up unnecessarily, a pipe is set up that is only ever
> written to by child_handler(), when a child disconnects, as suggested
> per Junio.
> 
> This avoids waking up the main process every second to see if a child
> was disconnected.

This makes porting this beast to Windows practically impossible because we
cannot have a poll() implementation that waits both on a listening socket
and a pipe. :-(

-- Hannes
