From: David Ripton <dripton@ripton.net>
Subject: Re: How to handle a git repository with multiple branches
Date: Thu, 26 Aug 2010 17:17:42 -0400
Message-ID: <4C76D9F6.7070306@ripton.net>
References: <AANLkTimW-SQi1eprxTPXxF85SBO4d5MU13=dsboNNrzd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 23:18:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oojq3-0004Fb-N0
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 23:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103Ab0HZVST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 17:18:19 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:55938 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751Ab0HZVSR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 17:18:17 -0400
Received: from homiemail-a50.g.dreamhost.com (caibbdcaaaaf.dreamhost.com [208.113.200.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 6F3C0179423
	for <git@vger.kernel.org>; Thu, 26 Aug 2010 14:18:17 -0700 (PDT)
Received: from homiemail-a50.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a50.g.dreamhost.com (Postfix) with ESMTP id D52AC6F8065;
	Thu, 26 Aug 2010 14:17:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=ripton.net; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=ripton.net; b=
	mMCQHqsrk2y3fYmvTUMCI5VYW/SqpN3p+zZ037L2loL1XrmQ3nB2DNIci3uCwpvP
	6IOiapDK0P0G7J0e+V7En2D978QZyD1GnDxh1JiiIjsY5e3XCZX1rDd7AzCa+/eo
	P2NcolltLLA0xy1aPr62dbvsfM7tefmw0F98cEbp/hk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=ripton.net; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=ripton.net; bh=LFNkDZ
	NtcbLsKXF0/0Cad13pDQg=; b=bIp/7shH5svsA5KX7R+OmfMj1SHlMU39dPgOb1
	krSFQK7H0FFhb1CwAlaSWgVzlCeamLrWjBYBRijerOsFnzTELB/3w6LyMmphdcu8
	tv9uAcC+e6M8hqtQa6Pc4ST7gnffKHlTyOzXLDq1PUzZRLSoh/km+Q7iBwnc/KE7
	cjrxY=
Received: from [192.168.2.175] (pool-98-118-245-254.clppva.fios.verizon.net [98.118.245.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: dripton@ripton.net)
	by homiemail-a50.g.dreamhost.com (Postfix) with ESMTPSA id 7B5E06F8062;
	Thu, 26 Aug 2010 14:17:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.8) Gecko/20100808 Lightning/1.0b2pre Thunderbird/3.1.2
In-Reply-To: <AANLkTimW-SQi1eprxTPXxF85SBO4d5MU13=dsboNNrzd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154563>

On 08/26/10 07:53, Erez Zilber wrote:

> Some commits are relevant only for branch_1, some are relevant only
> for branch_2 and some are relevant for both. For the commits that are
> relevant for both branches, I thought about the following solutions:
> 1. Put these common commits in branch_1 and merge branch_1 into
> branch_2. This is bad because it will also merge commits that are
> relevant only for branch_1.
> 2. Cherry-pick the common commits from branch_1 to branch_2. This is
> also bad because the commit ID changes, and in case of conflicts, git
> is unable to tell that these 2 commits are actually the same commit.
> This makes it very difficult to track the changes between branches.
>
> Since there are several other developers and sub-maintainers in this
> project which are rebased on both these branches, I don't want to
> change the git history of my branches because when I do that,
> sub-maintainers and developers lose the reference to their base.
>
> I'm looking for a better solution. Is there any best-practice solution?

Fix bugs in the oldest release branch to which the fix applies.  Then 
merge the old branches into the new ones.

When this doesn't work, then you have to cherry pick.

-- 
David Ripton    dripton@ripton.net
