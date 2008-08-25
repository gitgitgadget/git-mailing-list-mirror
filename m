From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "failed to read delta base object at..."
Date: Mon, 25 Aug 2008 14:37:39 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808251435540.3363@nehalem.linux-foundation.org>
References: <20080825164602.GA2213@fieldses.org> <alpine.LFD.1.10.0808251153210.3363@nehalem.linux-foundation.org> <20080825213104.GI2213@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 23:39:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXjmO-0004Uw-ND
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 23:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbYHYVhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 17:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbYHYVhu
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 17:37:50 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33703 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752898AbYHYVht (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Aug 2008 17:37:49 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7PLbdGJ020199
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Aug 2008 14:37:40 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7PLbdU4006325;
	Mon, 25 Aug 2008 14:37:39 -0700
In-Reply-To: <20080825213104.GI2213@fieldses.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.427 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93686>



On Mon, 25 Aug 2008, J. Bruce Fields wrote:
> 
> OK.  I seem to recall these pack files are created with something like
> 
> 	open
> 	write
> 	sync
> 	close
> 	rename
> 
> ? 

Yes. We're trying to be _extremely_ safe and only do things that should 
work for everything.

> This is just ext3 with data=writeback on a local laptop disk,
> ubuntu's 2.6.24-21-generic.  Would it be any use trying to look more
> closely at the pack in connection for any hints?

You still have the packfile that caused problems available somewhere? If 
so, absolutely yes. If you have the corrupt pack, please make it 
available.

> (But with my git repo back I'm happy enough to just forget this for now
> if there's not anything obvious to try.)

With the actual corrupt pack, we can make a fairly intelligent guess about 
exactly what the corruption was. Was it a flipped bit, or what? So if you 
have it, please do send it over.

			Linus
