From: Jonathan Nieder <jrnieder@gmail.com>
Subject: cherry-pick/revert error messages
Date: Sun, 20 Nov 2011 01:30:59 -0600
Message-ID: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 20 08:41:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RS21b-0003og-CC
	for gcvg-git-2@lo.gmane.org; Sun, 20 Nov 2011 08:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401Ab1KTHbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Nov 2011 02:31:14 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35355 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271Ab1KTHbO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2011 02:31:14 -0500
Received: by iage36 with SMTP id e36so5753165iag.19
        for <git@vger.kernel.org>; Sat, 19 Nov 2011 23:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=YNzeEu4nzTcIM9tkzYa/1SB58NHkThofBCw1hC4dbpg=;
        b=sggCZdqrQ+BzYBfHxgBk+HkmxDjma20J2RtGsSdrtBSKN4AMS5kTwA8agmajr7tAyE
         yoEnJCwib2bePbKC9Mtla3Oj9XWsAdffZcI+T90kBWr1XhP2BKXUfS9EiLZJnd0YEott
         zTS8iccs+NjYV8yId4AvJ66Sd9757c05whK54=
Received: by 10.42.159.72 with SMTP id k8mr7433266icx.14.1321774273646;
        Sat, 19 Nov 2011 23:31:13 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id a2sm16004326igj.7.2011.11.19.23.31.12
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Nov 2011 23:31:12 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185716>

Hi Ram,

Today I encountered the following error message:

	$ git cherry-pick foo..bar
	error: .git/sequencer already exists.
	error: A cherry-pick or revert is in progress.
	hint: Use --continue to continue the operation
	hint: or --reset to forget about it
	fatal: cherry-pick failed
	$

The double "error" seemed a little weird.  Also, the capital letters
and periods feel out of place, when compared with other messages
emited by git with an "error:" prefix.  The final "fatal: cherry-pick
failed" seems redundant, too.  I guess I would have expected something
like the following instead:

	$ git cherry-pick foo..bar
	fatal: a cherry-pick or revert is already in progress
	hint: try "git cherry-pick (--continue | --quit)"
	$

What do you think?
