From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: rev-parse doesn't take pwd into consideration
Date: Mon, 26 May 2008 23:18:42 +0300
Message-ID: <20080526201842.GA8194@mithlond.arda.local>
References: <20080526195812.GA23396@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Mon May 26 22:19:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0jAR-0003GG-0h
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 22:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241AbYEZUSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 16:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755234AbYEZUSr
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 16:18:47 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:45242 "EHLO
	jenni1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755160AbYEZUSr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 16:18:47 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.rokki.sonera.fi (8.5.014)
        id 483A80D20007E2AD; Mon, 26 May 2008 23:18:44 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K0j9W-0002NE-UG; Mon, 26 May 2008 23:18:42 +0300
Content-Disposition: inline
In-Reply-To: <20080526195812.GA23396@bit.office.eurotux.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82952>

Luciano Rocha wrote (2008-05-26 20:58 +0100):

> Is it difficult to make rev-parse accept relative path specifications?

I don't know but let's consider this: The revision user is asking for
with "git show <commit>:<path>" may not even contain the directory user
is currently in. Also, there may not be any working directory at all, or
user may be completely outside the repository and using "git
--git-dir=/somewhere/else". I guess the system is much simpler as the
"<commit>:" always refers to repository's root.

If you are using Git's bash completions it's easy to complete paths with
"git show <commit>:". For example, try

  $ git show HEAD~10:Docum<tab>

and the path is completed.
