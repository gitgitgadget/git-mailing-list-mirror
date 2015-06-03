From: Kevin Daudt <me@ikke.info>
Subject: Re: Suggestion: make git checkout safer
Date: Wed, 3 Jun 2015 21:47:56 +0200
Message-ID: <20150603194756.GB29730@vps892.directvps.nl>
References: <loom.20150603T104534-909@post.gmane.org>
 <20150603090654.GD32000@peff.net>
 <loom.20150603T110826-777@post.gmane.org>
 <20150603093514.GF32000@peff.net>
 <loom.20150603T114527-151@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 21:48:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Ee5-0004hS-O2
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 21:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbbFCTr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 15:47:59 -0400
Received: from ikke.info ([178.21.113.177]:49843 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616AbbFCTr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 15:47:57 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 4DAE11DCF6D; Wed,  3 Jun 2015 21:47:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <loom.20150603T114527-151@post.gmane.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270730>

On Wed, Jun 03, 2015 at 09:55:05AM +0000, Ed Avis wrote:
> Jeff King <peff <at> peff.net> writes:
> 
 
> If my personal experience is anything to go by, newcomers may fall into the
> habit of running 'git checkout .' to restore missing files.  In the old days
> I would often delete a file and then run 'cvs update' or 'svn update' to
> restore it.  That would fetch a fresh copy from the repository, and while
> it might do some kind of diff/patch operation on modified files, it would
> not simply throw away local changes.
> 

The problem with these kinds of habbits is that they easily extend to
the --force variant. If people execute git checkout . as a habbit
without thinking, they will soon train to do git checkout -f . without
thinking, and then you still have the same problem.

I do share your sentiment that it's easy to loose uncomitted changes to
git checkout <path>, but like Jeff said, the entire goal of this command
is to reset specific files from the index or commits. 

Introducing a way to undo this would be a much better option to me then
adding an extra switch with no way to undo.
