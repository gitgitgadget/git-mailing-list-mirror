From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Commit signing
Date: Mon, 15 Jan 2007 11:41:43 +0000
Message-ID: <200701151141.51659.andyparkins@gmail.com>
References: <200701151000.58609.andyparkins@gmail.com> <200701151042.12753.andyparkins@gmail.com> <20070115105616.GE12257@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 15 19:13:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6Vbs-0003F1-D3
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:27:04 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9o-0003eK-NS
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbXAOLl7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 06:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbXAOLl7
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 06:41:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:8858 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932242AbXAOLl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 06:41:58 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1326132uga
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 03:41:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=V7UtukzeIaH9QP6CnleahhqjWRRIbBA9PV3I5RcRbvoQpql7CNhnK3aKXFrcJCYxGnKUtLCRumcixkUmuyeJS4LdaA1AjQHdv3bV8MsdMChlSoYQsNgM9vKAfAf6lVgX+ZCC7Bvb6b3mCPCLGGaXGfBWUqhajXDJxtDRq+nueBM=
Received: by 10.66.250.17 with SMTP id x17mr5264568ugh.1168861316932;
        Mon, 15 Jan 2007 03:41:56 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id 27sm6674471ugp.2007.01.15.03.41.54;
        Mon, 15 Jan 2007 03:41:55 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <20070115105616.GE12257@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36819>

On Monday 2007 January 15 10:56, Shawn O. Pearce wrote:


> You can't just clip commits out during a push!  Are you going to
> reject the push because the trusted SSH-logged in maintainer has
> pulled in changes from elsewhere and has decided that they are good
> enough for inclusion?

Yes.

What about this set of repositories

 Central - Maintainer - Lieutenant - Subsystem Maintainer - Idiot - Vandal

While I'm not saying that it should be mandatory, I do think that the central 
repository should have an optional way of stopping the vandal using the 
idiot's repository to push unnoticed bad changes in under somebody else's 
name.  What about:
 * Vandal spends one year developing reasonable relationship with Idiot, all
   patches are good.  Occasional big patches are pulled by Idiot.
 * Vandal prepares extra big series of commits, with ostensibly good
   functionality.  In the middle of large series adds one small commit with
   the committer set to someone other than himself.  In fact, he sets it to be
   someone he doesn't like.
 * Idiot pulls from Vandal's repository.
 * pull, pull, pull, push because we all trust the person we're pulling from.
 * Vandal's changes are now in Central.

> Yes, that's very valid.  But if you trust me and I've gone and
> built 100 commits on top of something I got from someone else I
> trust but that you don't trust, you are going to reject all of my
> changes and ask that I rewrite them?  That's quite paranoid.

Well yes.  I personally wouldn't bother, but I'm casting myself in the role 
of "paranoid" maintainer for this discussion.

The answer is: no, you can't put your 100+X commits in my repository because I 
don't trust the person who wrote X of them.  It is paranoid, and it is 
overkill, but it is also /my/ repository.  It might also be that you are my 
employee and you will do as you are damn well told.

I'm arguing that git should cater for the borderline sociopath as well as the 
well adjusted developer as well.  After all, PHB's need version control 
too :-)

> the author field to anything you want; indeeded I often copy in
> changes from other people and mark them as the author will retaining
> the committer line as myself.

In the case above, it is the distributed nature of git that causes the 
problem, the original comitter is Idiot, but the repository that the changes 
use to get into central is Maintainer's.

This has spiralled more than I ever intended anyway.  You (and Johannes) have 
answered my question: namely that there isn't an easy way to do it (with a 
commit script) and that it's not really a major issue anyway.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
