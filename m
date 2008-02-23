From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: Question about your git habits
Date: Fri, 22 Feb 2008 20:28:18 -0500
Message-ID: <20080223012818.GA27745@dervierte>
References: <200802221837.37680.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chase Venters <chase.venters@clientec.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 02:28:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSjCE-0005hT-Le
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 02:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbYBWB2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 20:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752994AbYBWB2X
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 20:28:23 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:21579 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbYBWB2W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 20:28:22 -0500
Received: by an-out-0708.google.com with SMTP id d31so165453and.103
        for <git@vger.kernel.org>; Fri, 22 Feb 2008 17:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=OjGqFTDzoYjliVivAEwLV0NkXAF9Gd44SFEXqLH9/74=;
        b=Se7tJCy56NxJTrlhDj95UdAuGPGbv5jXX4h9zcHD0hRx2jzwIS//qwLwG2JLJhtVLQoV/S0TxcY5aFi7Gx8TRUKk26VWl1Tkm5D7NlGwFaavnvgbu0D4v4MIPgVxC6XlM/+3H3PWCNVhZCkqAFgNN8vZETyzJlaYy215IZtj1xg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Pi1j1zOJrJGsCGqUrL/tm5GppXWZV2gei9tmCNIlQty5xpCACU9yucHWHlwnC2F/XcTZpR4rqeuwTUExPySLfdTIwfZs7TVVStvtCI5I+us5BEK6qnmXNhrn9cY+k4xYOggDL5VZPaVniq6GqDISNWgMDL8WsnqGR/lItTAZ45c=
Received: by 10.100.125.12 with SMTP id x12mr1474713anc.84.1203730101316;
        Fri, 22 Feb 2008 17:28:21 -0800 (PST)
Received: from dasbrennen.isa-geek.org ( [76.177.39.93])
        by mx.google.com with ESMTPS id 35sm2444799wra.21.2008.02.22.17.28.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Feb 2008 17:28:20 -0800 (PST)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id ECFB940E1; Fri, 22 Feb 2008 20:28:18 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200802221837.37680.chase.venters@clientec.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74778>

On Fri, Feb 22, 2008 at 06:37:14PM -0600, Chase Venters wrote:
> My question is: If you're working on multiple things at once, do you tend to 
> clone the entire repository repeatedly into a series of separate working 
> directories and do your work there, then pull that work (possibly comprising 
> a series of "temporary" commits) back into a separate local master 
> respository with --squash, either into "master" or into a branch containing 
> the new feature?
> 
> Or perhaps you create a temporary topical branch for each thing you are 
> working on, and commit arbitrary changes then checkout another branch when 
> you need to change gears, finally --squashing the intermediate commits when a 
> particular piece of work is done?

I favor the second approach: single working copy, multiple branches.  My
feeling is that wanting multiple workspaces is a holdover from using
subversion.  For me, it is much faster to "git commit -a -m wip"
and then switch branches, than it would be to clone a whole new
repository and manage the inter-repository relationships.

Don't get so down on the "intermediate commits," either.  For one,
whenever I switch back to a branch with a "wip" commit, I usually do a
"git reset HEAD^" to remove it and get my working tree back where it
was.  There are also nifty tools like interactive rebase that assist
you in rewriting history to produce a set of clean, atomic commits.
It's not imperative to make your first draft perfection in git.

[...]

> Insight appreciated, and I apologize if I've failed to RTFM somewhere.

No worries, I remember being in your situation once.  git opens up
a host of opportunities with its flexibility, and getting started I
was consistently stumped by which of the many paths I should choose.
-- 
-Steven Walter <stevenrwalter@gmail.com>
Freedom is the freedom to say that 2 + 2 = 4
B2F1 0ECC E605 7321 E818  7A65 FC81 9777 DC28 9E8F 
