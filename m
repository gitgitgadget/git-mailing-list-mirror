From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Thu, 30 Oct 2008 10:51:08 -0700
Message-ID: <1225389068.19891.28.camel@maia.lan>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
	 <20081030143918.GB14744@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sam Vilain <samv@vilain.net>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Oct 30 18:53:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvbhj-0004kq-VU
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 18:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757999AbYJ3Rvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 13:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757994AbYJ3Rvb
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 13:51:31 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:52271 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755541AbYJ3Rva (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 13:51:30 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 096AD21C83C; Fri, 31 Oct 2008 06:51:28 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [127.0.0.1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id ADCE221C469;
	Fri, 31 Oct 2008 06:51:11 +1300 (NZDT)
In-Reply-To: <20081030143918.GB14744@mit.edu>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99511>

On Thu, 2008-10-30 at 10:39 -0400, Theodore Tso wrote:
> * Add the command "git revert-file <files>" which is syntactic sugar for:
> 
>         git checkout HEAD -- <files>
> 
>   Rationale: Many other SCM's have a way of undoing local edits to a
>   file very simply, i.e."hg revert <file>" or "svn revert <file>", and
>   for many developers's workflow, it's useful to be able to undo local
>   edits to a single file, but not to everything else in the working
>   directory.  And "git checkout HEAD -- <file>" is rather cumbersome
>   to type, and many beginning users don't find it intuitive to look in
>   the "git-checkout" man page for instructions on how to revert a
>   local file.

Well, I don't have strong feelings on the exact command name used; I
suggested "undo", probably also ambiguous.  But still, a significant
number of users are surprised when they type 'git revert' and they get a
backed out patch.  It's such an uncommon operation, it doesn't deserve
to be triggered so easily.  And reverting files to the state in the
index and/or HEAD is a common operation that deserves being short to
type.

Making it plain "revert" would violate expectations of existing users;
it seems a better idea to just deprecate it, and point the users to the
new method - cherry-pick --revert - or the command they might have meant
- whatever that becomes.

Sam.
