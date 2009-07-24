From: Alex Vandiver <alex@chmrr.net>
Subject: Re: [PATCH 2/2] After renaming a section, print any trailing variable definitions
Date: Fri, 24 Jul 2009 18:26:55 -0400
Message-ID: <1248474081-sup-2762@utwig>
References: <1248470504-16326-1-git-send-email-alex@chmrr.net> <1248470504-16326-2-git-send-email-alex@chmrr.net> <1248470504-16326-3-git-send-email-alex@chmrr.net> <20090725071105.6117@nanako3.lavabit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 00:59:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUTjQ-0003mr-Q4
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 00:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144AbZGXW7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 18:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755142AbZGXW7J
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 18:59:09 -0400
Received: from chmrr.net ([209.67.253.66]:56525 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754999AbZGXW7J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 18:59:09 -0400
X-Greylist: delayed 1933 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Jul 2009 18:59:08 EDT
Received: from chmrr by utwig.chmrr.net with local (Exim 4.69)
	(envelope-from <chmrr@chmrr.net>)
	id 1MUTE7-0001jR-F4; Fri, 24 Jul 2009 18:26:55 -0400
In-reply-to: <20090725071105.6117@nanako3.lavabit.com>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123972>

At Fri Jul 24 18:11:05 -0400 2009, Nanako Shiraishi wrote:
> Quoting Alex Vandiver <alex@chmrr.net>
> > diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> > index 43ea283..8c43dcd 100755
> > --- a/t/t1300-repo-config.sh
> > +++ b/t/t1300-repo-config.sh
> > @@ -460,6 +460,28 @@ EOF
> >  test_expect_success "rename succeeded" "test_cmp expect .git/config"
> >  
> >  cat >> .git/config << EOF
> > +[branch "vier"] z = 1
> > +EOF
> 
> Isn't this a syntax error?

Nope -- at least, not according to both the code, and the tests
(search or noNewline in t/t1300-repo-config.sh).

Though I also note that the documentation disagrees with the code in
the following case:

    Each variable must belong to some section, which means that there
    must be a section header before the first setting of a variable.

  $ cat >bogus
  foo = 42

  $ git config --file bogus --list
  foo=42

  $ git config --file bogus --get foo
  42

 - Alex
-- 
Networking -- only one letter away from not working
