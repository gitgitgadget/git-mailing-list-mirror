From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Replace misleading message during interactive rebasing
Date: Wed, 28 Nov 2007 13:53:59 +0100
Message-ID: <474D64E7.9060603@viscovery.net>
References: <1196111891-18518-1-git-send-email-win@wincent.com> <474BD5CA.7050407@viscovery.net> <7vve7n9eaa.fsf@gitster.siamese.dyndns.org> <47D3817B-AA0D-4949-99ED-C36611604D5E@wincent.com> <Pine.LNX.4.64.0711281237250.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	tsuna@lrde.epita.fr, mcostalba@gmail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 13:54:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxMQz-0000Jp-BG
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 13:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759538AbXK1MyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 07:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759396AbXK1MyM
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 07:54:12 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:54144 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758737AbXK1MyK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 07:54:10 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IxMPk-0002WQ-VR; Wed, 28 Nov 2007 13:53:17 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 371CA4E4; Wed, 28 Nov 2007 13:53:59 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0711281237250.27959@racer.site>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66312>

Johannes Schindelin schrieb:
> You could still provide the "me" and unique_abbrev parameters, so that the 
> first %s in _GIT_CHERRY_PICK_HELP would be replaced by the operation, and 
> the second by the sha1.  Hmm?

Gaah! First rule to safe programming: Don't use user input as format 
strings. getenv(_GIT_CHERRY_PICK_HELP) *is* user input. In this case, the 
caller knows exactly what the put into the help string, so it should do so.

-- Hannes
