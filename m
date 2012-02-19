From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn won't remember pem password
Date: Sun, 19 Feb 2012 01:30:11 +0000
Message-ID: <20120219013011.GB31886@dcvr.yhbt.net>
References: <E56535F6-2C9B-4D14-A88F-2471E34D2769@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthijs Kooijman <matthijs@stdin.nl>,
	Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>, git@vger.kernel.org
To: Igor <mrigor83@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 19 02:31:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ryvcp-000476-3A
	for gcvg-git-2@plane.gmane.org; Sun, 19 Feb 2012 02:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031Ab2BSBb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Feb 2012 20:31:28 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:47228 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753879Ab2BSBaN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2012 20:30:13 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80E131F7A0;
	Sun, 19 Feb 2012 01:30:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <E56535F6-2C9B-4D14-A88F-2471E34D2769@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191014>

Igor <mrigor83@gmail.com> wrote:
> I'm running into an issue where I have to enter my pem certificate
> password every time I git-svn fetch or git-svn dcommit. Vanilla svn
> uses OS X KeyChain and remembers my password just fine. Is there a
> known solution for this? Other users have ran into same issue as
> described here:
> http://stackoverflow.com/questions/605519/does-git-svn-store-svn-passwords.
> However, that solution of removing .subversion folder did not work for
> me.

Hi Igor, this issue seems related to the platform specific auth
providers patches.   There have been bugs in the SVN bindings in
previous releases and uncertainty about how everything works.

I haven't been interested enough to follow along closely[1], but maybe
some other folks Cc:-ed can finally push this through.

http://mid.gmane.org/20120103204403.GI17548@login.drsnuggles.stderr.nl

Basically I'm waiting for a patch that we can be certain won't break the
majority of existing use cases (especially no triggering of segfaults
and other nastiness in released versions of SVN bindings).

[1] - I barely use git-svn anymore, and wouldn't touch GNOME or OSX
      with a 10-foot pole...
