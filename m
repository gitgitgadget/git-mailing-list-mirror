From: Eric Wong <normalperson@yhbt.net>
Subject: Re: bug: git-svn seg fault during 'git svn fetch' due to perl <
 5.10
Date: Sat, 19 Jan 2013 11:51:02 +0000
Message-ID: <20130119115101.GA2559@dcvr.yhbt.net>
References: <2B10A89294DA6740AC6155F56842F9CE05234E6C@PRN-MBX01-2.TheFacebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Durham Goode <durham@fb.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 12:51:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwWxK-000474-O3
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 12:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988Ab3ASLvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2013 06:51:04 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:50073 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909Ab3ASLvC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 06:51:02 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A6511F5B5;
	Sat, 19 Jan 2013 11:51:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <2B10A89294DA6740AC6155F56842F9CE05234E6C@PRN-MBX01-2.TheFacebook.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213973>

Durham Goode <durham@fb.com> wrote:
> In git 1.8.1, when we do 'git svn fetch' on a large repo, we're seeing a
> seg fault.  It's caused by git-svn trying to parse a large yaml file
> (introduced in 
> https://github.com/git/git/commit/68f532f4ba888f277637a94b4a49136054df0540
> ) which encounters a perl regex stack overflow bug that was present in
> perl < 5.10 (https://bugzilla.redhat.com/show_bug.cgi?id=192400).
> 
> We'll find a work around, but it'd be nice if there was a config setting
> to let us choose not to use the yaml format.

Maybe try a libyaml-based YAML module?  I'm not too familiar
with YAML parsers in the Perl world.  Hopefully Jonathan can help.

> Let me know if there's a better place to report this.

Yes, feel free to Cc: folks who signed-off/acked the change which
introduced the problem for you.
