From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [RFC] tag-ref and tag object binding
Date: Tue, 26 Jan 2016 10:29:42 -0500
Message-ID: <20160126152941.GA31951@LykOS>
References: <20160125212208.GB26169@LykOS>
 <56A73DE6.5050201@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jan 26 16:29:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO5Z3-0007RM-Bn
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 16:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966359AbcAZP3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 10:29:49 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36155 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966356AbcAZP3p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 10:29:45 -0500
Received: by mail-qk0-f175.google.com with SMTP id s68so63913514qkh.3
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 07:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to;
        bh=uEjrwMhW7k4QAIqXb4weMtLvHUVRTrtKtgc8OO3Jnwk=;
        b=iwJbgByYTJZtLerw1TeMIfXLS9N2+lhDt81Y+h1pHExkuBu1YJP6widkDZWG0oWmYx
         5oLdFiBIEEgGmlTtnjx7Gn6jTSHY2nzsiZ/L1XEEiOCkean/KVD8KL8g3e+gL5OjlB3J
         6Q4nlSWZi0xLymbOv6JloydVAwpC12ClFmNankC6wU3kvqZ3/Pce8lhtDa9v3san+b4J
         CAyib+RdHj21fobDxruWD1OzYM6tQgPWlzT++BmVLlqRZc2MXXLb/zK6yGCT2NvsCg3Z
         aUEp9hU9yqA1vrDnRCdVlP6gvzpCa+/CKyNzd/S0Ajx7g9l6GQGn6w2XXCj2PJ/7oBJA
         ebZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to;
        bh=uEjrwMhW7k4QAIqXb4weMtLvHUVRTrtKtgc8OO3Jnwk=;
        b=hEbQI3kmQzDmpDNVow+2dJWGk5dXLPbYbL1wd1+oR/IqZWGlRrQ8U2oO4rRDQ5u/WG
         ZTZe0dp5hY2Q7dLoutW+JFynnU/5THQDa//1b/ZSrnLKConjNzPXXAxJ2xGTWMJ93/6W
         REKhknrD37OGLh27uPz/dPg/nK9Jw8Qm8ew5DrL+4jMbqUiZKHq9Ubbb6yeKs8zn/jKI
         bj6qOsANGAemDeEWtA/BsX3DUpbNclHNTfJnkTciraA61R6vmgy5fplmkIhI9dBIs6Us
         zRK/5CsRg9euFq90nKGBQEZ8uLHyp0kCg5mid1qrk8lK7mg47V0Kp/Kj5rTgQ/8oRDM1
         Ijtw==
X-Gm-Message-State: AG10YOQiVWWBPJKKMVozT+CaYqYFSaN0YCotrCUpUcvd8RHa0O9KxvmumH9RqR9lZO4sBg50
X-Received: by 10.55.77.148 with SMTP id a142mr28592675qkb.44.1453822184732;
        Tue, 26 Jan 2016 07:29:44 -0800 (PST)
Received: from LykOS (NYUFWA-WLESSAUTHCLIENTS-15.NATPOOL.NYU.EDU. [216.165.95.4])
        by smtp.gmail.com with ESMTPSA id 11sm685733qgx.32.2016.01.26.07.29.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Jan 2016 07:29:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56A73DE6.5050201@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284840>

On Tue, Jan 26, 2016 at 10:35:34AM +0100, Michael J Gruber wrote:
> Santiago Torres venit, vidit, dixit 25.01.2016 22:22:
> > Hello everyone.
> > 
> > I've done some further research on the security properties of git
> > metadata and I think I've identified something that might be worth
> > discussing. In this case, The issue is related to the refs that point to
> > git tag objects. Specifically, the "loose" nature of tag refs might
> > possibly trick people into installing the wrong revision (version?) of a
> > file.
> > 
> > To elaborate, the ref of a tag object can be moved around in the same
> > way a branch can be moved around (either manually or by using git
> > commands). If someone with write access can modify where this ref points
> > to, and points it to another valid tag (e.g., an older, vulnerable
> > version), then many tools that work under the assumption of static tags
> > might mistakenly install/pull the wrong reivision of source code. I've
> > verified that this is possible to pull off in package managers such as
> > PIP, rubygems, gradle(maven), as well as git submodules tracking tags.
> > 
> > In order to stay loyal to the way files in the .git directory are
> > ordered, I don't think that making the ref file (or packed refs) files
> > differently is an option. However, I think that it could be possible to
> > store the "origin ref" in the git tag object, so tools can verify that
> > they are looking at the appropriate tag. There might also be a simpler
> > solution to this, and I would appreciate any feedback.
> > 
> > What do you guys think?
> > 
> > Thanks!
> > Santiago.
> 
> If you cannot trust those with write access to a repo that you are
> pulling and installing from you might want to re-check where you are
> pulling or installing from ;)

Yeah, I see your point, but mechanisms to ensure the server's origin can
be bypassed (e.g., a MITM). I don't think it would hurt to ensure the
source pointed to is the source itself. The tag signature can help us do
this.

> 
> In fact, just like you shouldn't blindly download and install a tarball
> (but check its signature) you shouldn't blindly pull and install from a
> repo.

Yep. As a matter of fact, many of these package managers can install
from a specific commit, which should be safer. However, I do think that
pointing to a tag is more "usable" given that they are human-readable.
Also, tags are usually meant to point to releases, so it follows its
design pattern doesn't it?. I think it wouldn't be a bad idea to provide
a hard-binding between tag-refs and tags themselves.

> 
> Your best bet is checking the signature of signed tags. Now, if you're
> worried about someone maliciously pointing you to the wrong, correctly
> signed tag then you should verify that the tag object contains the tag
> "name" that you expect (for example by using "git verify-tag -v" or "git
> cat-file -p"), since that is part of the signed content.

Yep, this is my intuition behind my proposal. While someone can manually
inspect a tag (git tag -v [ref]) to ensure he's getting the correct one,
there's no mechanism to ensure that the ref is pointing to the intended
tag. I do believe that package managers and git submodules could check
whether the ref is pointing to the right tag with a small change in the
tag header. Although it would be up to each tool to implement this
check.

I don't think that an addition like this would get in the way of any
existing git workflow, and should be backwards-compatible right?

Thanks,
-Santiago.
