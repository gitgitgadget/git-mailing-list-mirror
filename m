From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git.git (Oct 2009, #01; Wed, 07)
Date: Thu, 8 Oct 2009 10:39:00 -0700
Message-ID: <20091008173900.GI9261@spearce.org>
References: <7viqeqjsx6.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910080848380.4985@pacific.mpi-cbg.de> <fabb9a1e0910072349q68d6756cgebb041a0bbe2ba65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 19:43:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mvx10-0005Zz-9D
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 19:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759071AbZJHRjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 13:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758996AbZJHRjh
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 13:39:37 -0400
Received: from george.spearce.org ([209.20.77.23]:45245 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758936AbZJHRjh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 13:39:37 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 93A95381FE; Thu,  8 Oct 2009 17:39:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <fabb9a1e0910072349q68d6756cgebb041a0bbe2ba65@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129708>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Thu, Oct 8, 2009 at 08:49, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Shawn, last time I heard of this issue, it was stuck in your review queue.
> 
> Correct, am waiting for Shawn's decision on whether to drop options
> and replace them with additional features or not.

Uh.  Wow, it has been a while.

IIRC my problem with options was we weren't enforcing them, and yet
they were necessary for a successful import, e.g. import-marks or
export-marks.  A minor error could cause a successful looking import
that is wrong due to the marks being messed up, or not saved out.

So I was leaning towards making these features, but then they
aren't necessarily compatible with the other fast-import tools.
Which led me to a stalemate, and I forgot about the thread.

Dammit.

We should run this past the fast-import list but I think we want
to declare features for import-marks and export-marks:

  feature import-marks=in.marks
  feature export-marks=out.marks

and define these as paths to local files which store a VCS specific
formatted mapping of fast-import mark numbers to VCS labels.


Other options that are clearly git should be declared as:

  option git max-pack-size=2048

with the meaning of option being declared something like:

  If the parsing VCS name appears as the first argument, the parsing
  VCS must recognize and support the supplied option, and if not
  recognized or not supported must abort parsing altogether.

  If the parsing VCS name is not the first argument, it must entirely
  ignore the option command and not try to process its contents.

-- 
Shawn.
