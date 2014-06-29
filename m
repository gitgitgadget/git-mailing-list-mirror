From: Felix Eckhofer <felix@tribut.de>
Subject: Re: Passing rev-list options in git-filter-branch broken
Date: Sun, 29 Jun 2014 16:00:49 +0200
Message-ID: <cacf17948e270ab33cc9ff145c4a1af7@tribut.de>
References: <987cd4ccd2b86a840b900a25e0edf0f9@tribut.de>
 <xmqq1tua2oi5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 16:00:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1Ff8-00070k-VN
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 16:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbaF2OAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2014 10:00:53 -0400
Received: from metis.tribut.de ([78.46.43.195]:52849 "EHLO metis.tribut.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750720AbaF2OAw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2014 10:00:52 -0400
Received: from webmail.tribut.de (localhost [127.0.0.1])
	by metis.tribut.de (Postfix) with ESMTP id F35CB13578B;
	Sun, 29 Jun 2014 16:00:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tribut.de; s=dkim;
	t=1404050450; bh=gLMCsfKdvbaSp7yZjCwLwOGJPMkxWzXrFyPd23m5FjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AMFMRUH0g5ySwrPI6pseFrd4yxG1pMjUfVIyl3udOaR9S62C1/k9OpUqXhOcoPo7q
	 lzfRCtqT6myUwZFrmL8LjKwxi74SeGkS91TrT3cNn2ncnlEDuxoWCLQPQBw2lsh73+
	 uFrntRNKcF/6uR8VxDSkpgufveVNFZcya/gpmlN9d6p4qC0BQ/M6JALK5Pb2WCrM9E
	 CVzOnRf5X6nhuEuoyQywzoUrbe17xFHL5H55ap0AA3WLZbFuLlE43cDh53rz7bJ7eT
	 7P4szONdYt1UH1R5C67jDogyIEe6pqr/yYby3JblNqsyjXpVBRPnu5AxwYcBGrlIrp
	 +dGOdpfRr7rtw==
In-Reply-To: <xmqq1tua2oi5.fsf@gitster.dls.corp.google.com>
X-Sender: felix@tribut.de
User-Agent: Roundcube Webmail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252642>

Junio,

thanks for your reply and your patch.

Am 27.06.2014 20:31, schrieb Junio C Hamano:
> [...]
> would be a better workaround that would not break repositories with
> large number of references, but it obviously will lose --date-order
> option (why would it be even necessary, though?  I suspect that
> forcing the date-order will make the resulting pack a lot worse by
> robbing the data stream of locality).

We're migrating some svn repositories to git. The use case is to replace 
mentions of svn revisions in commit messages by the corresponding commit 
hash. Therefore, the commits must be ordered by svn revision number, 
which is not guaranteed for commits on different branches with 
--topo-order.


Regards
felix
