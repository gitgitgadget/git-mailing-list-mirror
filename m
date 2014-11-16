From: Patrick Schleizer <patrick-mailinglists@whonix.org>
Subject: How safe are signed git tags? Only as safe as SHA-1 or somehow safer?
Date: Sun, 16 Nov 2014 15:31:10 +0000
Message-ID: <5468C33E.2080108@whonix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: mikegerwitz@gnu.org
To: git@vger.kernel.org, whonix-devel@whonix.org
X-From: git-owner@vger.kernel.org Sun Nov 16 16:37:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xq1tP-0004BA-HC
	for gcvg-git-2@plane.gmane.org; Sun, 16 Nov 2014 16:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755386AbaKPPhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2014 10:37:22 -0500
Received: from whonix.org ([92.243.7.197]:57742 "EHLO whonix.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755359AbaKPPhV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2014 10:37:21 -0500
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Nov 2014 10:37:21 EST
Received: from 127.0.0.1 (unknown [5.249.146.247])
	by whonix.org (Postfix) with ESMTPSA id D266C6F51;
	Sun, 16 Nov 2014 16:31:14 +0100 (CET)
X-Forwarded-Message-Id: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

How safe are signed git tags? Especially because git uses SHA-1. There
is contradictory information around.

So if one verifies a git tag (`git tag -v tagname`), then `checksout`s
the tag, and checks that `git status` reports no untracked/modified
files, without further manually auditing the code, how secure is this
actually? Is it only as safe as SHA-1?

Let's assume an adversary, that is capable of producing SHA-1 collisions.

Linus Torvalds said: [1]

> Git uses SHA-1 not for security

And goes on.

> The security parts are elsewhere

Could you please elaborate on this? Where are the security parts? Can
you please briefly explain how these work? Where can I read more about this?

Wikipedia says. [2]

> Nonetheless, without second preimage resistance [3] of SHA-1 signed
commits and tags would no longer secure the state of the repository as
they only sign the root of a Merkle tree [4].

Which contradicts what Linus Torvalds said. What does that mean for
security? Which statement is true?

> "The source control management system Git uses SHA-1 not for security
but for ensuring that the data has not changed due to accidental
corruption. Linus Torvalds has said, "If you have disk corruption, if
you have DRAM corruption, if you have any kind of problems at all, Git
will notice them. It's not a question of if, it's a guarantee. You can
have people who try to be malicious. They won't succeed. [...] Nobody
has been able to break SHA-1, but the point is the SHA-1, as far as Git
is concerned, isn't even a security feature. It's purely a consistency
check. The security parts are elsewhere, so a lot of people assume that
since Git uses SHA-1 and SHA-1 is used for cryptographically secure
stuff, they think that, OK, it's a huge security feature. It has nothing
at all to do with security, it's just the best hash you can get. [...] I
guarantee you, if you put your data in Git, you can trust the fact that
five years later, after it was converted from your hard disk to DVD to
whatever new technology and you copied it along, five years later you
can verify that the data you get back out is the exact same data you put
in. [...] One of the reasons I care is for the kernel, we had a break in
on one of the BitKeeper sites where people tried to corrupt the kernel
source code repositories." [6]

If (!) I understand Mike Gerwitz ([...] GNU [...]) 's opinion, his
opinion is, that for best security each and every commit should be
signed for best possible git verification security.

See also:

- Mike Gerwitz's "A Git Horror Story: Repository Integrity With Signed
Commits" [7]

- Verbose reply by Mike Gerwitz to my question. [8]

- Similar question on security stackexchange. [9] Quote: "Nevertheless,
If somebody managed to find a way how to find SHA1 collisions easily,
then git would have much bigger problem."

Cheers,
Patrick

[1] https://www.youtube.com/watch?v=4XpnKHJAok8&t=56m20s
[2] https://en.wikipedia.org/wiki/SHA-1#Data_integrity
[3] https://en.wikipedia.org/wiki/Second_preimage_resistance
[4] https://en.wikipedia.org/wiki/Merkle_tree
[5] https://www.youtube.com/watch?v=4XpnKHJAok8&t=56m20s
[6] https://en.wikipedia.org/wiki/SHA-1#Data_integrity
[7] http://mikegerwitz.com/papers/git-horror-story
[8] https://www.whonix.org/forum/index.php/topic,538.msg4278.html#msg4278
[9]
https://security.stackexchange.com/questions/67920/how-safe-are-signed-git-tags-only-as-safe-as-sha-1-or-somehow-safer
