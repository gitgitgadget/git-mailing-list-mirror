From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 4/7] merge,tag: describe -m just like commit
Date: Tue, 15 Feb 2011 08:08:43 +0100
Message-ID: <4D5A267B.7070902@drmicha.warpmail.net>
References: <cover.1297695910.git.git@drmicha.warpmail.net> <5d55b72b16f3d2def5fa955862fe5be6ff9f82f7.1297695910.git.git@drmicha.warpmail.net> <7v4o86s7km.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 08:11:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpF4k-0000Ka-6w
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 08:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254Ab1BOHLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 02:11:50 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55992 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752651Ab1BOHLs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 02:11:48 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7350A208D2;
	Tue, 15 Feb 2011 02:11:48 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 15 Feb 2011 02:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=rGZdMSCQSyNtLhsI0pwai04nCiU=; b=Xdd6vRkqaWGnH2t3/rc+EP/vRsuyCkBwwCyfd6Ptw858XkncxunhLN9nNU61ZqOK7/vn3flCNYx6u8qE414z/aa5ayAnaowlHZDK4mnlhUP8DPo8Kd6w/MNNUjb1HMkdJBQE2nZKK10JjKBWsuaCHCSOvth9mg1jU2Ri/3ryBS4=
X-Sasl-enc: zj1kr4QQpCFMn+J1TWpKtjBosUMzCVnu+sHqrU6xTIDa 1297753908
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 027DF44043A;
	Tue, 15 Feb 2011 02:11:47 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <7v4o86s7km.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166819>

Junio C Hamano venit, vidit, dixit 14.02.2011 21:08:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> This also removes the misleading "if any" which sounds as if omitting
>> "-m" would omit the commmit message. (It meant to mean "if a merge
>> commit is created at all".)
> 
> Hmph, then don't we want to keep that in your clearer form, i.e.
> 
> 	specify merge commit message (if a merge is created at all)

Well, any option is effective only in the case when the command succeeds
- "commit -m msg" specifies only a message when a commit is created at
all, etc. So, it usually is a trivial remark. It is slightly different
for merge because merge may succeed by doing a fast-forward without
creating a merge commit, which is why I wrote "merge commit message".
So, the parenthetical remark would have to be "if a non-ff merge commit
is created". I'm afraid "merge created" alone would not convey this.

> An option is by definition to _specify_ something, "specify" is a waste of
> space in a description of an option.  E.g. in patch 3/7, --template option
> is described as "directory from which templates will be used", and not
> "specify the directory from which...".

Oh yes, I tried to refrain from mixing other clean-up tasks with the
unifying series, especially in the absence of (my knowledge about) an
option "style guide". If "--foo bar" specifies that "bar" is used as
"baz" then saying "--foo <BAR>: baz" is enough and c/should be the
general rule. I'd be happy to incorporate this.

Michael
