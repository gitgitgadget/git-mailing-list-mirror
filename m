From: tom fogal <tfogal@sci.utah.edu>
Subject: manual http authorization (no netrc)
Date: Thu, 06 Jan 2011 10:20:59 -0700
Message-ID: <auto-000024252997@sci.utah.edu>
Reply-To: tfogal@sci.utah.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 06 18:52:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pau0U-0002Sw-HF
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 18:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315Ab1AFRwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 12:52:07 -0500
Received: from mail.sci.utah.edu ([155.98.58.80]:20570 "EHLO sci.utah.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751176Ab1AFRwG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 12:52:06 -0500
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Jan 2011 12:52:06 EST
Received: from dummy.name; Thu, 06 Jan 2011 10:22:03 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164649>

I'm getting authorization errors when I lack a .netrc for an http-based
server.  Specifically:

  tf@shigeru tmp $ git clone http://myhost:port/git/io.git
  Cloning into io...
  Username:
  Password:
  error: The requested URL returned error: 401 (curl_result = 22, http_code =
  401, sha1 = 9c201da4d64e2fd178935b9ebbd6e110a97578d4)
  error: Unable to find 9c201da4d64e2fd178935b9ebbd6e110a97578d4 under
  http://shigeru.sci.utah.edu:1234/git/io.git
  Cannot obtain needed blob 9c201da4d64e2fd178935b9ebbd6e110a97578d4
  while processing commit b1853d6f6a54cf22e259a75f77770eef53b8cb38.
  error: Fetch failed.

I did try multiple times; the username/password combo is correct :)

A friend of mine is also experiencing the same problem.  The server is
running git 1.5.6.5; my client is 1.7.3.4, and I'm not sure what the
other party's is, but it's likely to be recent.

Everything works fine if we just create a ~/.netrc and set things up
appropriately. `curl-config --version' says "libcurl 7.18.2" on my
workstation.

What have we configured incorrectly?

-tom
