From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: can git-describe learn first-parent behavior?
Date: Tue, 21 Sep 2010 11:34:38 +0200
Message-ID: <4C987C2E.3060001@drmicha.warpmail.net>
References: <AANLkTi=6o15y-6Q+tn40=hrPf9pmo+Y1Jd97hGxr5mH2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Joshua Shrader <jshrader83@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 11:34:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxzFH-0007Ug-VB
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 11:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756911Ab0IUJec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 05:34:32 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50626 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756349Ab0IUJeb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Sep 2010 05:34:31 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0A86E4E8;
	Tue, 21 Sep 2010 05:34:31 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 21 Sep 2010 05:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=IBmEGGtUyJ9qlstIEqa0lNUx1fk=; b=QobdXSkZHmnIoP2BULmoJd9MFBPj7HnF6uJoV1bFvZCm0sT4pT0VxDqfQY6kJNbtfCQPFOUZYk19FUip1wOakdpsFfaVdTaex770QarewmAXlq4QNfOezRxwYse2D5aD4v9NcPOA9Z/Qtmu7RJYXlLiNeB1xWbkjrW+H6F1xIj0=
X-Sasl-enc: Ttcnrl8TBW3zKbxWZQbQyp3kTcLbv5hCkOmj7k7rqEVl 1285061670
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 87D38409FB1;
	Tue, 21 Sep 2010 05:34:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100907 Fedora/3.1.3-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <AANLkTi=6o15y-6Q+tn40=hrPf9pmo+Y1Jd97hGxr5mH2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156702>

Joshua Shrader venit, vidit, dixit 21.09.2010 07:58:
> This seems like it would be a rather useful feature.  Suppose a
> maintenance branch, maint/v1.0, is forked from master, and the branch
> point is tagged something like "v1.0-stable".  The next commit on
> master is tagged "v2.0-base", indicating that it is the first commit
> of the new release.  Suppose two releases are made - a release for
> public consumption of version 1.0, and a release for internal testing
> from master (currently 2.0), and we want to embed the output of
> git-describe into the builds.  If bugs were fixed on 1.0, and then 1.0
> was merged into master, it seems perfectly possible to run
> git-describe on master, but get the v1.0 tag in the output.

The earlier tag (in terms of depth) wins, yes.
 
> Is this just a poor workflow?  Am I using git-describe incorrectly?
> Or, does a first-parent option to git-describe seem useful?
> 
> Thanks for the input.

If you know you want to describe HEAD based on v2 tags you can use

git describe --match v2\* --tags HEAD

"git describe" does not use the revision walk machinery so that it does
not have the --first-parent option. I'm not sure how useful that is, but
it's easy to implement.

Michael
