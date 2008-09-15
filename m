From: David Brown <git@davidb.org>
Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
Date: Sun, 14 Sep 2008 23:35:21 -0700
Message-ID: <20080915063521.GA1533@linode.davidb.org>
References: <16219.81556.qm@web95005.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: GIT SCM <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Simon Hausmann <simon@lst.de>
To: dhruva <dhruva@ymail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 08:36:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kf7hG-0001gI-7P
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 08:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbYIOGfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 02:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbYIOGfX
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 02:35:23 -0400
Received: from linode.davidb.org ([72.14.176.16]:34861 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823AbYIOGfW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 02:35:22 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1Kf7g9-0000Uq-KK; Sun, 14 Sep 2008 23:35:21 -0700
Content-Disposition: inline
In-Reply-To: <16219.81556.qm@web95005.mail.in2.yahoo.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95882>

On Mon, Sep 15, 2008 at 11:56:22AM +0530, dhruva wrote:

>8. The git diffs is now not aware of the change in RCS keyword
>9. You try to submit your local changes back to p4
>10. Applying your local changes as patch sets will fail with missing hunks tracking RCS keyword changes

It sounds like you are trying to apply these as patches to a tree
which doesn't have RCS headers.  As far as I can tell, P4 completely
ignores whatever the $Id: ...$ headers happen to be expanded to at the
time of checking.  You can put garbage there, and it check in fine.

I've been checking in files for many years with stripped headers.  I
wrote a python script years ago to strip the P4 headers after Perforce
was unwilling to implement this as an option.

I guess it isn't a problem to make this optional in git-p4, but I
don't think this patch is solving the right problem.

David
