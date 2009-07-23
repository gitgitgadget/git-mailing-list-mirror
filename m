From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and --bare repositories
Date: Thu, 23 Jul 2009 01:07:12 -0700
Message-ID: <20090723080712.GA32287@dcvr.yhbt.net>
References: <F624E89E52304371B3CCFB737F9324DD@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 10:07:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTtL5-0008Mu-ND
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 10:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbZGWIHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 04:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbZGWIHP
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 04:07:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52894 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbZGWIHO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 04:07:14 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id F2B1B1F793;
	Thu, 23 Jul 2009 08:07:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <F624E89E52304371B3CCFB737F9324DD@HPLAPTOP>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123856>

Aaron Gray <aaronngray.lists@googlemail.com> wrote:
> How do I do a git svn fetch to a bare test.git repository created with :-
>
>    git --git-dir test.git --bare init --shared=true
>
> I have tried :-
>
>   git --git-dir test.git svn fetch http://test.org/git/test
>
> and
>
>   git --git-dir test.git/svn svn fetch http://test.org/git/test     ///  
> fictious address :)

Hi Aaron,

You need to do "git svn init $URL" from "git svn fetch" (the latter
does not take URL arguments)

   git --git-dir test.git --bare init --shared=true

   git --git-dir test.git svn init $options $URL

   git --git-dir test.git svn fetch

I haven't used bare repositories much with git svn, but apparently
it still works fine.

On a side note, "--git-dir $foo" really clutters up the command-line for
me, I guess I'm old-fashioned and prefer using the GIT_DIR environment
variable.

-- 
Eric Wong
