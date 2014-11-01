From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] git-svn: use SVN::Ra::get_dir2 when possible
Date: Sat, 1 Nov 2014 03:13:52 +0000
Message-ID: <20141101031352.GA17306@dcvr.yhbt.net>
References: <20141031232222.GA30046@dcvr.yhbt.net>
 <1414808346.73568.YahooMailBasic@web172303.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Nov 01 04:14:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkP8c-0004ka-FN
	for gcvg-git-2@plane.gmane.org; Sat, 01 Nov 2014 04:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbaKADNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2014 23:13:54 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51515 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137AbaKADNy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2014 23:13:54 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id D49D41F838;
	Sat,  1 Nov 2014 03:13:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1414808346.73568.YahooMailBasic@web172303.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> While my 2.10 + 11 patches continue to fetch, where it was stuck, now
> it does "Couldn't find revmap..." - also, the single branch clone is doing
> the 'trunk/branches/... thing - are these supposed to happen?

I'm afraid this is a problem with the vbox repo not publishing anything
but trunk, but their svn:mergeinfo refers to non-public branches.

This shows only changes to trunk:

	svn log -v http://www.virtualbox.org/svn/vbox

I do not know what their development process is like.  From the looks of
it, every change is made by a "vboxsync" user.  I suspect that's driven
by an automated export script, and the real development happens in a
different (private) repo...
