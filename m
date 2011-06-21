From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: corrupted Git repository
Date: Tue, 21 Jun 2011 11:38:10 +0200
Message-ID: <4E006682.80101@drmicha.warpmail.net>
References: <BANLkTi=A=DpyfNwEeSd6N6ibCsA5qh_NPQ@mail.gmail.com>	<4E005404.5010901@drmicha.warpmail.net> <BANLkTi=WVTGcGkUXjkuPYcxhMY0a5KPB7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kasra Khosoussi <kasra.mail@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 11:38:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYxPZ-0000jA-74
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 11:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756116Ab1FUJiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 05:38:13 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:46904 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756014Ab1FUJiM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2011 05:38:12 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 276B220CB3;
	Tue, 21 Jun 2011 05:38:12 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 21 Jun 2011 05:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=1t+jMwW38jv7cJ1XzXtDKs5QRPs=; b=A1mPuA7IVxUnMBVMqW75GUmB3Sx9f4sZer6WX1jqMALGgiQNW2zpYrZk68cDG0AtTVUHY4ZvzVPZLa70J0/E8jieLjUpbLH6zzbpbnkppnMxfDQK6HxY6v4lQcBT8CEVkzSeDC9z3a3/hb7vkd04dA2EOKybUJXvG7NOjxABuN8=
X-Sasl-enc: Zx+2JCgRIgxBbxMSQHd9fj1CuwP7eiMPZ5tdgs8hfvoF 1308649091
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A132644B639;
	Tue, 21 Jun 2011 05:38:11 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <BANLkTi=WVTGcGkUXjkuPYcxhMY0a5KPB7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176134>

Kasra Khosoussi venit, vidit, dixit 21.06.2011 11:30:
>> Backup now!
>> I guess you've done that meanwhile anyways, but it's important before
>> any recovery attempts.
> 
> Yes, I've done that.
> 
>> Is your reflog OK, i.e. do you get proper output from "git reflog" or
>> "git log -g"?
> 
> No. Before moving the corrupted object git reflog would return:
> fatal: object 0a83757505387aacc2fd36b3c996729e6bf9d6e5 is corrupted
> 
> and after moving the file it would say:
> fatal: bad object HEAD

Oh yes, stupid me, sorry. "git reflog" tries to parse HEAD. But you can
look at the file directly:

tail .git/logs/HEAD
tail .git/logs/refs/heads/master

etc. show you what's been going on with those refs lately.

You should be able to pick the the sha1 before the corrupt one from that
and do things like "git log that_sha1" if only the most recent commit is
corrupt.

Michael
