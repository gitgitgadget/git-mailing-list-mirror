From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v5] Re: git-am: allow e-mail file(s) as input
Date: Thu, 16 Jul 2009 10:17:40 +0200
Message-ID: <4A5EE224.6020702@viscovery.net>
References: <7v7hy9bb8k.fsf@alter.siamese.dyndns.org> <eb6317e39369adc8d2594c35ee351b49aaadcc24.1247721562.git.nicolas.s.dev@gmx.fr> <4A5ED22B.6050101@gmail.com> <7v8wip9jjw.fsf@alter.siamese.dyndns.org> <20090716075055.GI12971@vidovic> <20090716080657.GJ12971@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Jul 16 10:18:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRMAB-00060C-Rx
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 10:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbZGPIRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 04:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752846AbZGPIRw
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 04:17:52 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:7342 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760AbZGPIRv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 04:17:51 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MRM9s-0001Ya-Pe; Thu, 16 Jul 2009 10:17:48 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 87B729F88; Thu, 16 Jul 2009 10:17:40 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090716080657.GJ12971@vidovic>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123388>

Nicolas Sebrecht schrieb:
> The 16/07/09, Nicolas Sebrecht wrote:
>> The 16/07/09, Junio C Hamano wrote:
>>> This patch wastes an extra sed process
>> Should we really worry about that in a script like git-am.sh? I mean,
>> does it matter in a day to day work?
> 
> Oh I've forgotten, yes we need it: sed -e '/^$/q' leaves this matching
> line to the output. An extra CRLF makes 'grep -v' fail.

Then make it

    sed -n -e '/^$/q' -e p

This won't print the trailing empty line.

-- Hannes
