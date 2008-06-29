From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 29 Jun 2008 11:35:49 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806291127140.21402@hp.linux-foundation.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org> <7vwsnjl21c.fsf@gitster.siamese.dyndns.org> <7vhcehzdeg.fsf@gitster.siamese.dyndns.org> <7vbq4j748l.fsf@gitster.siamese.dyndns.org> <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org> <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org> <7v3anb19n7.fsf@gitster.siamese.dyndns.org> <7vwskjazql.fsf@gitster.siamese.dyndns.org>
 <7vk5ggipuw.fsf@gitster.siamese.dyndns.org> <7vej6l3lp7.fsf@gitster.siamese.dyndns.org> <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 20:37:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD1lj-00070W-Ux
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 20:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976AbYF2SgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 14:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753655AbYF2SgC
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 14:36:02 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44158 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753447AbYF2SgB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jun 2008 14:36:01 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5TIZo1H024818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 29 Jun 2008 11:35:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5TIZnBr001042;
	Sun, 29 Jun 2008 11:35:49 -0700
In-Reply-To: <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.357 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86817>



On Sun, 29 Jun 2008, Junio C Hamano wrote:
> 
>  * /usr/bin/git-cat-file is no more.  The bulk of the git commands will
>    move to /usr/libexec/git-core/ or somesuch.

Every time I read this note I do a double-take.

To me, the first sentence means that 'cat-file' command is gone. Then, the 
second sentence is just gibberish. And since I understand what you _want_ 
to say, I then go back and parse it properly, and know that you don't 
actually mean that git-cat-file is removed, but that it's removed from 
being accessible under that name in the path.

So to avoid my double-take, and hopefully avoid confusion for other 
people, can you please make your status report rephrase that thing.

Maybe just say

 * Do not install all git subcommands as 'git-xyzzy' files in the user 
   path. This avoids unnecessary hardlinks (or copies on systems that do 
   not support links), and enforces the 'git xyzzy' syntax.

   Subcommands that aren't builtins now get installed in
   /usr/libexec/git-core/ or somesuch.

(I haven't looked at the series, but I _assume_ it also avoids installing 
the builtin subcommands entirely when not necessary, ie "git-cat-file" 
really _is_ gone, but it's not because the "cat-file" command itself is 
gone).

Hmm? Or maybe it's just me who gets confused by the phrasing.

		Linus
