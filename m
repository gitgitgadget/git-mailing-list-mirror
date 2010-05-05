From: Adam Monsen <haircut@gmail.com>
Subject: Re: migrating Mifos from svn to git
Date: Wed, 5 May 2010 04:58:45 +0000 (UTC)
Message-ID: <loom.20100505T065133-348@post.gmane.org>
References: <1272751725.21622.57.camel@scraps> <20100502082503.GG92627@acme.spoerlein.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 05 07:05:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9WnK-0006s1-EV
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 07:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842Ab0EEFFH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 May 2010 01:05:07 -0400
Received: from lo.gmane.org ([80.91.229.12]:38283 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626Ab0EEFFG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 01:05:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O9Wn9-0006pY-6H
	for git@vger.kernel.org; Wed, 05 May 2010 07:05:03 +0200
Received: from c-67-183-136-182.hsd1.wa.comcast.net ([67.183.136.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 May 2010 07:05:03 +0200
Received: from haircut by c-67-183-136-182.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 May 2010 07:05:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 67.183.136.182 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3 ( .NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146371>

Ulrich Sp=C3=B6rlein writes:
> svn2git is faster and can cope with multiple branches better, but it =
has
> bugs of its own. Try both of them ...

I did, and--maybe since svn2git appears to be built atop git-svn--they =
both
break at the same point, spouting an error like:

fatal: ambiguous argument
'2f53ad77827c0f1d492c031be4fff20b0d60fffc
^..1a6f5af6bd84cb71f25fb1df1c67de1a9b91ba87':
unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
rev-list
2f53ad77827c0f1d492c031be4fff20b0d60fffc
^..1a6f5af6bd84cb71f25fb1df1c67de1a9b91ba87:
command returned error: 128

Anyway, I gave up trying to import all svn 1.5+ mergeinfo.
Instead, I'm just pulling in our trunk into one repository,
and two release branches into separate repositories. Here's
my in-progress experiment so far:
http://mifos.git.sourceforge.net/git/gitweb-index.cgi .
"head" is what used to be "trunk" in svn.

I started writing up a procedure for our developers here:
http://www.mifos.org/developers/wiki/MifosVersionControlGuide

If anyone wants to perfect that wiki page, I would love the help.

> Yes, if both repos have the same UUID this should be possible. You ne=
ed
> to fudge this in rev 0 and uuid in your svn mirror.

This is helpful. Thank you!
