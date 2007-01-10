From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Tue, 9 Jan 2007 20:03:12 -0500
Message-ID: <20070110010312.GA25265@fieldses.org>
References: <7vbql9ydd7.fsf@assigned-by-dhcp.cox.net> <20070108131735.GA2647@coredump.intra.peff.net> <7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net> <20070109142130.GA10633@coredump.intra.peff.net> <7virffkick.fsf@assigned-by-dhcp.cox.net> <20070109213117.GB25012@fieldses.org> <87zm8ryiyz.wl%cworth@cworth.org> <20070109234421.GD30023@spearce.org> <eo1bqu$hji$1@sea.gmane.org> <20070110003433.GH30023@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 02:03:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Rs6-0001RC-M4
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 02:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbXAJBDQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 20:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932611AbXAJBDP
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 20:03:15 -0500
Received: from mail.fieldses.org ([66.93.2.214]:35299 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932610AbXAJBDP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 20:03:15 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H4Rs0-0007d1-PU; Tue, 09 Jan 2007 20:03:12 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20070110003433.GH30023@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36454>

On Tue, Jan 09, 2007 at 07:34:33PM -0500, Shawn O. Pearce wrote:
> Unfortunately .git/logs/HEAD wouldn't be created by default as its
> not under refs/heads or refs/remotes.  Though it could be made to be
> on by default, in which case it would only log changes while HEAD
> is detached.  If HEAD is attached to a branch then .git/logs/HEAD
> wouldn't be appended to (or even created), while the branch's own
> log is still appended to.

That would also provide all the needed "safety valve" on git checkout,
wouldn't it?  Since you could always recover from

	git checkout v1.4.0
	git commit -m -a 'some changes'
	git checkout 41.2.0

by looking back through the reflog for HEAD.

--b.
