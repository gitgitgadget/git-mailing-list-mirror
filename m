From: "Steven Walter" <stevenrwalter@gmail.com>
Subject: Re: Getting git-svn to recognize branchpoints?
Date: Sat, 7 Jun 2008 11:36:36 -0400
Message-ID: <e06498070806070836m4c3ffd93ye4e4d7ddd149a5a7@mail.gmail.com>
References: <a12182cd-2cd3-42a6-b3b4-f99907576741@d77g2000hsb.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: davetron5000 <davetron5000@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 17:37:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K50U2-0005n9-EN
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 17:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757262AbYFGPgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 11:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757385AbYFGPgl
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 11:36:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:20694 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756332AbYFGPgk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 11:36:40 -0400
Received: by fg-out-1718.google.com with SMTP id 19so987976fgg.17
        for <git@vger.kernel.org>; Sat, 07 Jun 2008 08:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=BeKJXDUeIPUAtEyf6j4l1be/8thrUrIyxwYpyyiz8UA=;
        b=TIIscWt5dJGyav1v8dL53Q9156OJI4ns7DG0FZ+gnIa0/Kv3XjQlk57q5Pq9/OwrN+
         k3ULWdU+0eKbXXQru0GRe2vZfOtZadqal7QjoK2ddKNTlVIj8mA7jabvfGQ2YkUcR1pk
         oPFADSrVA/CRJ3wLpeki+oVVAd64+EswISUvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jVDNrWyMMyzBcB0P1SkJAwCcxIYrY1ibV09Eogjo8WOWDBeDJ9aDlPQHs7iNEL9QeC
         m1n7wgFAGIdyfbygqiC7yInPAG++nPWRj2qHJ8t5ggZD4I+j0S+qULkbHp0R4EMxC+Px
         orE3JvOUTZbtBgB9bK9933iBZEAmRjTMwssJc=
Received: by 10.86.73.3 with SMTP id v3mr1929838fga.68.1212852996691;
        Sat, 07 Jun 2008 08:36:36 -0700 (PDT)
Received: by 10.86.100.20 with HTTP; Sat, 7 Jun 2008 08:36:36 -0700 (PDT)
In-Reply-To: <a12182cd-2cd3-42a6-b3b4-f99907576741@d77g2000hsb.googlegroups.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84207>

On Fri, Jun 6, 2008 at 3:07 PM, davetron5000 <davetron5000@gmail.com> wrote:
> I was given a branch in an SVN repo to work on.  My plan is to merge
> it with trunk in Git to indicate how much easier it would be to use
> Git.
>
> Unfortunately, Git doesn't seem to realize that my branch is a branch
> from SVN's trunk.  For example, I have made no changes to file foo.c
>
> The main trunk has changes to foo.c
>
> When I merge, those changes show up as conflicts.
>
> gitk doesn't show any branch points, and I'm thinking that Git just
> doesn't see the branches as they are in SVN.

How much history did you fetch from subversion?  If you didn't fetch
at least to the branch point, then that could explain what you're
seeing.  If the SVN repository isn't too large, it is probably worth
the time to fetch the entire history (from r1 forward).

> The sha-1 of the branch commit from SVN shows up in gitk when I've
> checked out my branch, but not if I have the trunk checked out (though
> a git log DOES show it).

That's expected; it sounds like you want "gitk --all"
-- 
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
 -Robert Heinlein
