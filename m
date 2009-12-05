From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: rev-parse --show-cdup in .git
Date: Sat, 05 Dec 2009 14:19:07 +0100
Message-ID: <4B1A5DCB.7020903@drmicha.warpmail.net>
References: <4B192EAE.8000806@drmicha.warpmail.net> <7vhbs6skzi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 14:19:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGuXf-00047c-IE
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 14:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755089AbZLENTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 08:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754994AbZLENTH
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 08:19:07 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33596 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754718AbZLENTH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Dec 2009 08:19:07 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 86115C5FCD;
	Sat,  5 Dec 2009 08:19:12 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Sat, 05 Dec 2009 08:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=8sv8PQiG/FXJZec7/4Ix3cpmWYU=; b=POWi7GHr1cRxprBtAhRAwKQlTK7zr8WRiJdgRLXM69afRxErZMjUJrw8TrzXyOZAID4C+rdBoEPlu5iCPRnnHE4Bqaf2VtKgfkK7vzTy6pM8BpxGPajRdFHzZwzZa/BynXDL2UGPOk5NvmxwJmcJiOF4N4IvD2d98zly3ZOL0tY=
X-Sasl-enc: Xy7uoXhpWzFTOUQ5BAW0N1Bu3OBhJmsAAld/jeKjh8tD 1260019152
Received: from localhost.localdomain (p5DCC0D75.dip0.t-ipconnect.de [93.204.13.117])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D64193FE2;
	Sat,  5 Dec 2009 08:19:11 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091204 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <7vhbs6skzi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134600>

Junio C Hamano venit, vidit, dixit 04.12.2009 18:32:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> I'm sure this was discussed somewhere, but I can't find it:
>>
>> When called from within .git, git rev-parse --show-cdup returns nothing
>> rather than "..", not even an error code. Is this intended?
> 
> I do not think --show-cdup should be linked to --is-inside-work-tree in
> any way, if that is what you are getting at by mentioning "error code".

It's just difficult to tell from the output whether you are at the
toplevel (empty relative path) or you're within .git or somewhere else.

>> This is all the more disturbing since the cwd of hooks seems to be
>> GIT_DIR. Is that something one can rely upon? In that case one can
>> simply use ".." for cdup.
> 
> I think you will see something that is different from and is more sensible
> than ".." when you use GIT_WORK_TREE environment variable (or its
> corresponding configuration variable).

All that I want is a reliable method for a hook to cd to the toplevel of
the worktree of a non-bare repositity. cd_to_toplevel (from
git-sh-setup) does not work. I don't think I should have to set any
worktree config in a non-bare repository with standard layout, should I?

Michael
