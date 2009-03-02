From: Jeff King <peff@peff.net>
Subject: Re: merge, keeping the remote as a new file?
Date: Sun, 1 Mar 2009 23:11:13 -0500
Message-ID: <20090302041113.GA3094@coredump.intra.peff.net>
References: <81bfc67a0903011616w32ebdad9ofc096f5d1fd3174a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 05:13:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdzX5-0007dY-Ar
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 05:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756229AbZCBELS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 23:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755763AbZCBELS
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 23:11:18 -0500
Received: from peff.net ([208.65.91.99]:59854 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755504AbZCBELS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 23:11:18 -0500
Received: (qmail 3549 invoked by uid 107); 2 Mar 2009 04:11:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 01 Mar 2009 23:11:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 01 Mar 2009 23:11:13 -0500
Content-Disposition: inline
In-Reply-To: <81bfc67a0903011616w32ebdad9ofc096f5d1fd3174a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111902>

On Sun, Mar 01, 2009 at 07:16:10PM -0500, Caleb Cushing wrote:

>  I have an unmerged file... the resolution I'd like to have is
> checkout the local one for the current file name. take the remote
> version and give it a new file name. what's the best way to do that?

I would use:

  $ git show :2:file >file
  $ git show :3:file >newfile
  $ git add file newfile

You can do the first with "git checkout --ours", but I don't think there
is a way with "checkout" to say "checkout this path, but put it in a
different place".

-Peff
