From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC] branch: add optional parameter to -r to specify remote
Date: Mon, 20 Jun 2011 08:40:32 +0200
Message-ID: <4DFEEB60.5000005@viscovery.net>
References: <1308511149-10933-1-git-send-email-billiob@gmail.com> <1308511149-10933-2-git-send-email-billiob@gmail.com> <7vtyble9k8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Boris Faure <billiob@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 08:40:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYYAG-0004ow-N0
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 08:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382Ab1FTGkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 02:40:47 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:18916 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752203Ab1FTGkr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 02:40:47 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QYYA5-0004Nz-Vi; Mon, 20 Jun 2011 08:40:42 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A323B1660F;
	Mon, 20 Jun 2011 08:40:41 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <7vtyble9k8.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176050>

Am 6/20/2011 0:32, schrieb Junio C Hamano:
> It would make much more sense to restrict this feature to the "listing"
> side of the branches.  It would be nice if you can do:

I agree with everything you said earlier and the first sentence above. And
I would have needed the possibility to limit the branch listing to a
particular remote a lot in the past. But...

> 	$ git branch -r --match alice --match bob
> 
> to show only remote tracking branches under refs/remotes/{alice,bob}
> and also
> 
> 	$ git branch --match "jk/*"
> 
> to show only local topic branches whose names match the given blob.

I would hate having to learn a new syntax '--match "jk/*"' when we can
already say

    $ git log --remotes
    $ git log --remotes=alice --remotes=bob
    $ git log --remotes="jk/*"

IMO, it is the right approach to have a long option --remotes with an
optional argument.

-- Hannes
