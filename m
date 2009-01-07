From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH/RFC] Allow writing loose objects that are corrupted in a
 pack file
Date: Tue, 06 Jan 2009 21:09:58 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901062059230.26118@xanadu.home>
References: <20081209093627.77039a1f@perceptron>
 <1231282320.8870.52.camel@starfruit>
 <alpine.LFD.2.00.0901062005290.26118@xanadu.home>
 <1231292360.8870.61.camel@starfruit>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_pyyqjBo0kbSv/pCCyI9ypg)"
Cc: =?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 03:11:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKNtF-0007Tg-Mb
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 03:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759497AbZAGCKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 21:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759493AbZAGCKF
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 21:10:05 -0500
Received: from relais.videotron.ca ([24.201.245.36]:20460 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759492AbZAGCKE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 21:10:04 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KD200K9MWOM51G0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 06 Jan 2009 21:09:58 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1231292360.8870.61.camel@starfruit>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104746>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_pyyqjBo0kbSv/pCCyI9ypg)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Tue, 6 Jan 2009, R. Tyler Ballance wrote:

> On Tue, 2009-01-06 at 20:25 -0500, Nicolas Pitre wrote:
> > On Tue, 6 Jan 2009, R. Tyler Ballance wrote:
> > 
> > > On Tue, 2008-12-09 at 09:36 +0100, Jan Krüger wrote:
> > > > For fixing a corrupted repository by using backup copies of individual
> > > > files, allow write_sha1_file() to write loose files even if the object
> > > > already exists in a pack file, but only if the existing entry is marked
> > > > as corrupted.
> > > 
> > > I figured I'd reply to this again, since the issue cropped up again.
> > > 
> > > We started experiencing *large* numbers of corruptions like the ones
> > > that started the thread (one developer was receiving them once or twice
> > > a day) with v1.6.0.4
> > > 
> > > We went ahead and upgraded to a custom build of v1.6.1 with Jan's patch
> > > (below) and the issues /seem/ to have resolved themselves. I'm not
> > > certain whether Jan's patch was really responsible, or if there was
> > > another issue that caused this to correct itself in v1.6.1. 
> 
> I'll back the patch out and redeploy, it's worth mentioning that a
> coworker of mine just got the issue as well (on 1.6.1). He was able to
> `git pull` and the error went away, but I doubt that it "magically fixed
> itself"

Please describe the "issue", ideally with transcripts of error messages, 
etc.  Normally a simple pull operation should not provide any "fix" for 
corruptions.

> I highly doubt this, I've got the issue appearing on at least 7
> different development boxes (not workstations, 2U quad-core ECC RAM, etc
> machines), while that doesn't mean that they all don't have issues, the
> probability of them *all* having disk issues, and it somehow only
> manifesting itself with Git usage, is low ;)

Agreed.

> I've tarred one of the repositories that had it in a reproducible state

That is wonderful.

> so I can create a build and extract the tar and run against that to
> verify any patches anybody might have, but unfortunately at 7GB of
> company code and assets, I can't exactly share ;)

First step is to understand what is going on.  Only then could reliable 
patches be made.


Nicolas

--Boundary_(ID_pyyqjBo0kbSv/pCCyI9ypg)--
