From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH v2 2/4] Add git-sequencer prototype documentation
Date: Wed, 9 Jul 2008 07:20:52 +0200
Message-ID: <20080709052052.GA21390@diana.vm.bytemark.co.uk>
References: <1214879914-17866-3-git-send-email-s-beyer@gmx.net> <1215277204-20926-1-git-send-email-s-beyer@gmx.net> <200807081237.51456.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 07:22:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGS8Q-0008EG-VH
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 07:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbYGIFVi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2008 01:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbYGIFVh
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 01:21:37 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3847 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbYGIFVh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 01:21:37 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KGS6n-0005c0-00; Wed, 09 Jul 2008 06:20:53 +0100
Content-Disposition: inline
In-Reply-To: <200807081237.51456.jnareb@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87846>

(I've hijacked this thread and started talking mostly about StGit
instead of git-sequencer; if you're not interested, you can stop
reading now.)

On 2008-07-08 12:37:50 +0200, Jakub Narebski wrote:

> 1. Splitting a patch
>
> I cannot comment well on git-sequencer, as I have started using
> StGIT patch management interface instead of git-rebase in times when
> there were no "git rebase --interactive". Nevertheless working with
> StGIT is a bit similar to working with interactive rebase...
>
> I don't find myself wanting to join two patches into one (to squadh
> a commit) perhaps because when I want to add something to a commit
> (to a patch) I simply go to this patch, edit files, and refresh the
> patch.

You can do this without having to manually go to the right patch with
the -p <patchname> flag to stg refresh. In my experimental branch,
this even works together with path limited refresh, or refresh of just
the index.

My own workflow is different: I generally make a large number of
rather small "work-in-progress" commits without much of a commit
message, and every now and then (while I still have everything in
short-term memory) I use "stg coalesce" to make one or more "real"
patches out of them. Because I've committed such small pieces in the
first place, I rarely need to split a patch.

> From time to time however I find myself SPLITTING a patch, for
> example extracting something added "by the way"/"while at it" into
> separate commit (like late separate better documenting project_index
> file format from adding optional description field to project_index
> file format).

The best way I've found of splitting a patch in StGit is to open the
diff in an Emacs buffer, then pop the patch, and then use Emacs' cool
diff-mode features to apply hunks selectively, split hunks, edit files
in place, etc., and committing at the points where I want patch
boundaries. Occasionally, I'll push and pop the patch to get a new
diff with only the remaining stuff.

I imagine something like this could work without StGit as well, since
it's mostly Emacs doing all the hard work. (And I suppose there are
other tools besides Emacs that can do this?)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
