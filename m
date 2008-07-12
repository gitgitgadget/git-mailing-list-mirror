From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 1/1] jgit: create a tag command
Date: Sat, 12 Jul 2008 03:42:06 +0000
Message-ID: <20080712034206.GA16101@spearce.org>
References: <200807070041.35873.robin.rosenberg.lists@dewire.com> <200807070116.39892.robin.rosenberg.lists@dewire.com> <e2b179460807100831g5d62a0a8nc7e7bf2715f0b9f1@mail.gmail.com> <20080711020507.GD31862@spearce.org> <e2b179460807110145n4182978awd3aa3f97c3caac95@mail.gmail.com> <20080712030104.GB15838@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 05:44:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHW1w-000638-C2
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 05:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbYGLDmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 23:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752584AbYGLDmI
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 23:42:08 -0400
Received: from george.spearce.org ([209.20.77.23]:49342 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbYGLDmI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 23:42:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2D70E38268; Sat, 12 Jul 2008 03:42:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080712030104.GB15838@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88218>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Mike Ralphson <mike.ralphson@gmail.com> wrote:
> 
> > > I think we are at the point where we need to either write a
> > > #@!*(!@(! command line option parser, import one, or stop writing
> > > command line programs.  I would certainly appreciate any opinion
> > > you might have on the matter.
> > 
> > a) is a distraction, c) is a backwards step, so maybe b) wins.
> 
> So I looked at GNU getopt and its at least smaller than Apache
> Commons,

Probably the state-of-the-arg is args4j:

  https://args4j.dev.java.net/

It uses Java 5 annotations to setup the argument parsing:

  public class SampleMain {

    @Option(name="-r",usage="recursively run something")
    private boolean recursive;

    @Option(name="-o",usage="output to this file",metaVar="OUTPUT")
    private File out = new File(".");

    @Option(name="-str")        // no usage
    private String str = "(default value)";
  ...

I'm usually not a big fan of reflection, but it may make sense to
take advantage of it in a case like this, and just import args4j
into our command line tools.

args4j is provided under the MIT license.

-- 
Shawn.
