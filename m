From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Fri, 3 Aug 2007 16:16:23 -0400
Message-ID: <9e4733910708031316x1b7d2a40n5d0298cedd6cf97c@mail.gmail.com>
References: <46B2E8F3.30301@alum.mit.edu>
	 <0BB549C6E74E24409FB20B3B1D1B6644029461C0@ATL1EX11.corp.etradegrp.com>
	 <9e4733910708030841r31175efg4ea4ea41e852ab2@mail.gmail.com>
	 <46B37ADB.8020103@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Patwardhan, Rajesh" <rajesh.patwardhan@etrade.com>,
	"Martin Langhoff" <martin.langhoff@gmail.com>,
	"Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>,
	git@vger.kernel.org, users@cvs2svn.tigris.org
To: "Michael Haggerty" <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Aug 03 22:16:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH3Zb-00071F-Hp
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 22:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763588AbXHCUQb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 16:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763095AbXHCUQa
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 16:16:30 -0400
Received: from rv-out-0910.google.com ([209.85.198.185]:38284 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762700AbXHCUQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 16:16:29 -0400
Received: by rv-out-0910.google.com with SMTP id k20so756652rvb
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 13:16:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uhYokHCR0QQTjZ6l7ef4goY5aSuSB5qForef/eFEtdLTLhER8MvFuDVkB7D7no2fGP1ycXcgDpelQRajagzHTOedynv1io/E1gYVZWB8fERpeP7U/F+w5wf98Jf+j830pok97x4PDdMhLwfpLgoq8O8LRgJ5kBSq28PDwfIPT80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MjkjnI+GmnmBPThxr/T1U0X3pWrVSwAW1jzpkrHZOmjF8ribcZGTPWkz4btvXQPLV2DhSfnPyvdryDSQayn1mq4X/P4giHEyPi+jIYNvqcPq/exZ+PZ1lif3N8+Q5IvJVnbwOSll9yNtca3uViNbT6oe5hLlRyyo6VXqXhVTWyQ=
Received: by 10.115.110.6 with SMTP id n6mr3300560wam.1186172188527;
        Fri, 03 Aug 2007 13:16:28 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Fri, 3 Aug 2007 13:16:23 -0700 (PDT)
In-Reply-To: <46B37ADB.8020103@alum.mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54751>

On 8/3/07, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> [I set followup-to users@cvs2svn.tigris.org, since this has nothing to
> do with git.]
>
> Jon Smirl wrote:
> > On 8/3/07, Patwardhan, Rajesh <rajesh.patwardhan@etrade.com> wrote:
> >> Hello Michael,
> >> I will explain a scenario (we are passing thru this right now)
> >> 1) you have 10 years worth of cvs data.
> >> 2) We want to move to svn.
> >> 3) The repository move should be in such a way that the development does
> >> not get hampered for any 1 work day.
> >> 4) We have atleast 4 major modules in cvs which takes about 30 - 40
> >> hours each for conversion currently.
> >
> > There are known ways (that haven't been implemented) to get the 40 hr
> > number down to 1/2 hour. Would that be a better approach than doing
> > incremental imports?
>
> Jon, I would like very much to hear how you propose to get an 60-fold
> speed increase in cvs2svn.  I've never heard of any plausible way to
> accomplish anything even close to this.
>
> Please note that the user wants to convert to Subversion, not git.  But
> even converting to git, I don't think that such speeds are possible
> without massive changes that would include processing everything in RAM
> and switching large parts of cvs2svn from Python to a compiled language.

Make a bulk importer for SVN like git-fastimport. I measured some SVN
imports and the bulk of the time was spent forking off SVN. Before
git-fast import it would have taken git two weeks to import Mozilla
CVS.

>
> Michael
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
