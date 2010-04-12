From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: simplest git deamon?
Date: Mon, 12 Apr 2010 07:22:03 -0700
Message-ID: <20100412142203.GB6313@spearce.org>
References: <20100412164740.740050cb@pbmiha.malagasy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mihamina Rakotomandimby <mihamina@gulfsat.mg>
X-From: git-owner@vger.kernel.org Mon Apr 12 16:22:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1KWn-0007hH-KQ
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 16:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842Ab0DLOWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 10:22:11 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:47045 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab0DLOWK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 10:22:10 -0400
Received: by bwz19 with SMTP id 19so12009bwz.21
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 07:22:09 -0700 (PDT)
Received: by 10.204.21.20 with SMTP id h20mr4759168bkb.149.1271082129145;
        Mon, 12 Apr 2010 07:22:09 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 15sm1810016bwz.12.2010.04.12.07.22.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 07:22:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100412164740.740050cb@pbmiha.malagasy.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144731>

Mihamina Rakotomandimby <mihamina@gulfsat.mg> wrote:
> Manao ahoana, Hello, Bonjour,
> 
> I would like to setup a git repository, on a Debian machine.
> I would like to access it only with git:// (no http://, no ssh://,...)
> 
> How to implement read/write restriction when just wanting to use
> "git://" without dealing with SSH?
> 
> http://www.kernel.org/pub/software/scm/git/docs/everyday.html, at it's
> bottom tlak about this but it requires SSH.
> https://help.ubuntu.com/community/Git talks about gitosis, but it
> requires keys.
> 
> I have the GIT repository setup, with the "git://"-only access scheme, 
> but anyone may push into this.
> 
> I expected just a flat file the SVN way (But I dont want to use SVN):

Git isn't SVN.

The git:// daemon is *anonymous*.  It has no authentication
capability, nor will it probably ever learn how to authenticate
users.  Consequently you can't do what you want with it.

Instead of reinventing the wheel poorly, Git relies on external
servers to perform the authentication.  So if you want authenticated
access, you will need to use either SSH or HTTP.

If you use SSH, lots of people get by with Gitosis, as its fairly
simple to configure.  Another option is to use something much more
complex like Gerrit Code Review[1] that contains its own SSH server.

If you use HTTP, use the newer git-http-backend[2] that was
introduced in Git 1.6.6 (or later), running behind an Apache
HTTP server.

[1] http://code.google.com/p/gerrit/
[2] http://www.kernel.org/pub/software/scm/git/docs/git-http-backend.html
 
-- 
Shawn.
