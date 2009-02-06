From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT] maven build fails on OS X
Date: Fri, 6 Feb 2009 07:31:55 -0800
Message-ID: <20090206153155.GL26880@spearce.org>
References: <320075ff0902060708m5ec566b9g755829c25c7727d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 16:33:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVSi9-0006tK-Bo
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 16:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbZBFPb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 10:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbZBFPb5
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 10:31:57 -0500
Received: from george.spearce.org ([209.20.77.23]:39624 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbZBFPb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 10:31:56 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6AF4338210; Fri,  6 Feb 2009 15:31:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <320075ff0902060708m5ec566b9g755829c25c7727d8@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108734>

Nigel Magnay <nigel.magnay@gmail.com> wrote:
> I don't know if this is known about - I get failures running the m2
> build for jgit:

Yup.
 
> Failed tests:
>   testParse_implicit_mixed_encoded(org.spearce.jgit.revwalk.RevCommitParseTest)
>   testParse_explicit_bad_encoded(org.spearce.jgit.revwalk.RevCommitParseTest)
>   testParse_implicit_mixed_encoded(org.spearce.jgit.revwalk.RevTagParseTest)
>   testParse_explicit_bad_encoded(org.spearce.jgit.revwalk.RevTagParseTest)
>   testDequote_OctalAll(org.spearce.jgit.util.QuotedStringGitPathStyleTest)
>   testDequote_Latin1(org.spearce.jgit.util.QuotedStringGitPathStyleTest)
>   testDequote_RawLatin1(org.spearce.jgit.util.QuotedStringGitPathStyleTest)
>   testGetText_DiffCc(org.spearce.jgit.patch.GetTextTest)
> 
> Curiously, the tests work in eclipse and from ./make_jgit.sh - I
> suspect some environment setting with the mac's charset.

make_jgit.sh doesn't run tests.  But Eclipse does, and as you state,
I have also seen these pass in Eclipse but fail from m2.

What's even more curious is look at the surefire report files for
these tests.  The actual result looks correct, the expected result
looks wrong.  I think m2 miscompiled the Java sources for the tests
somehow and produced incorrect literal strings which are used for
the expected values in the tests.

I don't see these failures on Linux, from either Eclipse or Maven.

> I can try and fix it if it's new, but I wanted to check first..

I've looked at it and gave up.  I don't know what Maven is doing here
on the Mac.  Maybe fresh eyes will have a better chance at fixing it.

My experience with Maven is it works about 5% of the time, and the
other 95% of the time you have to work around it by skipping tests,
or by writing massive blocks of XML in your pom.xml file, or by
redesigning your entire project directory structure and revision
control system to use SVN instead of Git.

-- 
Shawn.
