From: "Chris West (Faux)" <faux@goeswhere.com>
Subject: Re: Suggestion on hashing
Date: Tue, 6 Dec 2011 01:56:17 +0000 (GMT)
Message-ID: <alpine.DEB.2.00.1112060146121.15104@hoki.goeswhere.com>
References: <1322813319.4340.109.camel@yos> <CACsJy8CO1GtpZVo-oA2eKbQadsXYBEKVLfUH0GONR5jovuvH+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Bill Zaumen <bill.zaumen@gmail.com>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 03:03:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXkNQ-0000XD-NR
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 03:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932835Ab1LFCDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 21:03:19 -0500
Received: from goeswhere.com ([89.16.166.7]:39045 "EHLO hoki.goeswhere.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932817Ab1LFCDT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 21:03:19 -0500
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Dec 2011 21:03:18 EST
Received: by hoki.goeswhere.com (Postfix, from userid 1000)
	id 9B8A21040CE; Tue,  6 Dec 2011 01:56:17 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by hoki.goeswhere.com (Postfix) with ESMTP id 9744F104090;
	Tue,  6 Dec 2011 01:56:17 +0000 (GMT)
In-Reply-To: <CACsJy8CO1GtpZVo-oA2eKbQadsXYBEKVLfUH0GONR5jovuvH+Q@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186307>


Nguyen Thai Ngoc Duy wrote:
> SHA-1 charateristics (like 20 byte length) are hard coded everywhere
> in git, it'd be a big audit.

I was planning to look at this anyway.  My branch[1] allows
  init/add/commit with SHA-256, SHA-512 and all the SHA-3 candidates.

log/fsck/etc. are all broken.  Don't even dare try packs.  Fixing things
  is painful but not impossible.  I'm not convinced the task is even
  remotely insurmountable.

(This is not a request-for-comments, just an informational notification.
  It does not even attempt to address compatability or the like.)

$ make HASH=sha512 -j6
$ PATH=bin-wrappers:..
$ git init && echo hi > foo && git add foo && git commit -m "bang"
Initialized empty Git repository in /.../.git/
[master (root-commit) 
8d3ae658dff0c6e398bb4a0d193974e49acfadedfcd61daca42c931ac18d5ac46f0a068e08d81c25d7b79b1c3f4951e4340eeb90f0ef39de355c9bab7e75faba] 
bang
  1 files changed, 1 insertions(+), 0 deletions(-)
    create mode 100644 foo


1. (Please use the hash-v0.0.1 tag, I rebase.)
   gitweb: http://preview.tinyurl.com/bsufh92
   git://git.goeswhere.com/git/git.git
   https://github.com/FauxFaux/git/tree/hash-v0.0.1

---
Chris West (Faux)
Freenode #git: FauxFaux
https://ssl.goeswhere.com/key-transition-2011-10-10.txt.asc
gpg: 408A E4F1 4EA7 33EF 1265  82C1 B195 E1C4 779B A9B2
