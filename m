From: Mike Jarmy <mjarmy@gmail.com>
Subject: Commiting changes onto more than one branch
Date: Wed, 25 Nov 2009 11:31:59 -0500
Message-ID: <6b4a562b0911250831q332ac3b5m6ee38f59e7a6f391@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 17:32:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDKmm-00087U-O9
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 17:32:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758824AbZKYQbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 11:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758468AbZKYQbz
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 11:31:55 -0500
Received: from gv-out-0910.google.com ([216.239.58.186]:55828 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758099AbZKYQby (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 11:31:54 -0500
Received: by gv-out-0910.google.com with SMTP id r4so751103gve.37
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 08:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=Gv0R6dGI5in+4im5YUBWI7prwlB4lUT/S1SFysLzy3Q=;
        b=cw0D4Ax1UqUkmlGWTHHd7LSZLy3dPq0IqAXomFw3IP7BUci68cuUwRLatvUvFgVDpk
         sJTgXhOIyRZUxHMAVMqy8ffOHN/Fq4aQ0nFGdWlLac8Ts5o4QjPv/RAaQwBC+d17bdQJ
         aAUnufCfLwGE9cMnA7kH9Jx6VSLFoTZTwvZR8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=mbNGCeeWnYUM9xV9asN5+r+DBmcfdS4kT/FmG6ma+pJdntvGPkLOZlfSK7GGwE+RMT
         KqXa9LpIiC30OlgSFEg/hZUTTp8a93VQ+OawgiyADBJ+lV9nyqVickzNhpQX68H58Dus
         qSUFEVez0sRaBa3DKKHgTarfFZWPVGc9Rr4DI=
Received: by 10.103.125.19 with SMTP id c19mr3406052mun.59.1259166719983; Wed, 
	25 Nov 2009 08:31:59 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133648>

Hi,

At my day job, I'm doing the groundwork for recommending that we
switch to a DVCS from a proprietary centralized VCS.  I find git's
branching ability very compelling, and I think we would use it
extensively.  I work on a very large project (many thousands of files)
that has been around for many years, and has had several different
releases.  Right now, each release has its own top level directory,
but I'd like to change that so we use branches instead, out of one
great big git repository.  My plan is to set up the repository such
that the initial state at switchover will have a branch for the
current state of each of our releases.  Lets say that the branches for
each release are called v1, v2, etc.

My question is this:  How do I manage a checkin for a bugfix that
affects, say, only branches v3, v4, and v5?

Suppose that I checkout the v3 branch, and fix the bug by editing
several different files.  (Lets assume for now that the files in
question have not diverged between any of the 3 branches, even though
tons of other files have changed).  How do I commit the bugfix into
all of v3, v4 and v5?  Clearly, merging the branches together would be
bad.  So I think what I should do is perform 3 different commits, but
I'm not quite sure how to juggle the git index (or stash or whatever)
to accomplish this.  This may be a really obvious question, but I'm a
confused git newbie.

Also, even though I may need to do 3 commits, it would be nice if the
commits were related together in some way, since in a sense they
represent only one action (namely, fixing the bug).  Is there a way to
do that, so that its clear in gitk that it was really one unified
thing?  The very worst thing about our current VCS is that it has no
concept of a 'commit', only individual file histories.  Git would fix
that for us, but it would be nirvana if we could group commits for a
given bugfix across branches somehow, while not merging the branches
together.

One last question -- lets make the problem slightly more complicated
by specify that some of the edited files changed between, say, v4 and
v5.  I know how to handle a simple merge conflict in git, but is there
anything different about my multi-branched, grouped-together case
here?  The answer to this question may be obvious once I understand
how to do the simpler, unconflicting checkin.

Thanks,
Mike Jarmy
