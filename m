From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] commit: allow partial commits with relative paths
Date: Sat, 30 Jul 2011 19:04:28 +0200
Message-ID: <4E34399C.2080109@drmicha.warpmail.net>
References: <CAOnWdohKfwEOMx=wr_PKiW+ucYBK2ZWykm_7dqr7hy4xGRM02A@mail.gmail.com> <19b908142567fcfafe4da3d0fd60b134d30c613a.1311579663.git.git@drmicha.warpmail.net> <20110729133551.GA8707@toss.lan> <4E343534.8000604@drmicha.warpmail.net> <20110730170045.GA9900@toss.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Reuben Thomas <rrt@sc3d.org>,
	Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Jul 30 19:04:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnCxq-0008Sl-MS
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 19:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216Ab1G3REe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 13:04:34 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:55447 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752101Ab1G3REd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jul 2011 13:04:33 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id EA98D20BD2;
	Sat, 30 Jul 2011 13:04:32 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute5.internal (MEProxy); Sat, 30 Jul 2011 13:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=o+2gzfg12VX2/rc5f7gYeU
	uI2kk=; b=dHqk3ql1qNwIBBmH/vuMKD4BRjU+hR/vvyDiNBttf41XEBMCzeRebY
	+GKmzIN69Puz/17j0ckaBdBf0ChZjWVWvLHjNr6vYI/aqip9ao9pH+eLMUHvDjh2
	slOIds7V49k3fuYA3MuPNWpkQ0phLGQx7TvM5e6EVaI7B0qyD/O5U=
X-Sasl-enc: wPgYvC9HenDJmKTZngsRzIffDvmh/alygeapJ8uEmKfj 1312045472
Received: from localhost.localdomain (p54ACFC54.dip.t-dialin.net [84.172.252.84])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 48740415BCD;
	Sat, 30 Jul 2011 13:04:31 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <20110730170045.GA9900@toss.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178215>

Clemens Buchacher venit, vidit, dixit 30.07.2011 19:00:
> On Sat, Jul 30, 2011 at 06:45:40PM +0200, Michael J Gruber wrote:
>>
>>> With your permission I am stealing your commit message.
>>
>> I don't care about the message but don't see the point of this patch.
>> Using the same message certainly won't explain the difference...
> 
> Well, to be fair I did add to your message, explaining what I did.
> 
> The point of providing a prefix at all is performance optimization.
> If you say there is no common prefix for the files of interest,
> then you cannot leave any files out and you have to read the entire
> tree into the index.
> 
> But even if we cannot use the working directory as a prefix, we can
> still figure out if there is a common prefix for all given paths,
> and use that instead. I merely copied that idea from ls-tree.
> 

That's the kind of explanation that I meant. Thanks.

Michael

> And considering that most of my patch the almost verbatim move of a
> function from one file to another, I think my change is not that
> big:
> 
>>>  4 files changed, 39 insertions(+), 38 deletions(-)
> 
> Clemens
