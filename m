From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: git pull --rebase and losing commits
Date: Tue, 3 Nov 2009 11:12:13 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0911031103450.19057@ds9.cixit.se>
References: <alpine.DEB.2.00.0911021318400.3919@ds9.cixit.se> <20091102151022.GA3995@atjola.homenet> <alpine.DEB.2.00.0911030757400.15633@ds9.cixit.se> <alpine.DEB.1.00.0911031047510.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 03 11:12:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5GNR-0008E3-Vh
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 11:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756514AbZKCKMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 05:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756482AbZKCKMP
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 05:12:15 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:40469 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756290AbZKCKMO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 05:12:14 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id nA3ACEV8006469
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 3 Nov 2009 11:12:14 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id nA3ACEuD006464;
	Tue, 3 Nov 2009 11:12:14 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.DEB.1.00.0911031047510.4985@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Tue, 03 Nov 2009 11:12:14 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131960>

Johannes Schindelin:

>> Sounds like it should be called "theirs", then.
> Why should it be called "theirs" when it takes "ours"?

Because it took "their" (= upstream) tree, not "our" (= local branch) tree.

Seems to me the name is a bit confusing in the case of a rebase, as I am 
"merging" my changes *onto* the upstream, not the other way round as would 
be the case with a regular merge.

> Note: the thing I think Thomas wanted to clarify is that this strategy 
> does not _resolve conflicts_ to "our" version, but it just outright 
> ignores "theirs".  IOW, after a merge with the "ours" strategy, 
> "HEAD^{tree}" and "HEAD^^{tree}" will point to _exactly the same object_.

And in the case of a rebase, the other way around: With --rebase 
--strategy=ours, I am basically asking to throw all my local commits away?

> If you want to use any merge strategy, you must understand what it does 
> first.  There is no way around that.  No change in UI, or in the core code 
> of Git, can relieve you of this obligation.

No, that is why I recommended that what needed clarification was the 
documentation. I read the documentation of "ours":

   "This resolves any number of heads, but the result of the merge is
    always the current branch head. It is meant to be used to
    supersede old development history of side branches."

and thought that it meant that it

a) could resolve a merge conflict, no matter the number of branches involved 
("resolves any number of heads").
b) would replace any merge conflict with the contents in the current 
repository's branch ("result of the merge is always the current branch head").

Apparently, the "used to supersede old development history" means that it 
actually throws the entire contents of one of the branches out, which is not 
what I wanted. I didn't understand that from the documentation, however.

-- 
\\// Peter - http://www.softwolves.pp.se/
