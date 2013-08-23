From: Corey Thompson <cmtptr@gmail.com>
Subject: Re: git-p4 out of memory for very large repository
Date: Fri, 23 Aug 2013 07:59:20 -0400
Message-ID: <20130823115920.GB8182@jerec>
References: <20130823011245.GA7693@jerec>
 <52170C6A.4080708@diamand.org>
 <20130823114856.GA8182@jerec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Aug 23 13:59:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCq1Z-0003bc-0q
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 13:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755463Ab3HWL7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 07:59:25 -0400
Received: from mail-gh0-f179.google.com ([209.85.160.179]:33202 "EHLO
	mail-gh0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282Ab3HWL7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 07:59:24 -0400
Received: by mail-gh0-f179.google.com with SMTP id f16so99031ghb.10
        for <git@vger.kernel.org>; Fri, 23 Aug 2013 04:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XgnRqV3FbWGYUDEUvKJWufN1dVexOVtjvZaU7+pfpqk=;
        b=Avi8wJnyTlfhYYgaO5Wx7sYKfNmqBeg4lkZUQlRWVbn1VGhMvZp4YPW77vH/aSRvrC
         c/fYByYVOif+o8XTQKdKGV9KT7NP8U0niDjRWe7KQ8Hnoc7Zm9zKIolGSMQ8bCF377FL
         OCcgyLq/9Qp7WfHkZ3rHjyPctZ+wLWWMDwxTp6lha74A0JbuQlOXq6SkYJbRi5C5XPJ7
         GjrE57Vyw4rfxOMrlwCjIIi/ZLvbp5kSyA4968NimrWUYOEXxjEK+kZ8AfwnSSm5A9hb
         LaoBRq3MpF3nSya2r2QtDZ8XE5JN4o9FrTkbsDU3gz6RzXF2MYqMJXRYI/cgvznlzXfJ
         NgnA==
X-Received: by 10.236.228.137 with SMTP id f9mr15305172yhq.44.1377259163845;
        Fri, 23 Aug 2013 04:59:23 -0700 (PDT)
Received: from jerec (c-71-59-19-88.hsd1.ga.comcast.net. [71.59.19.88])
        by mx.google.com with ESMTPSA id s9sm19844366yhb.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 23 Aug 2013 04:59:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130823114856.GA8182@jerec>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232806>

On Fri, Aug 23, 2013 at 07:48:56AM -0400, Corey Thompson wrote:
> Sorry, I guess I could have included more details in my original post.
> Since then, I have also made an attempt to clone another (slightly more
> recent) branch, and at last had success.  So I see this does indeed
> work, it just seems to be very unhappy with one particular branch.
> 
> So, here are a few statistics I collected on the two branches.
> 
> branch-that-fails:
> total workspace disk usage (current head): 12GB
> 68 files over 20MB
> largest three being about 118MB
> 
> branch-that-clones:
> total workspace disk usage (current head): 11GB
> 22 files over 20MB
> largest three being about 80MB
> 
> I suspect that part of the problem here might be that my company likes
> to submit very large binaries into our repo (.tar.gzs, pre-compiled
> third party binaries, etc.).
> 
> Is there any way I can clone this in pieces?  The best I've come up with
> is to clone only up to a change number just before it tends to fail, and
> then rebase to the latest.  My clone succeeded, but the rebase still
> runs out of memory.  It would be great if I could specify a change
> number to rebase up to, so that I can just take this thing a few hundred
> changes at a time.
> 
> Thanks,
> Corey

And I still haven't told you anything about my platform or git
version...

This is on Fedora Core 11, with git 1.8.3.4 built from the github repo
(117eea7e).
