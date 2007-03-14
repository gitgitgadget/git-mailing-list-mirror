From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Make gc a builtin.
Date: Tue, 13 Mar 2007 21:37:54 -0400
Message-ID: <7F86A2D8-0407-4663-A97F-7D003F370E0F@silverinsanity.com>
References: 20070312144312.GE15150@spearce.org <11738270273757-git-send-email-jbowes@dangerouslyinc.com> <Pine.LNX.4.63.0703140203250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: James Bowes <jbowes@dangerouslyinc.com>, git@vger.kernel.org,
	spearce@spearce.org, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 14 02:38:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRIRE-0001D9-Fo
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 02:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933364AbXCNBh5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 21:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933651AbXCNBh5
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 21:37:57 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:45215 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933364AbXCNBh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 21:37:57 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id A2EEE1FFC02B;
	Wed, 14 Mar 2007 01:37:56 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.63.0703140203250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42169>


On Mar 13, 2007, at 9:05 PM, Johannes Schindelin wrote:

> If you say "return error(...);", there is _no_ way that multiple error
> messages are printed out.

Except that cmd_gc() is littered with run_command* calls, which fork  
off a subprocess to do the heavy lifting.  So if git-repack fails an  
error will be printed by that process, making the error() call  
redundant.  (If I'm understanding things correctly.)

~~ Brian
