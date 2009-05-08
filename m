From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re:
Date: Fri, 8 May 2009 07:39:38 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905080734260.4983@localhost.localdomain>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504>  <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com>  <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504>  <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain>  <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504>
  <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain>  <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain>  <alpine.LFD.2.01.0905071446500.4983@localhost.localdomain> <81b0412b0905080117v3aad0c44o7b3bbcc7fe70d3b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bevan Watkiss <bevan.watkiss@cloakware.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 16:42:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2RGc-0005zV-Af
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 16:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092AbZEHOl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 10:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753324AbZEHOl3
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 10:41:29 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39382 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751994AbZEHOl2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2009 10:41:28 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n48EddqA010808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 May 2009 07:40:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n48Edcpg008503;
	Fri, 8 May 2009 07:39:39 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <81b0412b0905080117v3aad0c44o7b3bbcc7fe70d3b1@mail.gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118608>



On Fri, 8 May 2009, Alex Riesen wrote:
> 
> I did (cygwin). My guess, the improvement is completely dwarfed by the
> other overheads (like starting git and writing files).

Oh, I meant "git checkout" as in not even switching branches, or perhaps 
switching branches but just changing a single file (among thousands).

If you actually end up re-writing all files, then yes, it will obviously 
be totally dominated by other things.

For example, in the kernel, switching between two branches that only 
differ in one file (Makefile) went from 0.18 seconds down to 0.14 seconds 
for me just because of the fewer lstat() calls.

Noticeable? No. But it might be more noticeable on some other OS, or with 
some networked filesystem.

		Linus
