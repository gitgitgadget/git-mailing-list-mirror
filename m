From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC/PATCH] gitk: Visualize a merge commit with a right-click in
 gitk
Date: Mon, 31 Dec 2012 15:27:36 +1100
Message-ID: <20121231042736.GA14921@iris.ozlabs.ibm.com>
References: <1356826576-24334-1-git-send-email-jason.k.holden.swdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jason Holden <jason.k.holden.swdev@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 31 05:28:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpWyo-0004iQ-KX
	for gcvg-git-2@plane.gmane.org; Mon, 31 Dec 2012 05:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181Ab2LaE1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 23:27:43 -0500
Received: from ozlabs.org ([203.10.76.45]:58843 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183Ab2LaE1l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2012 23:27:41 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id A38352C00A5; Mon, 31 Dec 2012 15:27:40 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <1356826576-24334-1-git-send-email-jason.k.holden.swdev@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212348>

On Sat, Dec 29, 2012 at 07:16:16PM -0500, Jason Holden wrote:

> When first doing a merge in git-gui, the "Visualize Merge" button is
> quite helpful to visualize the changes due to a merge.
> But once the merge is complete, there's not a similarly convenient
> way to recreate that merge view in gitk.
> 
> This commit adds to gitk the ability to right-click on a merge commit and
> bring up a new gitk window displaying only those commits involved in
> the merge.
> 
> When right-clicking on a non-merge commit, this option is grayed out.  This
> patch also supports correct visualization of octopus merges

Thanks for the patch.  I have a couple of comments about it.  First,
the exec command waits for the process to complete, which means that
the initial gitk GUI will be unresponsive until the user quits the
gitk window showing the merge, which could be quite confusing for the
user.

Secondly, gitk already has support for showing multiple views of a
repository, that is, different subsets of the commits.  Wouldn't it be
much better to have your new menu item simply create a new view
showing the merge, rather than creating a whole new window?

Paul.
