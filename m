From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] check-ignore: clarify treatment of tracked files
Date: Mon, 08 Dec 2014 17:13:08 +0100
Message-ID: <5485CE14.3080207@drmicha.warpmail.net>
References: <5480777D.6000205@drmicha.warpmail.net>	<fbc5799c32357e8bff0c690ba7bc4cd46374684d.1417706481.git.git@drmicha.warpmail.net> <xmqqzjb3rx1u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Guilherme <guibufolo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 17:13:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy0w0-0004y1-6q
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbaLHQNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:13:12 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45091 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750908AbaLHQNL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2014 11:13:11 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 92A5C207C1
	for <git@vger.kernel.org>; Mon,  8 Dec 2014 11:13:10 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 08 Dec 2014 11:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=nyHSMnHyhb8CC6ILJ1gM9v
	6jNKs=; b=d6doccrw8g8IDxo7bkT4nOtqa2L3DZkkYaY3M3MCURFm2d11MzPq2c
	Pnmwhb66z4iUwkhJPDyZrW8iaJo2whFR9oJhVx9NWv8Q5WAYe2yjs+owe1/9QPur
	3KD3l3iR+K1qrZlxAg6gof7j48zs2M7P1XehLSTjCBN2PBI6gpeDo=
X-Sasl-enc: xTGWUXdERVaePToWoi8awYc+DYsQvFA2NqrpLxb7OZF8 1418055190
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id D5966C0027F;
	Mon,  8 Dec 2014 11:13:09 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <xmqqzjb3rx1u.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261052>

Junio C Hamano schrieb am 04.12.2014 um 21:15:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> By default, check-ignore does not list tracked files at all since
>> they are not subject to ignore patterns.
>>
>> Make this clearer in the man page.
>>
>> Reported-by: Guilherme <guibufolo@gmail.com>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> That really is a bit confusing. Does this help?
> 
> Thanks.
> 
> "git check-ignore" is a tool to debug your .gitignore settings when
> your expectation does not match the reality, so having this new
> sentence here is a good thing to do, but I wonder if there is a more
> prominent and central place where people learn about the ignore
> mechanism the first place.  If we had this sentence there, too, that
> may reduce the need to debug their .gitignore settings in the first
> place.
> 
> Perhaps Documentation/gitignore.txt?  Documentation/user-manual.txt?

gitignore.txt has

DESCRIPTION
       A gitignore file specifies intentionally untracked files that Git
should ignore. Files already tracked by Git are not affected; see the
       NOTES below for details.

I doesn't get any clearer. But then the notes read:

NOTES
       The purpose of gitignore files is to ensure that certain files
not tracked by Git remain untracked.

       To ignore uncommitted changes in a file that is already tracked,
use git update-index --assume-unchanged.

       To stop tracking a file that is currently tracked, use git rm
--cached.

That is again clear for our case (line 1), but line 2 is troublesome,
isn't it?

user-manual mainly refers to gitignore. So I guess it's good, but that
line about assume-unchanged doesn't quite match with the discussion in
another current thread.

Michael
