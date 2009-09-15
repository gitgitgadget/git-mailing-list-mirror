From: Guido Ostkamp <git@ostkamp.fastmail.fm>
Subject: Re: Git crashes on pull
Date: Wed, 16 Sep 2009 00:30:16 +0200 (CEST)
Message-ID: <alpine.LSU.2.01.0909160022430.24554@bianca.dialin.t-online.de>
References: <alpine.LSU.2.01.0909152044450.10936@bianca.dialin.t-online.de> <7vljkg57xs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 00:30:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MngXd-0004gq-Qk
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 00:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbZIOWaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 18:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752349AbZIOWaT
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 18:30:19 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54950 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752220AbZIOWaT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 18:30:19 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5E91A6BD83;
	Tue, 15 Sep 2009 18:30:22 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 15 Sep 2009 18:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=smtpout; bh=3neER6ZDXYQKgNKgZGuZFpA17+s=; b=YFZLHg95GeyxvKCrkeCdb1SQdwIgYpQn/H6FJfQYX66831caX2xO8eTj0C2gqBf9T4juzLoHXc/Rjlq8w3PbfGOLTX9lstEIGO2OcAFDIeeZ18CaOYGsbE3YOqSLv1TcUNHrTuqJIP4TL0MkghOxDHNfNxofUII7F3jbtXa9mWg=
X-Sasl-enc: LZmMLo1BNZmLsxpbGyv6q26aZaCaJjfnooq98CEN6tBQ 1253053821
Received: from [192.168.2.101] (p549A59D7.dip.t-dialin.net [84.154.89.215])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 88A376B98C;
	Tue, 15 Sep 2009 18:30:21 -0400 (EDT)
In-Reply-To: <7vljkg57xs.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LSU 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128591>

On Tue, 15 Sep 2009, Junio C Hamano wrote:

> Please try this patch, which I have been preparing for later pushout.
>
> From: Junio C Hamano <gitster@pobox.com>
> Date: Mon, 14 Sep 2009 14:48:15 -0700
> Subject: [PATCH] http.c: avoid freeing an uninitialized pointer
>
> An earlier 59b8d38 (http.c: remove verification of remote packs) left
> the variable "url" uninitialized; "goto cleanup" codepath can free it
> which is not very nice.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Appears to be working ok now, thanks.

BTW: Is there any way to easily invoke GDB in case of such a problem to 
get a real symbolic stack backtrace?

I tried it on the 'git' binary, but of course this didn't work because it 
invokes a git-pull script which again runs another git-remote-curl binary.

Regards

Guido
