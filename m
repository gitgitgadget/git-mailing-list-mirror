From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Remove diff machinery dependency from read-cache
Date: Thu, 21 Jan 2010 12:15:56 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001211215080.13231@localhost.localdomain>
References: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain> <7vljfrp6g2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 21:20:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY3UR-0006wp-UU
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 21:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169Ab0AUUSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 15:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754986Ab0AUUSr
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 15:18:47 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47920 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755042Ab0AUUSq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2010 15:18:46 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0LKFuZU024968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jan 2010 12:15:57 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0LKFuwv027016;
	Thu, 21 Jan 2010 12:15:56 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vljfrp6g2.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.449 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137691>



On Thu, 21 Jan 2010, Junio C Hamano wrote:
> 
> The patch itself to move add_files_to_cache() to builtin-add.c (or to its
> own file) makes sense from the code placement POV, but if the goal is to
> shrink the on-disk footprint, isn't an alternative approach be to make
> hash-object built-in?  You can lose the whole 1.7M from the filesystem
> footprint that way, no?

Sure. Except, as I mentioned, it's not just git-hash-object. It's _all_ of 
them.

The total space savings wasn't 1.7M, it was 12M.

		Linus
