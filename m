From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn throwing assertion on old svn tracking branch
Date: Sun, 31 Dec 2006 18:27:34 -0800
Message-ID: <20070101022734.GF7730@hand.yhbt.net>
References: <20061220235551.GA2974@hermes.lan.home.vilz.de> <20061221010520.GB3901@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 01 03:27:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1Ctx-0008WK-TN
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 03:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932872AbXAAC1g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 21:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932874AbXAAC1g
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 21:27:36 -0500
Received: from hand.yhbt.net ([66.150.188.102]:58376 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932872AbXAAC1f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 21:27:35 -0500
Received: by hand.yhbt.net (Postfix, from userid 500)
	id E88357DC094; Sun, 31 Dec 2006 18:27:34 -0800 (PST)
To: Nicolas Vilz <niv@iaglans.de>
Content-Disposition: inline
In-Reply-To: <20061221010520.GB3901@localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35719>

Eric Wong <normalperson@yhbt.net> wrote:
> Nicolas Vilz <niv@iaglans.de> wrote:
> > hello guys,
> > 
> > it has been a while, i tried git in conjunction with svn... i got a nice
> > history, when working with it. This Work is now a year old.
> > 
> > Now I wanted to get on working and got following error message while
> > fetching from one specific svn tracking branch:
> > 
> > $ git-svn fetch -i svn_master
> > perl: subversion/libsvn_subr/path.c:343: svn_path_remove_component: 
> > Assertion `is_canonical(path->data, path->len)' failed.
> > Aborted

Actually, I just hit upon a weird bug in svm (SVN::Mirror) that was
similar to this (line 114 of the same file, 1.4.2dfsg1-2 in Debian).
Can you try taking the trailing slash out of the URL?
(.git/svn/svn_master/info/url).

Thanks.

-- 
Eric Wong
