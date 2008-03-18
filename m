From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [RFC/PATCH 3/3] gitweb: Fill project details lazily when caching
Date: Tue, 18 Mar 2008 10:52:52 +0100
Message-ID: <20080318095252.GH18624@mail-vs.djpig.de>
References: <1205766570-13550-1-git-send-email-jnareb@gmail.com> <1205766570-13550-4-git-send-email-jnareb@gmail.com> <20080318031406.GH10335@machine.or.cz> <200803181012.11273.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	"J.H." <warthog19@eaglescrag.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 10:53:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbYVw-0008Ae-Mm
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 10:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbYCRJxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2008 05:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752431AbYCRJxG
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Mar 2008 05:53:06 -0400
Received: from pauli.djpig.de ([78.46.38.139]:59910 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752309AbYCRJxF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2008 05:53:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id 8B02990077;
	Tue, 18 Mar 2008 10:53:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FYRjffIgrK2n; Tue, 18 Mar 2008 10:52:52 +0100 (CET)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id B536C90071;
	Tue, 18 Mar 2008 10:52:52 +0100 (CET)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.63)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1JbYV2-0000Ru-37; Tue, 18 Mar 2008 10:52:52 +0100
Content-Disposition: inline
In-Reply-To: <200803181012.11273.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77496>

On Tue, Mar 18, 2008 at 10:12:09AM +0100, Jakub Narebski wrote:
> On Tue, 18 March 2008, Petr Baudis wrote:
> > The idea is nice, but I'm surely missing something obvious again - why
> > do you use lstat() as opposed to stat()?
> 
> Because in my home installation of gitweb (for tests) I have 
> /home/local/scm/git.git symlinked to /home/jnareb/git/.git
> And I want to follow changes in repository; link itself doesn't
> change.

Which means you have that backwards, since

"lstat() is identical to stat(), except that if path is a symbolic link,
then the link itself is stat-ed, not the file that it refers to."
(from linux manpage)

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
