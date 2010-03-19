From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: merge only some of the changed files?
Date: Fri, 19 Mar 2010 14:55:42 +0100
Message-ID: <4BA3825E.1070700@drmicha.warpmail.net>
References: <20100319134028.GA2318@comppasch2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: fkater@googlemail.com
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 19 14:58:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nscih-0000jq-KP
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 14:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539Ab0CSN6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 09:58:30 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:45845 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752486Ab0CSN6a (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 09:58:30 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 82A0AE6863;
	Fri, 19 Mar 2010 09:58:29 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 19 Mar 2010 09:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=/5EbaqK9yocSRRf9xo0PAmbt9AY=; b=ool5VlC1j3ehB2inFScM8ewOc8o6W8EBBYQl7eO3Vt5fYQwIhpt1ij8XCsPZRmdZqYsnS8zLMlX/YHMcvYwF7+WAuOfc+z0MmG9XfN66yL5pmZpeI1b7XOqZkQBVXGUiYktHxz6ZIQQTB17RrxFoyrKA8kfbcnDxJQ3XMJnok7g=
X-Sasl-enc: nxzU+yAwN+efH/SKRuc0CAbYn4Ut+gEqAvqiLNFc0fhR 1269007108
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 99A2127EAA;
	Fri, 19 Mar 2010 09:58:28 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <20100319134028.GA2318@comppasch2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142593>

fkater@googlemail.com venit, vidit, dixit 19.03.2010 14:40:
> Hi all,
> 
> I am quite new to git.
> 
> If I want to merge branch B into A, however not all of the
> changed files in B, how do I do that?
> 
> In other words: 'git diff --name-only A..B' lists 10 files
> but I want to merge only 5 of them.

If you are sure you don't want to merge the changes to them later on,
you can do the following while on branch A

# perform the merge but do not commit
git merge --no-commit B
# overwrite the files you want to keep with their version from A
git checkout HEAD -- file1 file2
# commit the merge result
git commit

Cheers,
Michael
