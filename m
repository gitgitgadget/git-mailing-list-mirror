From: Nathan Gray <n8gray@n8gray.org>
Subject: git-svn: multiple fetch lines
Date: Fri, 16 Dec 2011 11:51:19 -0800
Message-ID: <CA+7g9Jxd3mhbra34f+MiJRt36Lb6gVHi1nOCP8Zo5y-G9jB3qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 21:03:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbdzy-0002x7-3c
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 21:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839Ab1LPUDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 15:03:14 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58825 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964806Ab1LPTvV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 14:51:21 -0500
Received: by eaaj10 with SMTP id j10so3219768eaa.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 11:51:20 -0800 (PST)
Received: by 10.204.148.75 with SMTP id o11mr3348072bkv.95.1324065079921; Fri,
 16 Dec 2011 11:51:19 -0800 (PST)
Received: by 10.204.228.204 with HTTP; Fri, 16 Dec 2011 11:51:19 -0800 (PST)
X-Originating-IP: [184.182.186.242]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187312>

Hello,

I'm in a conversation with the support fellow of the very nice Tower
git interface for OS X and we need clarification on a point.  Does
git-svn explicitly support multiple "fetch =" lines in an svn-remote
section or is it just an accident that it works?  My belief is that
such support is intended and his is that it is accidental.

You can see a more detailed explanation of why you would want to use
multiple fetch lines on this fellow's blog post:

http://davegoodell.blogspot.com/2009/04/multiple-remote-branches-in-git-svn.html

My company's svn server layout is a bit of a mess and to work around
that I've been using multiple "fetch" lines in git-svn's config:

[svn-remote "svn"]
    url = https://...

    # The trunk
    fetch = foo/trunk/Product:refs/remotes/trunk

    # Some individual branches from messy directories that I can't use globs on
    fetch = foo/branches/Developers/Nathan/Project/Product:refs/remotes/product-orig
    fetch = foo/branches/august-demo/Product:refs/remotes/august-demo

    # A well-organized branches folder that I can use a glob for
    branches = foo/branches/Product/*:refs/remotes/branches/*

    # etc...

Tower doesn't currently support such configurations and I'd like to
convince them that this is a perfectly sensible thing to do.

Thanks,
-Nathan

-- 
HexaLex: A New Angle on Crossword Games for iPhone and iPod Touch
http://hexalex.com
On The App Store: http://bit.ly/8Mj1CU
On Facebook: http://bit.ly/9MIJiV
On Twitter: http://twitter.com/hexalexgame
http://n8gray.org
