From: =?UTF-8?Q?Daniel?= <mjucde@o2.pl>
Subject: =?UTF-8?Q?Re:_git_log_-S_not_finding_all_commits=3F?=
Date: Thu, 08 Oct 2009 13:07:13 +0200
Message-ID: <362436ca.6b5d0fc3.4acdc7e1.41b23@o2.pl>
References: <7ae12651.522df17b.4acda0f5.21a31@o2.pl> <4ACDACE6.9060509@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Andreas_Ericsson?= <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 08 13:09:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mvqs3-0008Pk-2m
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 13:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757184AbZJHLHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 07:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754423AbZJHLHx
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 07:07:53 -0400
Received: from mailout1.go2.pl ([193.17.41.11]:58539 "EHLO mailout1.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756594AbZJHLHx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2009 07:07:53 -0400
Received: from mailout1.go2.pl (unknown [10.0.0.103])
	by mailout1.go2.pl (Postfix) with ESMTP id 5EF175D516D;
	Thu,  8 Oct 2009 13:07:14 +0200 (CEST)
Received: from o2.pl (unknown [10.0.0.76])
	by mailout1.go2.pl (Postfix) with SMTP;
	Thu,  8 Oct 2009 13:07:14 +0200 (CEST)
In-Reply-To: <4ACDACE6.9060509@op5.se>
X-Originator: 153.19.128.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129686>

Andreas Ericsson <ae@op5.se> wrote:

> Yes, it's the correct behaviour. -S finds only lines where what you search
> for was added or deleted. It counts the number of occurrences of what you
> specify in each resulting tree and only shows the commits where that number
> changed. In your case, searching for "Free data " would have printed both
> commits, since you first introduce that entire string and then remove it.

Thanks. However, your suggestion doesn't work. It prints only commit 2. Maybe
you meant:

$ PAGER=cat git log --pickaxe-regex -S'Free data$' --oneline

but that doesn't solve my problem. I want to find all commits which changed
lines containing "Free data" (the example I posted is simplified).

Seems I have to use "git log -p" and search its output using pager...

-- 
Daniel
