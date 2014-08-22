From: Matthias Urlichs <matthias@urlichs.de>
Subject: Re: Shallow clones with explicit history cutoff?
Date: Fri, 22 Aug 2014 16:46:45 +0200
Message-ID: <20140822144645.GS2049@smurf.noris.de>
References: <loom.20140821T171416-31@post.gmane.org>
 <CACsJy8CSCcaFNxqqBLAnb5NXkwT+wVXCVmB8uF3RYwqRmz4tuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 17:05:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKqPK-0000vM-Ju
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 17:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756580AbaHVPFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 11:05:34 -0400
Received: from netz.smurf.noris.de ([213.95.21.43]:39765 "EHLO
	netz.smurf.noris.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756340AbaHVPFe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 11:05:34 -0400
X-Greylist: delayed 1079 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Aug 2014 11:05:33 EDT
Received: from [2001:780:107:0:1278:d2ff:fea3:d4a6] (helo=smurf.noris.de)
	by netz.smurf.noris.de with smtp (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <matthias@urlichs.de>)
	id 1XKq74-0004MR-57; Fri, 22 Aug 2014 14:46:48 +0000
Received: (nullmailer pid 17017 invoked by uid 501);
	Fri, 22 Aug 2014 14:46:45 -0000
Content-Disposition: inline
In-Reply-To: <CACsJy8CSCcaFNxqqBLAnb5NXkwT+wVXCVmB8uF3RYwqRmz4tuw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Smurf-Spam-Score: -1.1 (-)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255676>

Hi,

Duy Nguyen:
> On Thu, Aug 21, 2014 at 10:39 PM, Matthias Urlichs <matthias@urlichs.de> wrote:
> > What I would like to have, instead, is a version of shallow cloning which
> > cuts off not at a pre-determined depth, but at a given branch (or set of
> > branches). In other words, given
> >
> >             +-J--K  (packaged)
> >            /    /
> >   +-F--G--H----I    (clean)
> >  /       /
> > A---B---C---D---E   (upstream)
> >
> > a command "git clone --shallow-until upstream $REPO" (or however that would
> > be named) would create a shallow git archive which contains branches
> > packaged+clean, with commits FGHIJK. In contrast, with --single-branch and
> > --depth 4 I would get CGHIJK, which isn't what I'd want.
> 
> I would imagine a more generic mechanism "git clone
> --shallow-rev=<rev> $REPO" where you could pass anything that "git
> rev-list" can accept (maybe more restricted, and some verification
> required). --shallow-rev could be repeated. So in your case it could
> be "git clone --shallow-rev="^A" $REPO".

Umm, no. ^E (or ^upstream) would do what I want. Hopefully. ;-)

But you're right, that would fit far better into the existing git
paradigms.

> > As I have not spent too much time with the git sources lately (as in "None
> > at all"), some pointers where to start implementing this would be
> > appreciated, assuming (a) this has a reasonable chance of landing in git and
> > (b) nobody beats me to it. ;-)
> 
> I'd like to see this implemented. You are not the first one
> complaining about the (lack of) flexibility of --depth. If you have
> time, I may be able to support (I should not take on another topic
> given my many ongoing/unfinished topics).

Welcome to the club. :-/

Thanks for the pointers. I'll see what I can do (and when).

-- 
-- Matthias Urlichs
