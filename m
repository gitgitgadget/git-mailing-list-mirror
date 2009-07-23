From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn wowes
Date: Thu, 23 Jul 2009 01:12:08 -0700
Message-ID: <20090723081208.GB32287@dcvr.yhbt.net>
References: <025FAAA7CA644D709E1635C497753444@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 10:12:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTtPX-0001oW-B0
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 10:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbZGWIMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 04:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbZGWIMK
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 04:12:10 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42686 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbZGWIMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 04:12:09 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 585751F793;
	Thu, 23 Jul 2009 08:12:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <025FAAA7CA644D709E1635C497753444@HPLAPTOP>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123857>

Aaron Gray <aaronngray.lists@googlemail.com> wrote:
> Hi,
>
> I have a working git-svn clone of a svn based project.
>
> At the mement I have a .sh script run every hour which goes :-
>
>    git svn fetch
>    git reset -- hard HEAD
>    git svn rebase
>
> I am sure this is like using a hammer to crack a nut.
>
> Is there a better way to do this ?

Assuming you don't make your own local changes ever:

  git svn fetch
  git reset --hard $ref

Where $ref is most likely "trunk" if you used -s/--stdlayout or
"git-svn" if you did not.  Running `git branch -r' will give you
a list of remote refs that you can reset to.

-- 
Eric Wong
