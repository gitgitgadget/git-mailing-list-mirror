From: in-gitvger@baka.org
Subject: Re: Pull --rebase looses merge information
Date: Thu, 06 Oct 2011 16:31:57 -0400
Message-ID: <201110062031.p96KVvsv018248@no.baka.org>
References: <DECF417E-50BB-4963-965C-BEF1B5C95DAC@mac.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Duane Murphy <duanemurphy@mac.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 22:32:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBubu-00082A-Hn
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 22:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759119Ab1JFUcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 16:32:01 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:54612 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758841Ab1JFUcA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 16:32:00 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id p96KVwZe012190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 6 Oct 2011 16:31:58 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id p96KVvsv018248;
	Thu, 6 Oct 2011 16:31:57 -0400
In-reply-to: <DECF417E-50BB-4963-965C-BEF1B5C95DAC@mac.com>
Comments: In reply to a message from "Duane Murphy <duanemurphy@mac.com>" dated "Thu, 06 Oct 2011 12:21:56 -0700."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183030>


In message <DECF417E-50BB-4963-965C-BEF1B5C95DAC@mac.com>, Duane Murphy writes:

    $ git merge topic
    $ git pull 
        merge by rebase; implied by config
    $ git push

    The result of this process is that the file changes are pushed but
    the reference back to the topic branch has been lost. This makes
    it appear as though the topic branch has not been merged properly.

[...]

    Is there a bug here? Is there some way to avoid this situation
    without sacrificing the benefits of pull --rebase?

Yes, but it currently is annoying.

Instead of `git pull --rebase` you need to run
`git fetch && git rebase -p @{u}`

It would be very nice if the -p argument to rebase could be
automatically included in the `git pull --rebase`.

I personally believe all pull should be --rebase, all merges should be
--no-ff, and all rebases should be -p.  At least by default.  But that
is just me.

					-Seth Robertson
