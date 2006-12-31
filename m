From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: What commands can and can not be used with bare repositories?
Date: Sat, 30 Dec 2006 20:57:28 -0500
Message-ID: <20061231015728.GB20348@fieldses.org>
References: <E1H0poE-0000qd-Ee@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 02:57:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0pxI-0008SM-Px
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 02:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbWLaB5i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 20:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbWLaB5h
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 20:57:37 -0500
Received: from mail.fieldses.org ([66.93.2.214]:41570 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932637AbWLaB5h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 20:57:37 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H0px2-0006cN-Ak; Sat, 30 Dec 2006 20:57:28 -0500
To: Theodore Ts'o <tytso@mit.edu>
Content-Disposition: inline
In-Reply-To: <E1H0poE-0000qd-Ee@candygram.thunk.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35646>

On Sat, Dec 30, 2006 at 08:48:22PM -0500, Theodore Ts'o wrote:
> What isn't documented is what commands actually can deal with a bare
> repository.  At the moment, it looks like a bare repository can be a
> target of a git pull, push, and merge commands, and it can be a source
> for a git clone, but that seems to be about it.  All other commands,
> such as "git log" blow up with the error message "Not a git repository".
> This to me seems a bit lame, since why isn't a "bare repository" also a
> "git repository"?  All of the information is there for "git log" to
> work.  Commands that require a working directory obviously can't work,
> but there are plenty of git commands for which there's no reason why
> they shouldn't be able to operate on a bare repository.  For example,
> "git repack", "git log", "git fetch", etc.

Yup.  Anything that should work actually does; you just need to know to
use one of:

	GIT_DIR=. git log
	git --git-dir=. log
	git --bare log

Why git couldn't figure this out for you, I don't know....

--b.
