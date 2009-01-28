From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Tue, 27 Jan 2009 17:00:54 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901271655090.3123@localhost.localdomain>
References: <bab6a2ab0901271504j73dce7afjf8436c3c7c83b770@mail.gmail.com> <bab6a2ab0901271510y1e3e6912t82ff16e0f912d4b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: PJ Hyett <pjhyett@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 02:03:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRypY-0004TC-FF
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 02:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbZA1BB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 20:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752692AbZA1BB0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 20:01:26 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39549 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752482AbZA1BBZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jan 2009 20:01:25 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0S10tBN012839
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 27 Jan 2009 17:00:56 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0S10s0A016106;
	Tue, 27 Jan 2009 17:00:54 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <bab6a2ab0901271510y1e3e6912t82ff16e0f912d4b6@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107439>



On Tue, 27 Jan 2009, PJ Hyett wrote:
> 
> ~/Development/github(jetty)$ git fsck --full
> warning in tree 0d640d99b492b0c7db034e92d0460a7f84b22356: contains zero-padded file modes
> ..

Ouch. This is unrelated to your issue, but I'm wondering what project 
contains these invalid trees, and how they were created.

Zero-padded tree entries can cause "object aliases", ie two trees that 
have logically the same contents end up with different data (due to 
different amounts of padding) and thus different SHA1's. It shouldn't be 
serious per se, but it's somethign that really shouldn't happen.

What project does it come from, and how did such a tree get generated?

			Linus
