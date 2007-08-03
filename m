From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Re: cvs2svn conversion directly to git ready for experimentation
Date: Fri, 3 Aug 2007 11:41:02 -0400
Message-ID: <9e4733910708030841r31175efg4ea4ea41e852ab2@mail.gmail.com>
References: <46B2E8F3.30301@alum.mit.edu>
	 <0BB549C6E74E24409FB20B3B1D1B6644029461C0@ATL1EX11.corp.etradegrp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Michael Haggerty" <mhagger@alum.mit.edu>,
	"Martin Langhoff" <martin.langhoff@gmail.com>,
	"Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>,
	git@vger.kernel.org, users@cvs2svn.tigris.org
To: "Patwardhan, Rajesh" <rajesh.patwardhan@etrade.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 17:41:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGzH2-0003mS-TT
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 17:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762259AbXHCPlF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 11:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762231AbXHCPlF
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 11:41:05 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:36867 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757329AbXHCPlD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 11:41:03 -0400
Received: by wa-out-1112.google.com with SMTP id v27so881836wah
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 08:41:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MZJis0oyTZzGSjZRK7J0uQW3l13W0n5Y+spv3zQTI1EiJEG1BPliFoTSAxkatGSkN3EgvhDM9/4p7CEGe77tQgPhSqV1Jbtn/Jx9/iyt9sT5kJnBeIKciBhjL0MAegVjfL0xmnSXL0ng9NLm8jbbr6k1el+Ri+32pjydfN+GW4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NUauiqhg5BpexnbhNpwU+lJ43xLrN95q1SPyIAHiMZGUdKSDaqvchcMPGDr7c6MA/7SdQhRKkYc349vVucE1hQQhXq//E4xx7aJ12/+o9LaTKvy56BDNpb6BwS5DmYy/iCkE4Brv3XKAWWvVS9IEESFDE5DQsWeBl3Mx5WZWM/s=
Received: by 10.114.176.1 with SMTP id y1mr3074343wae.1186155662998;
        Fri, 03 Aug 2007 08:41:02 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Fri, 3 Aug 2007 08:41:02 -0700 (PDT)
In-Reply-To: <0BB549C6E74E24409FB20B3B1D1B6644029461C0@ATL1EX11.corp.etradegrp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54731>

On 8/3/07, Patwardhan, Rajesh <rajesh.patwardhan@etrade.com> wrote:
>
> Hello Michael,
> I will explain a scenario (we are passing thru this right now)
> 1) you have 10 years worth of cvs data.
> 2) We want to move to svn.
> 3) The repository move should be in such a way that the development does
> not get hampered for any 1 work day.
> 4) We have atleast 4 major modules in cvs which takes about 30 - 40
> hours each for conversion currently.

There are known ways (that haven't been implemented) to get the 40 hr
number down to 1/2 hour. Would that be a better approach than doing
incremental imports?

> 5) With increamental conversions we can do a few things ...
>         A) Keep the downtime for hard cutoff minimal
>         B) try out the svn move for other auxillary tools that are
> needed by the SCM process.
>         C) Do some meaningful testing and validation with simulated live
> moves of changes from cvs to svn before the actual move on a day to day
> basis.
>
> Hopefuly this would substantiate the request \ need for increamental
> moves. Or if someone out there has a better suggestion for such
> scenario's please point me in the right direction.
>
> Regards,
> Rajesh
>
> -----Original Message-----
> From: Michael Haggerty [mailto:mhagger@alum.mit.edu]
> Sent: Friday, August 03, 2007 1:36 AM
> To: Martin Langhoff
> Cc: Guilhem Bonnefille; git@vger.kernel.org; users@cvs2svn.tigris.org
> Subject: Re: cvs2svn conversion directly to git ready for
> experimentation
>
> Martin Langhoff wrote:
> > Is there any way we can run tweak cvs2svn to run incrementals, even if
>
> > not as fast as cvsps/git-cvsimport? The "do it remotely" part can be
> > worked around in most cases.
>
> I don't see any fundamental reason why not, but I think it would be a
> significant amount of work.  There are two main issues:
>
> 1. With CVS, it is possible to change things retroactively, such as
> changing which version of a file is included in a tag, or adding a new
> file to a tag, or changing whether a file is text vs. binary.  And many
> people copy and/or rename files within the CVS repository itself (to get
> around CVS's inability to rename a file).  This makes it look like the
> file has *always* existed under the new name and *never* existed under
> the old name.  An incremental conversion tool would have to look
> carefully for such changes and either handle them properly or complain
> loudly and abort.
>
> 2. cvs2svn uses a lot of repository-wide information to make decisions
> about how to group CVSItems into changesets, and a lot of these
> decisions are based on heuristics.  Incremental conversion would require
> that the decisions made in one cvs2svn run are recorded and treated as
> unalterable in subsequent runs.
>
> This hasn't been a priority in the Subversion world, because, frankly,
> what reason would a person have to stick with CVS instead of switching
> to Subversion, given that (1) they are intentionally so similar in
> workflow, an (2) there is no significant competition from other
> centralized SCMs?  But of course until the distributed SCM playing field
> has been thinned out a bit, people will probably be reluctant to commit
> to one or the other.
>
> I don't expect to have time to implement incremental conversions in
> cvs2svn in the near future.  (I'd much rather work on output back ends
> to other distributed SCMs.)  But if any volunteers step forward (hint,
> hint) I would be happy to help them get started and answer their
> questions.  I think that cvs2svn is quite hackable now, so the learning
> curve is hopefully much less frightening than when I started on the
> project :-)
>
> Michael
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: users-unsubscribe@cvs2svn.tigris.org
> For additional commands, e-mail: users-help@cvs2svn.tigris.org
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Jon Smirl
jonsmirl@gmail.com
