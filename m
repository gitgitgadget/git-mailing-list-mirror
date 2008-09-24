From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Files that want to delete themselves
Date: Wed, 24 Sep 2008 11:05:47 -0700
Message-ID: <20080924180547.GA3669@spearce.org>
References: <19654453.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andrew Vit <andrew@avit.ca>
X-From: git-owner@vger.kernel.org Wed Sep 24 20:07:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiYlR-0000Q1-3e
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 20:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbYIXSFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 14:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752043AbYIXSFs
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 14:05:48 -0400
Received: from george.spearce.org ([209.20.77.23]:42804 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbYIXSFs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 14:05:48 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 998BA38360; Wed, 24 Sep 2008 18:05:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <19654453.post@talk.nabble.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96674>

Andrew Vit <andrew@avit.ca> wrote:
> 
> I have a Rails project that I'm managing with git and I have a strange
> problem with one of the plugin directories. Every time I do `git add .` it
> tries to delete itself... Any idea what might be happening?
> 
> andrew$ git status
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #	new file:   vendor/plugins/restful_authentication
> #	deleted:    vendor/plugins/restful_authentication/CHANGELOG
> #	deleted:    vendor/plugins/restful_authentication/README.textile
> #	deleted:    vendor/plugins/restful_authentication/Rakefile
> #	deleted:    vendor/plugins/restful_authentication/TODO

Are you on a case-insensitive filesystem like HFS+?

Is it possible that restful_authentication exists as a file in
your working directory, but as a directory in Git, but with a
different case?

What does `git ls-tree HEAD:vendor/plugins` show you as the last
committed contents of vendor/plugins?

I'm a little stumped, but it sounds like the issues that have come
up before due to a case-insensitive filesystem.

-- 
Shawn.
