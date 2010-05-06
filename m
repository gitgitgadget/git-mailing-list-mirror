From: Eli Barzilay <eli@barzilay.org>
Subject: Feature request: relative paths
Date: Thu, 6 May 2010 02:01:06 -0400
Message-ID: <19426.23330.525936.981066@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 06 08:01:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9u97-0006Aa-VH
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 08:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210Ab0EFGBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 02:01:10 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:56022 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752011Ab0EFGBI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 02:01:08 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O9u8w-0003zU-HO
	for git@vger.kernel.org; Thu, 06 May 2010 02:01:06 -0400
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146440>

An svn feature that I used a lot is `svn cat some-file' -- and with
git I can get close to that with `git show :some-file', except that
unlike other paths, it must be an absolute path from the repository
root.  I could obviously make up a script that will do it, but that's
just buying myself some time until I find some other command where
I'll want to use it.

It looks like it would be relatively easy to do this, since when I do
specify the relative path I get an error message suggesting the full
one (provided that the relative path is simple -- no ".." etc).  So,
now that I can actually UTSL, I went there, and tried some half-assed
hacking -- I made it so "::path" uses the prefix and normalizes the
result, so, for example

  cd git/Documentation
  git show ::../Documentation/./user-manual.conf

works as expected.  Using "::" looks bad IMO, and the hack I did is
likely suffering from some problems, but overall it doesn't look too
hard.

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
