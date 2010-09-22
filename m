From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git log broken?
Date: Wed, 22 Sep 2010 10:15:23 +0200
Message-ID: <4C99BB1B.90101@drmicha.warpmail.net>
References: <20100922094808.07be1757@explosive.nyblom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Torgny Nyblom <kde@nyblom.org>
X-From: git-owner@vger.kernel.org Wed Sep 22 10:15:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyKUA-0003xi-4u
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 10:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665Ab0IVIPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 04:15:18 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53610 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751187Ab0IVIPQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Sep 2010 04:15:16 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 13FCE3C4;
	Wed, 22 Sep 2010 04:15:16 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 22 Sep 2010 04:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Q9yUg4uHBe+7TKRsPltuzL1JJyQ=; b=OxQtZvxCwH7Ap3NgUwJIz2UJNwj2czVd5d9XXdLUADQGXU08znafOI7JgbSXjRWyd59BmzOa/a7iXtVKAkzVP9SDUAwBwKCkCyQuvHOn+IOZ9fKpQ7n89S7i2QkPVHz6XzlnSJjORp7EsK2A9PXw0QWyeLUAcq4uJsV32OX1QQ8=
X-Sasl-enc: sehq0gRRWcWyfNSdOHJOVw67VtGm9UYSrIe085Ol/8GW 1285143315
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7E1E6400903;
	Wed, 22 Sep 2010 04:15:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100907 Fedora/3.1.3-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <20100922094808.07be1757@explosive.nyblom.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156791>

Torgny Nyblom venit, vidit, dixit 22.09.2010 09:48:
> Hi,
> 
> (Resend as it got no replies and I want to be sure that is wasn't lost
> in the noise)
> 
> I'm working on converting the KDE subversion repository to git, as
> a part of this I'm trying to validate that the conversion hasn't missed
> any revisions or merges but when I run "git log" with different options
> I get (in my mind) strange results.
> 
> git log <file> -> produces a list of commits
> git log --follow <file> -> produces an empty list (no output)
> git log --name-status <file> -> no info about file
> 
> It seems like this occurs when there is a merge only commit as the
> first commit in the list returned by the "bare" log command.
> 
> Is there any legit situation where this might happen?
> If so what?
> If not is this a bug in my convert program or in git?

Can you share this repo or (even better) create a minimal test which
reproduces this?

Trying with a recent git and "some" merge commit I don't see that behaviour.

Note that, e.g., subversion needs to create commits for each tag which
git-svn turns into "no-op" commits (introducing no diff). They can
disappear easily if your conversion process involves rebasing or
filter-branching. (I'd recommend converting those commits into annotated
tags.)

Michael
