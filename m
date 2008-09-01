From: Magnus Hjorth <magnus.hjorth@home.se>
Subject: Re: Committing with past date?
Date: Mon, 01 Sep 2008 18:25:21 +0200
Message-ID: <1220286321.5474.6.camel@magnus-desktop>
References: <1220179469.5518.5.camel@magnus-desktop>
	 <m34p51qvzv.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 18:26:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaCEc-0003XU-S7
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 18:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbYIAQZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 12:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752318AbYIAQZ2
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 12:25:28 -0400
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:58531 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751627AbYIAQZ1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Sep 2008 12:25:27 -0400
Received: from c83-254-118-193.bredband.comhem.se ([83.254.118.193]:51376)
	by ch-smtp01.sth.basefarm.net with esmtp (Exim 4.68)
	(envelope-from <magnus.hjorth@home.se>)
	id 1KaCDU-0004dr-4l; Mon, 01 Sep 2008 18:25:27 +0200
In-Reply-To: <m34p51qvzv.fsf@localhost.localdomain>
X-Mailer: Evolution 2.22.3.1 
X-Originating-IP: 83.254.118.193
X-Scan-Result: No virus found in message 1KaCDU-0004dr-4l.
X-Scan-Signature: ch-smtp01.sth.basefarm.net 1KaCDU-0004dr-4l d4d4a6a8d8d86efed5a1df66ad60f493
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94594>

Thank you Jakub! 

Forgot to look in the main git manpage, and that variable wasn't
mentioned in the git-commit manpage or in any FAQ.. 

Now I have a more tricky question.

The first part of my application history (the stone age) was maintained
manually using tarballs, but the second part was maintained using CVS
(the dark ages).

I have successfully imported the CVS history using git-cvsimport, but
now I want to add these older revisions that were made with tarballs to
the same tree, before the CVS revisions. The last tarball and the first
CVS revision have identical content, and I would like to somehow "glue"
the histories together.

Can this be done? 

Best regards,
Magnus



On Sun, 2008-08-31 at 04:12 -0700, Jakub Narebski wrote:
> Magnus Hjorth <magnus.hjorth@home.se> writes:
> 
> > Can someone tell me how to make a git commit with a date other than the
> > current. I hope there is some easier way than changing the system
> > clock.. :)
> 
> See git(1), section "Environment Variables":
>    git Commits
>        GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, GIT_AUTHOR_DATE,
>        GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL, GIT_COMMITTER_DATE,
>        EMAIL
>               see git-commit-tree(1)
> 
> or you can use GIT_COMMITTER_IDENT, GIT_AUTHOR_IDENT.  See output
> of "git var -l" to get form of it.
>  
> > I'm trying to port over old version history that I maintained manually
> > (tarballs and changelogs) into a git repository. 
> 
> For that, I think it would be best to take a look at example
> fast-import script: contrib/fast-import/import-tars.perl;
> there is equivalent contrib/fast-import/import-zips.py if you
> perfer either Pyhon over Perl, and/or zips over tarballs.
> 
