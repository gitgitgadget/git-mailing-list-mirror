From: David Kastrup <dak@gnu.org>
Subject: Creating own hierarchies under $GITDIR/refs ?
Date: Sun, 02 Feb 2014 11:37:39 +0100
Organization: Organization?!?
Message-ID: <87a9e92424.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 02 11:38:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9uRT-0002Ew-Ux
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 11:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbaBBKhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 05:37:55 -0500
Received: from plane.gmane.org ([80.91.229.3]:58431 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989AbaBBKhy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 05:37:54 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1W9uQz-0001wa-Ew
	for git@vger.kernel.org; Sun, 02 Feb 2014 11:37:53 +0100
Received: from x2f40a1f.dyn.telefonica.de ([2.244.10.31])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 11:37:53 +0100
Received: from dak by x2f40a1f.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 11:37:53 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f40a1f.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:kysR3mHxp8/AWmcyutOb1/seyIk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241356>


Hi,

in the context of an ongoing discussion on the Emacs developer list of
converting the Bzr repository of Emacs, one question (with different
approaches) is where to put the information regarding preexisting Bazaar
revision numbers and bug tracker ids: those are not present in the
current Git mirror.

Putting them in the commit messages would require a full history
rewrite, and if some are missed in the process, this cannot be fixed
afterwards.

So I mused: refs/heads contains branches, refs/tags contains tags.  The
respective information would likely easily enough be stored in refs/bzr
and refs/bugs and in that manner would not pollute the "ordinary" tag
and branch spaces, rendering "git tag" and/or "git branch" output mostly
unusable.  I tested creating such a directory and entries and indeed
references like bzr/39005 then worked.

However, cloning from the repository did not copy those directories and
references, so without modification, this scheme would not work for
cloned repositories.

Are there some measures one can take/configure in the parent repository
such that (named or all) additional directories inside of $GITDIR/refs
would get cloned along with the rest?

It would definitely open viable options for dealing with mirrors and/or
repository migrations in general.

-- 
David Kastrup
