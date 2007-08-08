From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Re: Workflow question: A case for git-rebase?
Date: Wed, 8 Aug 2007 22:56:33 +0100
Message-ID: <18071eea0708081456l2ff1b73dy90ef33c1b5058c77@mail.gmail.com>
References: <18071eea0708081411p41eaa44ai105adaef0e4b10a5@mail.gmail.com>
	 <Pine.LNX.4.64.0708082246370.21857@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 08 23:56:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IItWA-000486-1r
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 23:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbXHHV4f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 17:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbXHHV4e
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 17:56:34 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:50695 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbXHHV4d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 17:56:33 -0400
Received: by wa-out-1112.google.com with SMTP id v27so335268wah
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 14:56:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g/PGbhw44LSIKYCC8slx48EiQfo/0V2Pbd4gNLn8JMnwKHqHNxFTMNujV+tQDW/YguQ283iJrBwn59gwVO2VEd7UMWCzzGS5yX7IwY8WUvjPFrU114nM4F7vski5dBwIywPWkyVeTkb3oSRT2nJPWIH6YLf+/ei7sVae6MTH9Eg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DNe3Mg4G2I0ZHueN4uayUolUxejGAOL+iuH3/JrCD/tVlJ/dh1m9uRNxmm3UMLyTTkzJ1x9zBt94Poj+pVW816C/2Gj3dtbfkeZ0xsX8E5LXOQx9SLgbOgxrWn4FHEqJtjG3a0o9RljSnWKd6NmcZBBqcZsShkdhL6q0YA3t42I=
Received: by 10.114.175.16 with SMTP id x16mr623323wae.1186610193135;
        Wed, 08 Aug 2007 14:56:33 -0700 (PDT)
Received: by 10.114.135.16 with HTTP; Wed, 8 Aug 2007 14:56:33 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708082246370.21857@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55377>

On 08/08/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 8 Aug 2007, Thomas Adam wrote:
>
> > As for myself, I maintain _locally_ a few branches (branchX, branchY)
> > which dictate some bits and pieces I'm working on.  Periodically, I
> > will tend to merge either merge to master and then push those changes
> > out.  So far so good...
> >
> > But, I've now come up against a case whereby if one of my colleagues
> > changes a file (call it fileA) in branch master, and, in the course of
> > my working in branchX means i modify fileA also, when I come to merge
> > branchX into master I find the original change in master (as submitted
> > by my colleague) being reverted by my changes in branchX.
>
> I have a hard time seeing that.  If you touch the same code,
> unidentically, merge-recursive will not be nice to you: it will show
> conflicts, and you have to resolve them.
>
> Or do you use "-s ours"?

No, nothing like that.  I have had a situation where by a merge from
branchX to master has resulted in master's changes to fileA being
reverted based on what was in the contents of fileA in branchX -- this
is of course wrong though -- master hsa the most recent copy.  My
solution therefore was to cherry pick the commit into branchX and
remerge into master.  This is why I was forced to ask about whether or
not git-rebase was the correct way to go.

Although I suppose this leads me to the ancillory question of:  At the
point I merged master into branchX did this cause any problems for any
future merges of branchX into master?   I cannot recall if this
"revert scenario" I describe to master happened pre or past my merge
of master into branchX, but I suspect it was after I had merged master
into branchX.

-- Thomas Adam
