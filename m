From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-grep to operate across who repository and not just CWD?
Date: Mon, 28 Feb 2011 10:27:39 +0100
Message-ID: <4D6B6A8B.20709@drmicha.warpmail.net>
References: <AANLkTimnOSzF1o-fX-n7b26Qx2aLP3aU3pTMGY_f5hKy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Chanters <david.chanters@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 10:31:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtzRc-0000Wz-F3
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 10:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131Ab1B1JbC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 04:31:02 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34853 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753118Ab1B1JbB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 04:31:01 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DC2AB2094E;
	Mon, 28 Feb 2011 04:31:00 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 28 Feb 2011 04:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=i0eiay8b0UXc2YpmbPuyd6DV+qE=; b=h5Hx5szsJ9USIswiIYqwmNT07vSBl49WbWA1idHtYC0BGenj7WpQ9E4Pm4awkphMU3F8oDHQd3116MUIvHUnkOMwPFScHOm6JdiwV5GNawKQMpANcXaCQbGHISeTy+A6xo6KQ2bGWjBc3x8appMxzz0EPXMwzg0mYQmsduzwSaU=
X-Sasl-enc: v+h8Wcb40jRNwR87EczS//GuC6OD5WLB2GET9L+9v2RA 1298885460
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 699EE4401B7;
	Mon, 28 Feb 2011 04:31:00 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTimnOSzF1o-fX-n7b26Qx2aLP3aU3pTMGY_f5hKy@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168082>

David Chanters venit, vidit, dixit 28.02.2011 01:17:
> Hi all,
> 
> [ Please Cc me as I am not subscribed to this list, thanks. ]
> 
> I'm wondering if there's an easy way to get git-grep (and I suppose
> other commands which operate on a per-repository level rather than
> per-tree) to work across the whole repository?
> 
> Often I will be in the depths of my git repository, run "git grep
> --options 'search string'", to find no results.  Of course, then I
> remember that git grep doesn't work across the whole repository, it
> works like normal grep, and only considers the CWD onwards.
> Typically I end up cursing, using {push,pop}d to recall where I am,
> cd'ing to the root of the repository and running "git grep" from there
> and then poping my CWD to go back to where I was.
> 
> Is there some clever trickery or command-line flag I've not read about
> in the "git-grep" man page to make this idea more seamless?

git grep -- $(git rev-parse --show-cdup)

is the best we have right now. I think we're still looking for a good
way to denote "root of repo" (like "." for cwd).

Also, we're thinking of changing a few defaults (to repo-wide), but "git
grep" is meant to stay close to ordinary grep.

Michael
