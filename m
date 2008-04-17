From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUGS] test failure in t4014-format-patch.sh with master
Date: Thu, 17 Apr 2008 08:11:52 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0804170806430.2879@woody.linux-foundation.org>
References: <87od88eslq.dlv@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Remi Vanicat <vanicat@debian.org>
X-From: git-owner@vger.kernel.org Thu Apr 17 17:32:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmVnU-0001yW-Rc
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 17:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756554AbYDQPM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 11:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757103AbYDQPM0
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 11:12:26 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49941 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753760AbYDQPM0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Apr 2008 11:12:26 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3HFBst1032688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Apr 2008 08:11:55 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3HFBqwP014310;
	Thu, 17 Apr 2008 08:11:53 -0700
In-Reply-To: <87od88eslq.dlv@maison.homelinux.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.979 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79794>



On Thu, 17 Apr 2008, Remi Vanicat wrote:
> 
> While trying to wrote a test for git, I discover that there is a test
> failure in master on my computer:

Hmm. Doesn't fail for me.

> $ ./t4014-format-patch.sh
> [....]
> * FAIL 8: replay did not screw up the log message
> 
>  git cat-file commit rebuild-1 | grep "^Side .* with .* backslash-n"
> 
> It seem that now, somewhere a \n has been interpreted as a newline.

I wonder if it is some shell-specific variable expansion issue. What's 
your /bin/sh? (I assume, from your email address, that you're using 
Debian, and I thought Debian used bash, but maybe that's not true).

What does

	a="hello\nhi"
	echo $a

result in?

		Linus
