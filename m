From: Mike Hommey <mh@glandium.org>
Subject: Getting a commit sha1 from fast-import in a remote-helper
Date: Tue, 18 Nov 2014 09:34:26 +0900
Message-ID: <20141118003426.GA6528@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 18 01:51:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqX1H-0007fI-UH
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 01:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbaKRAvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 19:51:44 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:45947 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155AbaKRAvn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 19:51:43 -0500
X-Greylist: delayed 1031 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Nov 2014 19:51:42 EST
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1XqWkU-0001tM-Fs
	for git@vger.kernel.org; Tue, 18 Nov 2014 09:34:26 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

For some reason, I need to know the sha1 corresponding to some marks
I'm putting in a fast-import stream. Unfortunately, this does not appear
to be possible.
- I'd rather not require a checkpoint to export marks each time I need
  such a sha1, and I'd rather not do that work that requires them after
  all the marks have been created (although currently, I'm forced to).
- fast-import's cat-blob only allows to cat blobs, which, well, is kind
  of in its name; how about adding an equivalent to the git-cat-file
  command?
- fast-import's `ls` command documentation about its output format
  mentions that the output may contain commits, so I tried the trick of
  creating a tree with commits, but fast-import then fails with:
    fatal: Not a blob (actually a commit)
  which I totally understand, but then I wonder why the documentation
  mentions it and how one would get a tree containing references to
  commits. I guess the documentation should be fixed.

So, while there's a possible solution with an equivalent to the
git-cat-file command if that'd be accepted, that's also overkill for my
need, which is to simply get the sha1 corresponding to a mark. Would you
consider a patch adding a command that allows such a resolution?

Cheers,

Mike
