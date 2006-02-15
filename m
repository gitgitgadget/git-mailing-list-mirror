From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Tue, 14 Feb 2006 23:11:42 -0500
Message-ID: <20060215041142.GA21048@fieldses.org>
References: <20060210211740.GO31278@pasky.or.cz> <20060213210001.GA31278@pasky.or.cz> <tnxoe1aqoj2.fsf@arm.com> <20060214100844.GA1234@diana.vm.bytemark.co.uk> <43F1F5CB.10402@citi.umich.edu> <20060214160747.GA6350@diana.vm.bytemark.co.uk> <43F2445A.6020109@citi.umich.edu> <20060214222913.GK31278@pasky.or.cz> <43F2745D.4010800@vilain.net> <20060215003510.GA25715@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Feb 15 05:12:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9E1I-00034U-FB
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 05:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422685AbWBOEL6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 23:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422689AbWBOEL6
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 23:11:58 -0500
Received: from mail.fieldses.org ([66.93.2.214]:64429 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1422685AbWBOEL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 23:11:57 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1F9E11-0006MN-0n; Tue, 14 Feb 2006 23:11:43 -0500
To: Sam Vilain <sam@vilain.net>, Petr Baudis <pasky@suse.cz>,
	Chuck Lever <cel@citi.umich.edu>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060215003510.GA25715@spearce.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16210>

On Tue, Feb 14, 2006 at 07:35:10PM -0500, Shawn Pearce wrote:
> Publishing a repository with a stg (or pg) patch series isn't
> a problem; the problem is that no clients currently know how to
> follow along with the remote repository's patch series.  And I can't
> think of a sensible behavior for doing so that isn't what git-core is
> already doing today for non patch series type clients (as in don't go
> backwards by popping but instead by pushing a negative delta).  :-)

If you represent each patch as a branch, with each modification to the
patch a commit on the corresponding branch, and each "push" operation a
merge from the branch corresponding to the previous patch to a branch
corresponding to the new patch (isn't that what pg's trying to do?),
then it should be possible just to track the branch corresponding to the
top patch.

In theory I guess it should also be possible to merge patch series that
have followed two lines of development, by merging each corresponding
branch.

The history would be really complicated.  You'd need to figure out how
to track the patch comments too, and you'd need scripts to convert to
just a simple series of commits for submitting upstream.  Probably not
worth the trouble, but I don't know.

If you really want revision control on patches the simplest thing might
be just to run quilt or Andrew Morton's scripts on top of a git
repository--the documentation with Andrew's scripts recommends doing
that with CVS.

--b,
