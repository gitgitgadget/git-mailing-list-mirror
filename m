From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pre-commit.sample: don't print incidental SHA1
Date: Sat, 16 May 2009 12:12:43 -0700
Message-ID: <7vvdo0n9p0.fsf@alter.siamese.dyndns.org>
References: <87y6sx1h6p.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sat May 16 21:12:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5PJV-0002Se-BV
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 21:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755315AbZEPTMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 15:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754978AbZEPTMn
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 15:12:43 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:36809 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818AbZEPTMm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 15:12:42 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090516191244.JDQW20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 16 May 2009 15:12:44 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id sKCj1b00B4aMwMQ03KCjWN; Sat, 16 May 2009 15:12:43 -0400
X-Authority-Analysis: v=1.0 c=1 a=vbhaWAtk9UQA:10 a=ic8_P8r8nKMA:10
 a=O0v0mdFJAAAA:8 a=yp6iGhVqlEvBtD5lEYgA:9 a=DiTN-_ZpjjZgLYps_4YA:7
 a=OZjHo5IzbKFFOUl3VxAucaem_hMA:4 a=VvQ7Xpx9qTgA:10
X-CM-Score: 0.00
In-Reply-To: <87y6sx1h6p.fsf@meyering.net> (Jim Meyering's message of "Sat\, 16 May 2009 12\:21\:50 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119374>

Jim Meyering <jim@meyering.net> writes:

> I enabled the sample pre-commit hook and was surprised to
> see new output with every commit.  It was due to that script's
> use of git-rev-parse.

Thanks.  I am half surprised that nobody has complained about this,
because the problem has been there since early 2006, and am half
unsurprised because I have long suspected that nobody would be using
pre-commit hook in real life.

> Also, I noticed the use of "git-hyphen" git-rev-parse.
> Perhaps that hyphen has been left in deliberately,
> for portability to very old versions of git?

Sample hooks do use features available only in the version of git that
ships them; we do not strive to retain such a portability in that sense.

The hook scripts are special in that they are invoked in an environment in
which the git subcommands in their dashed form are always available on its
$PATH.  People tend to learn by looking at examples, so it is a good idea
to change them to use the new, separate subcommand, form to set examples.

But that is obviously a much wider patch, so let's make that a separate
issue.
