From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [RFC] Malicously tampering git metadata?
Date: Sat, 19 Dec 2015 12:30:18 -0500
Message-ID: <20151219173018.GA1178@LykOS>
References: <20151216032639.GA1901@LykOS>
 <20151218231032.GA16904@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Dec 19 18:30:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aALKs-00027T-8H
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 18:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933349AbbLSRaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2015 12:30:22 -0500
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36217 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933337AbbLSRaV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2015 12:30:21 -0500
Received: by mail-qg0-f46.google.com with SMTP id c96so56932885qgd.3
        for <git@vger.kernel.org>; Sat, 19 Dec 2015 09:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to;
        bh=xAMvJdrzcysHR7KHcQbRE6WPdb4S27lFro4XzAFOx+8=;
        b=RV0vzykbIr/uTJWxo0ne1+FGOSMK/wfgdjpgQN4ONZXaWmsa0StusoQ1Z3btQqBdvU
         PHMHVJGsZEuYNkxuDmkQYwHo6LmmlCvpRSdBenKyqruOoV4cdcWEpK/2z+P+KXIjUV2+
         I3bq2uhehQcfkn+CVxxVOfzumFAaqPa/X6/CmITK0nhX0SGDHatCGQiLO5cN3+3QiBK6
         H6+BqSoUZp1pMpS/K+0J8R9WtoxGdnICk8KBLHuco0G87o+RgCHDvBB7hn5UHmo9Y9+n
         VrxkrDsXgOJDlUSzsPNhKQKH1Y2Hq3GmsyvKMuz5ya9Y9MPTrXDAvIOYhXFnTdLtpYWJ
         042Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to;
        bh=xAMvJdrzcysHR7KHcQbRE6WPdb4S27lFro4XzAFOx+8=;
        b=GOZZLbFyKCvHqLPD53q7RwCKd+vihWxdVVBqJ+a+H/A6dnz9zuw51ovDjjamzQpNH+
         cWk3BP0wXEqieRZa9RHnGSDDM9Tv/mePy5jRlhbCfzCub4J/ZMQHDeIxQVYLauoR/4c8
         d0jfBOR5uQc5kHlGi9Vnexq77w6peA1XlM8v9L61wUH5k6w+yUPHxmL6lkdFO0Xj19Nc
         3NPDJLTo0zGrXxgYQVPpR0SCwkWpNOfpb6YerHsBNd8L59SYcLLaICHBsICtaHdThjkR
         rhNB63qEXNnvS1XTMVy4+IjL0DyEptDPw2xkokJNELrapkbIjQqgO1dvUdZdI980hw7k
         X5FA==
X-Gm-Message-State: ALoCoQno2vFqfDxaFuFc0Tl8wzffvABQpMaZWp22p7XUv4iebFIzfMdi0LiqeQ1NidC6GJLCXPViZzxMJ731lHOPg3diq27fWg==
X-Received: by 10.140.80.240 with SMTP id c103mr13518284qgd.61.1450546221060;
        Sat, 19 Dec 2015 09:30:21 -0800 (PST)
Received: from LykOS (cpe-74-65-203-27.nyc.res.rr.com. [74.65.203.27])
        by smtp.gmail.com with ESMTPSA id m52sm9206441qge.20.2015.12.19.09.30.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Dec 2015 09:30:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151218231032.GA16904@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282749>

> I assume you are assuming here that the "push to upstream" doesn't
> involve some kind of human verification?  If someone tried pushing
> something like this to Linus, he would be checking the git diff stats
> and git commit structure for things that might look like "developer
> negligence".  He's been known to complain to subsystem developers in
> his own inimitable when the git commit structure looks suspicious, so
> I'm pretty sure he would notice this.
> 
> For example, in my use case, I'm authorative over changes in fs/ext4.
> So when I pull from Linus's repo, I examine (using "gitk fs/ext4") all
> commits coming from upstream that modify fs/ext4.  So if someone tries
> introducing a change in fs/ext4 coming from "upstream", I will notice.
> Then when I request a pull request from Linus, the git pull request
> describes what commits are new in my tree that are not in his, and
> shows the diffstats from upstream.  When Linus verifies my pull, there
> are multiple opportunities where he will notice funny business:
> 
> a) He would notice that my origin commit is something that is not in
> his upstream tree.
> 
> b) His diffstat is different from my diffstat (since thanks to the
> man-in-the middle, the conception of what commits are new in the git
> pull request will be different from his).
> 
> c) His diffstat will show that files outside of fs/ext4 have been
> modified, which is a red flag that will merit more close examination.
> (And if the attacker had tried to introduce a change in fs/ext4, I
> would have noticed when I pulled from the man-in-the-middle git
> repo.)

Yes, we've been considering that these kind of attacks wouldn't be too
effective against, let's say, dictator-lieutenant workflows. 

> 
> Now, the crazy behavior where github users randomly and promiscuously
> do pushes and pull without doing any kind of verification may very
> well be dangerous. 

Yes, we were mostly familiar with this workflow before starting this
research. I can see how the "github generation" is open to many attacks
of this nature. Would git be interested in integrating a defense that
covers users of this nature (which seems to be a growing userbase)?

> But so is someone who saves a 80 patch series from
> their inbox, and without reading or verifying all of the patches
> applies them blindly to their tree using "git am" --- or if they were
> using cvs or svn, bulk applied the patches without doing any
> verification....

Just out of curiosity, are there known cases of projects in which this
has happened (I've noticed that both Git and Linux are quite stringent
in their review/merge process so this wouldn't be the case).

> 
> Cheers,

Thanks for the insight!
-Santiago.
