From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: equal-tree-merges as way to make rebases fast-forward-able
Date: Mon, 30 Nov 2009 16:35:57 +0100
Message-ID: <4B13E65D.3050504@drmicha.warpmail.net>
References: <cover.1259524136.git.brlink@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bernhard R. Link" <brlink@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 30 16:37:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF8JQ-0004Qr-PC
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 16:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbZK3PhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 10:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbZK3PhF
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 10:37:05 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:51842 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752466AbZK3PhE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 10:37:04 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 72787C5711;
	Mon, 30 Nov 2009 10:37:09 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 30 Nov 2009 10:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=oQC0KQA6DKpmB09vNx0DNBYVwD8=; b=SQHxN49+kFNmSK/5hzdVa1SYWo9pUKvGNVq3RhVjSvkzwW0pe+bEXmPKViCueB7pWOjb6NafDx3dpa1rcAL4x9J2plrYhUQOV3HaJjcEIA6FyhtRA+yXZiiz2xYLhMtF3zDMwkZAkBEXyYjilRh/BVexyX2/3Xcnm48qBCrScKE=
X-Sasl-enc: h8s4nEA1rnnjuti92BY8XAqUWqf3YNgfpWqTEoN2ttDD 1259595429
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9E8801A6A6;
	Mon, 30 Nov 2009 10:37:08 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091127 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <cover.1259524136.git.brlink@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134113>

Bernhard R. Link venit, vidit, dixit 30.11.2009 15:43:
> The itch this idea is supposed to scratch is the problem that a rebase
> or a amended commit is no longer a fast-forward, so cannot be easily
> pulled.

Do you mean pushed?
For pull, the state of the branch on the receiving side play a role, of
course.

> While this is not a problem in most workflows, as one can either merge
> or keep everything private and rebase until published, it would be nice
> to have a way for cases in between, where both a clean presentable
> commit order is to be maintained and people (or yourself from different
> repositories) should be able to easily upgrade to newer versions without
> an error-prone not-fast-forward.
> 
> My idea to solve this is combining both histories, the rebased/revised
> history and the actualy history, marking with some "equal-tree-merge"
> the point where they have the same result.
> The following mails show some patches to implement this by means of
> a merge where all parents have the same tree and some special casing
> when encountering such a thing. This has the advantage that older git
> version will just see strange merges and may present both histories,
> but otherwise just work.

Without having the time to go through the detailed setup you described
below (sorry), I'm wondering how this differs from what Git calls a
trivial merge? Is it merely about asserting that you merge coinciding
(heads with) trees?

Michael
