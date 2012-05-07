From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4: planned view wildcard support
Date: Mon, 7 May 2012 06:44:43 -0400
Message-ID: <20120507104443.GA20372@padd.com>
References: <CAF0RQx-0M4iUHgGdH=RE_UFmLLZH8uy4kkMW=XspNzGm-vsyEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthew Mendell <matthew.mendell@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 12:44:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRLR0-0003mF-J1
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 12:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755396Ab2EGKot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 06:44:49 -0400
Received: from honk.padd.com ([74.3.171.149]:33376 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754153Ab2EGKor (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 06:44:47 -0400
Received: from arf.padd.com (unknown [50.55.155.59])
	by honk.padd.com (Postfix) with ESMTPSA id 41353D27;
	Mon,  7 May 2012 03:44:47 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id BEFB0313D5; Mon,  7 May 2012 06:44:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAF0RQx-0M4iUHgGdH=RE_UFmLLZH8uy4kkMW=XspNzGm-vsyEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197258>

matthew.mendell@gmail.com wrote on Sun, 06 May 2012 16:46 -0700:
> Is there any plan for the git-p4.py script to support the "*" wildcard
> in a p4 client?
> 
> The specific test that exposes this unsupported feature:
> ./t9809-git-p4-client-view.sh
> ...
> ok 4 - unsupported view wildcard *

It hasn't been on anybody's priority list so far that I know, but
this would be not too hard to implement in theory.

The code changes would need to alter just one class.  In
View.Path, functions Path.find_wildcards, match_wildcards and
fill_in_wildcards, if you're interested in giving it a try.

Can you constrain your use of "*" a bit?  What makes these
wildcards difficult is all the edge cases.  For instance, is
there ever more than one "*"?  Is it combined with "..."?  Are
there multiple lines in the client spec with wildcards?  Some
abstracted examples would be interesting.

		-- Pete
