From: Ulrich =?utf-8?B?U3DDtnJsZWlu?= <uqs@spoerlein.net>
Subject: Re: migrating Mifos from svn to git
Date: Sun, 2 May 2010 10:25:03 +0200
Message-ID: <20100502082503.GG92627@acme.spoerlein.net>
References: <1272751725.21622.57.camel@scraps>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Monsen <haircut@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 02 10:25:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8UUI-0007xy-W1
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 10:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755770Ab0EBIZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 04:25:12 -0400
Received: from acme.spoerlein.net ([188.72.220.29]:60143 "EHLO
	acme.spoerlein.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755667Ab0EBIZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 04:25:09 -0400
Received: from acme.spoerlein.net (localhost.spoerlein.net [IPv6:::1])
	by acme.spoerlein.net (8.14.4/8.14.4) with ESMTP id o428P3Vd078328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 2 May 2010 10:25:03 +0200 (CEST)
	(envelope-from uqs@spoerlein.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=spoerlein.net;
	s=dkim200908; t=1272788704;
	bh=BavyYYmsZ2EE3L4leYepxqiiW0yN4epgP4g0hA4va0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=JFph9CQCdHs+Ri8989J6xHihIrcOAPt3UOl7Ewz6RBtkyPWwPWe6hUAt9khzHeN+/
	 FcivX8PdntAthcwjHVIS8KHxZbuoRVENVOKoIGQaNChAPtXNRVVUiY87pglq3bqb4y
	 pO2SusD5rpalPp9UaL2z5Nx1CwMkW0CnGWp4xY08=
Received: (from uqs@localhost)
	by acme.spoerlein.net (8.14.4/8.14.4/Submit) id o428P3Z4078327;
	Sun, 2 May 2010 10:25:03 +0200 (CEST)
	(envelope-from uqs@spoerlein.net)
Content-Disposition: inline
In-Reply-To: <1272751725.21622.57.camel@scraps>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146142>

On Sat, 01.05.2010 at 15:08:45 -0700, Adam Monsen wrote:
> 1. Is anyone willing to help me migrate Mifos from svn to git? If so,
> please contact me on or off list, or in #mifos or #git on FreeNode IRC
> (my nickname is "meonkeys"). It's for a good cause: our vision is to end
> world poverty!
> 
> 2. I'm trying out git-svn (a) to get used to git and (b) to actually try
> migrating our svn repo to a git repo. Is there a better way? (cbreak in
> #git seemed to think so)

svn2git is faster and can cope with multiple branches better, but it has
bugs of its own. Try both of them ...

> 3. When using git-svn, can I first "init"/"git svn fetch" from a local
> mirror ( file:///opt/mifos_mirror ), then switch to our real repository
> ( https://mifos.svn.sourceforge.net/svnroot/mifos ) once I'm mostly up
> to date?

Yes, if both repos have the same UUID this should be possible. You need
to fudge this in rev 0 and uuid in your svn mirror.

> 4. When using git-svn, "git svn init" works against my local mirror, but
> "git svn fetch" dies on svn revision 16072
> ( http://article.gmane.org/gmane.comp.finance.mifos.scm/6053 ). Can I
> maybe just skip that changeset ....nevermind, "git svn fetch
> --ignore-paths=branches/removeFinancialActionCache" seemed to do the
> trick. Hrm, now I'm stuck at some other commit. Anyway, thanks for
> enduring this ramble. Here's the latest problem I'm running into, in
> case anyone has ideas on what Fu I might use to get out of this hole:

If stuff has been merged from/to those ignored branches, you'll get
into trouble later on. So ignoring them altogether doesn't seem like a
good plan.

I was only lucky in using git-svn when converting trunk only, or some
selected branches where merging is/was done *always* from trunk ->
branchXY

hth
Uli
