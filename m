From: Liam Clarke <liam.clarke-hutchinson@adscale.co.nz>
Subject: Re: git merge auto-commit doesn't fire pre-commit hook
Date: Thu, 17 Feb 2011 17:44:43 +1300
Message-ID: <6F190320-19AF-4F4A-9AE9-0DDA0839C5FD@adscale.co.nz>
References: <1F3B7FF9-6348-4197-A6B7-23C4DA144920@adscale.co.nz> <AANLkTimCdQL879kBZiktB49eSvoAGT0pX5DKX0SHFOVB@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 05:45:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppvjj-0001qM-Jh
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 05:45:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649Ab1BQEou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 23:44:50 -0500
Received: from 85.25.69.111.dynamic.snap.net.nz ([111.69.25.85]:53728 "EHLO
	mail.toc.org.nz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752621Ab1BQEos convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 23:44:48 -0500
Received: from imac24.toc.org.nz (imac24.toc.org.nz [10.13.11.74])
	by mail.toc.org.nz (Postfix) with ESMTP id 0EA95282E609;
	Thu, 17 Feb 2011 17:44:44 +1300 (NZDT)
In-Reply-To: <AANLkTimCdQL879kBZiktB49eSvoAGT0pX5DKX0SHFOVB@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167037>

Cheers Jay.

> The bypassing of pre-commit hook was and remains to be a conscious design
decision.  

That doesn't sound good for my purposes. It also renders Git merge behaviour significantly surprising. :(

>  When you are pulling from your contributors who may have
objectionable contents that you have to merge, the damage is already
done; you _could_ yell at them to fix their branch and re-pull in theory,
but that wouldn't work very well in practice.

What about when I'm merging my own feature branches into master? Also, past performance indicates that yelling about bad stuff in merges works quite well when they're in the same office as you... 

...but anyway, thanks for the heads up Jay. 

On 17/02/2011, at 5:36 PM, Jay Soffian wrote:

> On Wed, Feb 16, 2011 at 5:49 PM, Liam Clarke
> <liam.clarke-hutchinson@adscale.co.nz> wrote:
>> How exactly does git merge execute the commit?
> 
> Merge calls commit_tree directly, so the standard commit hooks are bypassed.
> 
>> Does it use --no-verify at all? I've got a pre-commit hook to filter out testing data when merging into master, and if you merge with --no-commit, and then manually commit, the hook fires fine, but when merge autocommits, the hook doesn't get executed at all. Is there any other way to catch this event? I can add --no-commit to the branch.master.mergeoptions I suppose, but I don't want to add too much hassle for our Git users (if they're not checking in test data, of course).
> 
> I recently fixed this for prepare-commit-msg since that was the one I
> cared about. See
> http://thread.gmane.org/gmane.comp.version-control.git/151297 and
> http://thread.gmane.org/gmane.comp.version-control.git/166805
> 
> j.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
