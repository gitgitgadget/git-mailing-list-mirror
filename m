From: Mike Hommey <mh@glandium.org>
Subject: Re: Git's database structure
Date: Tue, 4 Sep 2007 18:07:26 +0200
Organization: glandium.org
Message-ID: <20070904160726.GA17509@glandium.org>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com> <46DD7FE4.1060908@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 04 18:08:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISaxV-0005ec-RO
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 18:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbXIDQIw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 12:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbXIDQIw
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 12:08:52 -0400
Received: from vawad.err.no ([85.19.200.177]:36364 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099AbXIDQIv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 12:08:51 -0400
Received: from aputeaux-153-1-67-149.w81-249.abo.wanadoo.fr ([81.249.53.149] helo=vaio.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1ISawu-000345-EL; Tue, 04 Sep 2007 18:08:41 +0200
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1ISaw2-0004qH-3G; Tue, 04 Sep 2007 18:07:26 +0200
Content-Disposition: inline
In-Reply-To: <46DD7FE4.1060908@op5.se>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57604>

On Tue, Sep 04, 2007 at 05:55:16PM +0200, Andreas Ericsson <ae@op5.se> wrote:
> Each root tree can only ever belong to a single commit, unless you
> intentionally force git to make completely empty commits. git
> won't complain about this, so long as you don't make two in the
> same second, because it relies more heavily on the DAG than on
> developer sanity.

Actually, you don't need to be insane to have multiple commits pointing
at the same root tree. It is actually very easy:
- git clone
- do some stuff on your master branch and commit
- send your changes upstream
- upstream applies as is
- git pull

You now have everything merged, and the last commit on your master branch,
while being a different commit object due to its parenting, has the same
root tree as the tip of the remote branch.

Mike
