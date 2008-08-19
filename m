From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT RFC] JGit mavenization done right
Date: Tue, 19 Aug 2008 21:52:55 +0200
Message-ID: <200808192152.55267.robin.rosenberg.lists@dewire.com>
References: <7bfdc29a0808162152y4329303dte8f82bfea646180d@mail.gmail.com> <7bfdc29a0808172333g1cbe2102n6e76ae98a1943411@mail.gmail.com> <20080819144424.GC20947@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Imran M Yousuf <imyousuf@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 21:55:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVXIh-0005bC-3n
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 21:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbYHSTyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 15:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753423AbYHSTyY
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 15:54:24 -0400
Received: from av10-2-sn2.hy.skanova.net ([81.228.8.182]:43003 "EHLO
	av10-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087AbYHSTyX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 15:54:23 -0400
Received: by av10-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id C9BD53958B; Tue, 19 Aug 2008 21:54:21 +0200 (CEST)
Received: from smtp4-2-sn2.hy.skanova.net (smtp4-2-sn2.hy.skanova.net [81.228.8.93])
	by av10-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id 45BFE38D78; Tue, 19 Aug 2008 21:54:21 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-2-sn2.hy.skanova.net (Postfix) with ESMTP id 018FC37E46;
	Tue, 19 Aug 2008 21:54:20 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080819144424.GC20947@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92916>

tisdagen den 19 augusti 2008 16.44.24 skrev Shawn O. Pearce:
> Imran M Yousuf <imyousuf@gmail.com> wrote:
> > On Mon, Aug 18, 2008 at 11:55 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > > Imran M Yousuf <imyousuf@gmail.com> wrote:
> > >> I would like to request you all to test out JGit from
> > >> http://repo.or.cz/w/egit/imyousuf.git. Please checkout the branch
> > >> 'unified_tst_rsrc' and try to build it with both maven and Eclipse
> > >> (i.e. as was built earlier)
> > 
> > Thanks, it would nice to know whether it works in the original build
> > process or not :).
> 
> Well, it did break it in Eclipse:
> 
> $ git diff-tree --abbrev -r -M --diff-filter=D orcz-pub/master HEAD
> :100644 000000 9d7d138... 0000000... D  org.spearce.jgit.test/.gitignore
> :100644 000000 987d6be... 0000000... D  org.spearce.jgit.test/.project
> :100644 000000 8bfa5f1... 0000000... D  org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs
> :100644 000000 fce94cf... 0000000... D  org.spearce.jgit.test/.settings/org.eclipse.jdt.ui.prefs
> :100644 000000 304e861... 0000000... D  org.spearce.jgit/.classpath
> :100644 000000 ba077a4... 0000000... D  org.spearce.jgit/.gitignore
> :100644 000000 7d38455... 0000000... D  org.spearce.jgit/.project
> :100644 000000 709a440... 0000000... D  org.spearce.jgit/.settings/org.eclipse.jdt.ui.prefs
> 
> Removing this stuff was not so good.  The Eclipse projects are
> busted and can't be used anymore.  We need them back.
> 
> The make_jgit.sh however seems to produce a valid JAR.  Given the
> file-level differences I didn't expect it to fail.
> 
> Also, I wonder if JGitTestUtil is better handled by placing the
> method in RepositoryTestCase and making sure everyone subclasses
> that if they need a test resource file?  I'm fairly certain they
> already do, and its a lot easier to invoke a method you inherited
> than one in another class.  (Well, easier for the guy writing the
> test case anyway, Java obviously doesn't care either way.)
> 
> If we are going to take this in upstream I'd like a flattened/cleaned
> up history.  Being able to bisect the misstep of using symlinks
> (the old Maven approach) isn't very valuable in the long-term view
> of the history.
> 
> Robin, any thoughts?

Right, I'd also like to see that cleaned up approch in patch form. Cleaning up
helps when preparing for review because one usually find bad stuff during
that process.

-- robin
