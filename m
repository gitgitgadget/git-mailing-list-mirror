From: Jan Winkler <winkler@pinerecords.com>
Subject: Shouldn't git-am be able to pass -b to git-mailinfo?
Date: Fri, 15 Jul 2011 02:22:06 +0200
Message-ID: <20110715002206.GA19234@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 15 02:40:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhWSV-0008HR-Gk
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 02:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632Ab1GOAkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 20:40:42 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:55467 "EHLO
	louise.pinerecords.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932409Ab1GOAkl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 20:40:41 -0400
X-Greylist: delayed 1113 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jul 2011 20:40:41 EDT
Received: from louise.pinerecords.com (IDENT:5002@localhost [127.0.0.1])
	by louise.pinerecords.com with ESMTP id p6F0M7A3003010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 15 Jul 2011 02:22:07 +0200
Received: (from prook@localhost)
	by louise.pinerecords.com (submit) id p6F0M6lM003009
	for git@vger.kernel.org; Fri, 15 Jul 2011 02:22:06 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177185>


Hi,

I've been wondering:  git-am can pass -k to git-mailinfo, but not -b.
It's thus impossible to preserve a commitmsg starting with a bracketed
text.

Consider a commitmsg starting with '[ISSUE-1234] Fix breakage in XY.'
git format-patch produces:

    ...
    Subject: [PATCH] [ISSUE-1234] Fix breakage in XY.
    ...

Applying this patch using git-am results in commit message starting
either with

    Fix breakage...

or, using git-am -k, with

    [PATCH] [ISSUE-1234] Fix...

However, there is no way to get the original commit message using
git-am's interface.  Or am I missing something?

I'd supply a patch straight away, however, I can't think of a long
version of -b option to go well with -k/--keep. Any ideas?

-- 
Jan Winkler <winkler@pinerecords.com>
