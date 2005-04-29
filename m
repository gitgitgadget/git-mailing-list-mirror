From: Kevin Smith <yarcs@qualitycode.com>
Subject: Signed commit vulnerabilities? (was: Mercurial 0.4b vs git patchbomb
 benchmark)
Date: Fri, 29 Apr 2005 16:29:24 -0400
Message-ID: <42729924.6090308@qualitycode.com>
References: <200504291954.MAA27561@emf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 22:28:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRc6B-0007Kj-Br
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 22:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbVD2UdW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 16:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbVD2Uao
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 16:30:44 -0400
Received: from deuterium.rootr.net ([203.194.209.160]:65041 "EHLO
	vulcan.rootr.net") by vger.kernel.org with ESMTP id S262963AbVD2U3o
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 16:29:44 -0400
Received: from [10.10.10.20] (147-49.35-65.tampabay.res.rr.com [65.35.49.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vulcan.rootr.net (Postfix) with ESMTP id 2457C3C2A;
	Fri, 29 Apr 2005 20:29:26 +0000 (UTC)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
To: Tom Lord <lord@emf.net>
In-Reply-To: <200504291954.MAA27561@emf.net>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Tom Lord wrote:
>   > Call me a naive git, but seems to me the "git way" is a little
>   > different. It's tree-based rather than diff-based, and doesn't involve
>   > passing diffs around, right?
> 
> Isn't that a significant part of what I said?  Go back and read more
> carefully, is my suggestion.
> 
>   > Or am I missing something?
> 
> Very much so.

So far, this is a frustrating conversation to watch. Here's my own
interpretation, presented to help the participants understand whether or
not their intended messages are getting through clearly.

Originally, Tom seemed to claim that the problem was that git requires
you to sign an entire tree, rather than a diff, even though the signer
is only vouching for their diff.

Linus responded by saying that a git signature of a tree would match
that description, but signing a commit is different. I think he claimed
that (by convention) signing a commit ONLY means you are signing the
most recent change, which turned tree A into tree B.

Tom then appeared to propose some specific attacks that could work
against the git model. The precondition seems to be if the patch
receiver does not exhaustively analyze each and every patch. The
receiver trusts the contents based solely on who signed the commit object.

One category of attacks were that a computer or communication channel
was broken. It's not immediately clear to me how git's model contributes
any weakness to these cases, compared to other signing strategies.

The other category of attack mentioned was social, such as a signer
creating a patch that claims to do one thing, but actually does another.
Again, I don't see how git is weaker in this case than any other tool.

Noel then pointed out that in practice, someone receiving a signed
commit in git would view the commit comments and the diff, so the effect
is similar to having the diff itself be signed.

And that's where we are right now. So, from here, it looks like Tom
needs to be more specific about which attacks might be more effective
against git's signing strategy than against signed diffs.

Kevin
