From: John Keeping <john@keeping.me.uk>
Subject: Re: Conforming to pep8
Date: Fri, 9 May 2014 09:05:32 +0100
Message-ID: <20140509080532.GD19464@serenity.lan>
References: <20140509015429.GA550@wst420>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Giokas <1007380@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 10:05:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WifoX-0006DA-BC
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 10:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547AbaEIIFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 04:05:48 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:43936 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbaEIIFp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 04:05:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 82242CDA330;
	Fri,  9 May 2014 09:05:44 +0100 (BST)
X-Quarantine-ID: <8DpEz+xNrUVZ>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8DpEz+xNrUVZ; Fri,  9 May 2014 09:05:40 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id A6C28CDA60A;
	Fri,  9 May 2014 09:05:38 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 9DF55161E0A0;
	Fri,  9 May 2014 09:05:38 +0100 (BST)
X-Quarantine-ID: <wrYLWaBW-v7q>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wrYLWaBW-v7q; Fri,  9 May 2014 09:05:37 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 7BE1C161E27D;
	Fri,  9 May 2014 09:05:34 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20140509015429.GA550@wst420>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248528>

On Thu, May 08, 2014 at 08:54:29PM -0500, William Giokas wrote:
> So I have been looking into the python code in the git tree recently
> (contrib and core tree) and noticed that almost none of the files fully
> conform to pep8. Now I'm not just saying this because I like the code to
> be clean, readable and easily parsed by humans, but also because this is
> laid out in the coding style document that is distributed with the git
> source::
> 
>     For Python scripts:
> 
>      - We follow PEP-8 (http://www.python.org/dev/peps/pep-0008/).
> 
> It's even the first thing that you see when you go looking for 'python'
> in the coding style document. I just ran every file in the tree that
> either ended in '.py' or had a python #!, and was greeted with a whole
> bunch of output::
[snip]
> Which is a whole bunch of errors and warnings thrown by pep8. Is pep8
> just getting put by the wayside? I would much rather have these scripts
> conform to that and have an actual coding style rather than just be a
> hodge-podge of different styles.

The note about PEP-8 was only added to the CodingStyle document fairly
recently, so it's not that it is "getting put by the wayside" but rather
that no one has tidied up what was there before this decision was made,
which gets caught under the catch all rule at the top of
CodingGuidelines:

 - Fixing style violations while working on a real change as a
   preparatory clean-up step is good, but otherwise avoid useless code
   churn for the sake of conforming to the style.

   "Once it _is_ in the tree, it's not really worth the patch noise to
   go and fix it up."
   Cf. http://article.gmane.org/gmane.linux.kernel/943020


Of course, pushing an "apply PEP-8 to the entire file" patch as the
first part of a series that does something else may be worse than fixing
up the style at a time when the script is not otherwise subject to
change.  I suspect the part of CodingGuidelines I quoted above applies
more to local style issues than "change indentation from tabs to spaces"
across an entire file.
