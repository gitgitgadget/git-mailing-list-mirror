From: Mike Hommey <mh@glandium.org>
Subject: Allowing push --dry-run through fetch url
Date: Fri, 6 Nov 2009 08:37:07 +0100
Message-ID: <20091106073707.GA14881@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 08:37:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6JNz-0006kv-Ft
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 08:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791AbZKFHhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 02:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbZKFHhU
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 02:37:20 -0500
Received: from vuizook.err.no ([85.19.221.46]:51694 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850AbZKFHhT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 02:37:19 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1N6JNo-0000ff-9h
	for git@vger.kernel.org; Fri, 06 Nov 2009 08:37:22 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1N6JNb-0003zj-Ts
	for git@vger.kernel.org; Fri, 06 Nov 2009 08:37:07 +0100
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132279>

Hi,

I am currently considering, when I'll get some time, to dive in the git
push code to allow push --dry-run without the rights to push.

We currently have two remote configuration items for urls:
remote.<name>.url and remote.<name>.pushurl. The latter is used when
pushing and the former when pulling/fetching.

The typical use of both at the same time is to put an authenticated
value for pushurl (ssh://, for example) and an anonymous one (git://,
for example) for url.

What has been annoying me lately is that git push --dry-run asks me
for the ssh key or password. I know I could be using an ssh-agent, but
that's not the point.

It would be interesting, to me at least, that git push --dry-run can do
its job through the git:// url instead of the ssh:// one. But for now,
all that does is telling me:
fatal: The remote end hung up unexpectedly
(probably because the git server doesn't allow pushes at all)

So, before I dive in, what would you think about such a feature?

There is one thing that bothers me, though, it's that --dry-run would,
in the end, not really be a dry-run anymore, and, for example, could
not be used to validate that the ssh setup is good without actually
pushing.

Cheers,

Mike
