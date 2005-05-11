From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Wed, 11 May 2005 23:38:53 +0000
Organization: linutronix
Message-ID: <1115854733.22180.202.camel@tglx>
References: <1115847510.22180.108.camel@tglx>  <428291CD.7010701@zytor.com>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 01:30:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW0eu-0001Sg-4y
	for gcvg-git@gmane.org; Thu, 12 May 2005 01:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVEKXiF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 19:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVEKXiF
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 19:38:05 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:28291
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261319AbVEKXiC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 19:38:02 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id C424465C003;
	Thu, 12 May 2005 01:38:00 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 7F57928204;
	Thu, 12 May 2005 01:38:02 +0200 (CEST)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <428291CD.7010701@zytor.com>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-05-11 at 16:14 -0700, H. Peter Anvin wrote:
> I would like to suggest a few limiters are set on the repoid.  In 
> particular, I'd like to suggest that a repoid is a UUID, that a file is 
> used to track it (.git/repoid), and that if it doesn't exist, a new one 
> is created from /dev/urandom.

Which is complety error prone due to rsync. Some of the repositories on
kernel.org keep identical copies of .git/description already. Why should
they preserve an unique .git/repoid ?

There is one clean way to solve this. Managed repository id's and a lot
of discipline.

I expect neither of those two things to happen, but a complete working
directory path is better than nothing to make educated guesses.
Committer names (maintainers) can be the same over repositories, but its
unlikely that somebody who manages more than one subsystems uses the
same working directory for them.

tglx


