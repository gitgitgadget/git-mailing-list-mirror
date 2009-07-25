From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn fetches the same revision multiple times for non-trunk
	branches
Date: Sat, 25 Jul 2009 03:51:11 -0700
Message-ID: <20090725105111.GB13534@dcvr.yhbt.net>
References: <CEAA2460-501C-48C1-BC33-B92A68C2161B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Zeh <robert.a.zeh@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 12:51:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUeqV-0008HP-Ql
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 12:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbZGYKvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 06:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752498AbZGYKvM
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 06:51:12 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:58792 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbZGYKvL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 06:51:11 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id D8DD31F4E8;
	Sat, 25 Jul 2009 10:51:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CEAA2460-501C-48C1-BC33-B92A68C2161B@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124002>

Robert Zeh <robert.a.zeh@gmail.com> wrote:
> I am seeing git svn fetch repeatedly retrieve the same Subversion  
> revisions when it finds branches in our Subversion repository. We are  
> using the standard Subversion repository layout, with top level /trunk, 
> /tags, and /branches directories (and the git repository was created with 
> 'git svn init -s'). However, the problematic branches are often copies 
> made from a subdirectory inside of trunk, instead of trunk.

Hi Robert,

Yes, this is a known problem with some repositories and there's no
automatic/easy[1] way to handle it with globbing tags/* or branches/*.

You can try to track each tagged project independently or to setup
individual fetche lines (like the one generated for trunk).  in
.git/config for each tag/branch.

[1] - Unfortunately SVN allows way too much freedom and thus ambiguity
in how it treats tags/branches and that doesn't allow mapping those
things to git very easily.

-- 
Eric Wong
