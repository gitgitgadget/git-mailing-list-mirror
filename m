From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: Git tree/blob and corresponding commit
Date: Sun, 10 Aug 2008 15:38:59 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808101519220.16851@harper.uchicago.edu>
References: <489F208B.2070006@obry.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git list <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Sun Aug 10 22:40:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSHhw-00034r-8c
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 22:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbYHJUjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 16:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753487AbYHJUjD
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 16:39:03 -0400
Received: from smtp00.uchicago.edu ([128.135.12.76]:58087 "EHLO
	smtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbYHJUjB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 16:39:01 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp00.uchicago.edu (8.13.8/8.13.8) with ESMTP id m7AKcxd2026455;
	Sun, 10 Aug 2008 15:38:59 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m7AKcxXI017288;
	Sun, 10 Aug 2008 15:38:59 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <489F208B.2070006@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91884>

Pascal Obry wrote:

> Now given a SHA1 I'd like to know which commit has created (was containing)
> this specific blob?

Why do you want to know?  The right method depends on your reason.  You
probably know more than I do about this, but here are my thoughts.

If some loose object of yours got corrupted and you are trying to
see what exactly is missing, then (for this task) you are in luck.  See
<http://www.kernel.org/pub/software/scm/git/docs/howto/recover-corrupted-blob-object.txt>.

If some packed object got corrupted, I'd be interested to hear how
this is handled.  I think there was discussion recently of how to
recover from that situation.  If you have the luxury, it might be good
to use unpack-objects to get to the first situation.

But I think that is not your situation.  I'll assume for definiteness
that some source file appeared out of thin air in your /lost+found and
you are trying to figure out what it is.  Then see
<http://thread.gmane.org/gmane.comp.version-control.git/44750/focus=44754>
and surrounding discussion.  You could use "git ls-tree -r" if you do
not have the filename.

Hope that helps,
Jonathan
