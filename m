From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: Confusion about diffing branches
Date: Sun, 26 Aug 2007 18:35:55 -0500
Message-ID: <20070826233555.GA7422@mediacenter.austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 01:34:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPRdB-0000Wc-S0
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 01:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbXHZXex (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 19:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbXHZXex
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 19:34:53 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:51681 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbXHZXew (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 19:34:52 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1447499wxd
        for <git@vger.kernel.org>; Sun, 26 Aug 2007 16:34:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=cVev6cxEH0W8ssmG2ZeXockPY6LWAkYAAkZUOrlJ0BoLS8eUBVe7/HS54bLPjr3qw539z9G7Dp2lZUspcRp7x4mE0FSy1w8JFwAEgUQw6uxCDwSiX7+ESsQsQ7GlXET9R5wNPdTQMfPqBVUR5ffyoMI3iKleLalmG9/g03/dZHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=jvuQkVhyLim472rQLPqR0C1vEospQdITVtPTJvyYaIiR42Mch0Tvo/b1onUKrOS9Yr24xoplZmEDSuNd0i74ycVzRMFfx7VeOHGnzrRnt5kN38WpS/s80Wq/z60zKEhbgKU9rCwDxoYK7j8m5SAs1Xcq0fPfCp5VsFq7Vl/3/9U=
Received: by 10.70.91.16 with SMTP id o16mr9183215wxb.1188171291757;
        Sun, 26 Aug 2007 16:34:51 -0700 (PDT)
Received: from mediacenter.austin.rr.com ( [70.112.123.114])
        by mx.google.com with ESMTPS id 62sm6993700wri.2007.08.26.16.34.50
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Aug 2007 16:34:51 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56743>

So I imagine I'm missing something, or perhaps I'm just looking at this
from the wrong perspective, but here is what I'm seeing.  Lets say I
have something like:

         A---B topic
        /
   C---D---E master

If I want to see a diff of all of the changes between the two branches I
can say:

   git diff master topic

Which shows me the combined diff of commits A, B and E.  That is exactly
what I would expect however, I would expect that equivalently I could
say:

   git diff master...topic

to see all commits reachable from topic and master but not both.
However, this doesn't do what I expect but instead only shows me the
combined diff of A and B.  Likewise:

   git diff topic...master

Shows me the diff of E.  Am I crazy or isn't this supposed to be the
behavior of the topic..master notation?  Strangely enough running either

   git diff master..topic
   git diff topic..master

both show me the diff of A, B and E, which is what I would expect from
the master...topic notation.  Am I the only one who thinks this is
backwards?  The same experiment using git log shows me what I would
expect so somehow I think I'm missing something.
