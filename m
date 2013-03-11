From: Vadim Zeitlin <vz-git@zeitlins.org>
Subject: Re: Rewriting references to existing commits in commit messages with filter-branch
Date: Mon, 11 Mar 2013 14:05:46 +0000 (UTC)
Message-ID: <loom.20130311T145745-986@post.gmane.org>
References: <E1UF1Ag-0006m3-5k@smtp.tt-solutions.com> <513DE1E8.7010302@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 11 15:06:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF3N2-0006wP-A0
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 15:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352Ab3CKOGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 10:06:05 -0400
Received: from plane.gmane.org ([80.91.229.3]:53976 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872Ab3CKOGE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 10:06:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UF3Ms-0006pi-37
	for git@vger.kernel.org; Mon, 11 Mar 2013 15:06:22 +0100
Received: from ip-208.net-89-3-60.rev.numericable.fr ([89.3.60.208])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 15:06:22 +0100
Received: from vz-git by ip-208.net-89-3-60.rev.numericable.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 15:06:22 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 89.3.60.208 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:19.0) Gecko/20100101 Firefox/19.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217876>

Michael Haggerty <mhagger <at> alum.mit.edu> writes:

> 
> On 03/11/2013 12:45 PM, Vadim Zeitlin wrote:
> > [...]
> >  The first thing I'd like to do is to replace all references to subversion
> > revision numbers in the commit messages with the corresponding git commit
> > SHA1s. [...] I have a couple of dozens of errors which happen
> > because the file .git-rewrite/map/$commit doesn't exist yet when I'm trying
> > to look it up.
> 
> The quick and dirty solution would be to rewrite your script such that
> if the commit is still unknown to Git, it emits a warning and leaves the
> commit message unchanged (i.e., leaves the Subversion revision number
> untouched).  Then simply run the filter-branch a few times until it
> emits no warnings.

 Thanks, I did think about this but the trouble is that after the first rewrite
"git svn find-rev" wouldn't work any more, so I'd have to do the substitutions
manually. Which might be doable as there are not that many of them but, if
possible, I'd rather do it automatically.

 FWIW I'm playing with --date-order now (thanks Thomas) but somehow it seems to
create other problems while fixing (some of) the existing ones. I need to look
at this more closely to understand what's going on here...

VZ
