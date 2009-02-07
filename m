From: "Jan =?UTF-8?B?S3LDvGdlcg==?=" <jk@jk.gs>
Subject: More noise when parsing ref args?
Date: Sat, 7 Feb 2009 16:48:19 +0100
Message-ID: <20090207164819.7150661a@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 07 16:49:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVpRF-0008Mg-It
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 16:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbZBGPsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 10:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752584AbZBGPsX
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 10:48:23 -0500
Received: from zoidberg.org ([88.198.6.61]:50526 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384AbZBGPsW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 10:48:22 -0500
Received: from perceptron (xdsl-78-34-175-56.netcologne.de [::ffff:78.34.175.56])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Sat, 07 Feb 2009 16:49:04 +0100
  id 0042C61D.498DAD70.00005789
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108864>

Good day,

I heard a (quite valid) complaint on IRC about a confusing error
message. The command used was "git show <commit>:foo", where foo was a
working tree file in the CWD (a non-toplevel dir of the repository).
Obviously this couldn't have worked but the error message was the usual
"ambiguous argument" message output by verify_filename(). That message
doesn't really make clear the fact that the commit object was found but
the path wasn't. It's easy for someone with less experience to read the
message as "either the <commit> or the path suffix you gave was wrong".

It would be great adding another message that points out what exactly
went wrong in looking up the object, but that message would then appear
in plumbing. So what's the policy on adding new error messages to
plumbing? If it's a bad idea: I remember that a couple of months ago
some error handling code was changed to allow overloading messages from
porcelain. Can that be extended with a reasonable amount of effort?

-Jan
