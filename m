From: Johan Herland <johan@herland.net>
Subject: Re: Empty directories...
Date: Fri, 20 Jul 2007 15:20:55 +0200
Message-ID: <200707201520.55911.johan@herland.net>
References: <85lkdezi08.fsf@lola.goethe.zz> <200707201418.26534.johan@herland.net> <86odi7utdj.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jul 20 15:21:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBsPr-00030H-OT
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 15:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590AbXGTNVE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 09:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754822AbXGTNVD
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 09:21:03 -0400
Received: from sam.opera.com ([213.236.208.81]:37183 "EHLO sam.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754441AbXGTNVB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 09:21:01 -0400
Received: from pc166.lan019.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by sam.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l6KDKuGx030932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 20 Jul 2007 13:20:56 GMT
User-Agent: KMail/1.9.7
In-Reply-To: <86odi7utdj.fsf@lola.quinscape.zz>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.90.1/3704/Fri Jul 20 11:30:16 2007 on sam.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53091>

On Friday 20 July 2007, David Kastrup wrote:
> Johan Herland <johan@herland.net> writes:
> 
> > AFAICS, from a high-level POV, we're pretty much in agreement on the
> > following points:
> >
> > 1. Git should be able to track directories.
> >
> > 2. Tracked directories should be kept alive, even if empty.
> >
> > 3. Git must not necessarily track _all_ directories.
> >
> >
> > Conversely, we seem to disagree on these points:
> >
> > 4. Whether or not git should track directories by default. You say
> > yes, I say no.
> 
> Element of least surprise.  But since my proposal allows easy and
> intuitive declaration of the preference at user, project, and
> directory level without one choice messing with the choice of other
> projects and contributors with mixed preferences, this is quite
> unimportant.
> 
> We are in agreement that adding or removing the tracking explicitly
> for a single directory might be useful to have.  But it can't be the
> only way.

As long as you can add/remove tracking recursively for a whole (sub)tree, I 
don't see what's the problem. Of course, if you want to change the default 
behaviour, you should be able either set a config variable somewhere, or - as 
a last resort - alias git-add and git-rm to always supply the appropriate 
command-line option.

> > 5. How the tracking of directories should be implemented in git's
> > object database. I want to keep the index/tree as-is except for
> > adding directory entries (w/mode 040000) for the tracked directories
> > only. You seem to want to add directory entries for _all_
> > directories and then additional "." entries for directories you
> > don't want deleted if/when empty.
> 
> No.  I don't want to change _anything_ for untracked directories.
> They are, as previously, implied by the contents and have a "tree"
> entry for efficiency reasons.  Nothing new here.
> 
> The directory mode entries are named "." and are for tracked
> directories only.

Ok. So our difference in opinion on implementation is even smaller than I 
imagined; basically only whether the directory is tracked by a mode "040000" 
entry, or by a "." entry.

> > Am I making sense, or have I misunderstood our misunderstandings?
> 
> The latter.  You are violently arguing for what I outlined.  Which
> probably shows that I am not the best at explaining my ideas, and that
> it reflects badly upon them.

That probably goes for both of us :)


Well, as long as we have this clarified, I don't see much point in continuing 
this part of the thread. I feel confident that the git community as a whole 
will converge on the best technical solution, once it surfaces.


Have fun!

...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
