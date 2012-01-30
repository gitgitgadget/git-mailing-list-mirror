From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: Why does git stash create two commits?
Date: Mon, 30 Jan 2012 13:25:21 -0500
Message-ID: <201201301825.q0UIPLni016760@no.baka.org>
References: <4F26DF7B.7050109@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 19:25:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrvv3-0003Jy-KF
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 19:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419Ab2A3SZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 13:25:27 -0500
Received: from tsutomu.baka.org ([66.114.72.182]:43861 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753341Ab2A3SZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 13:25:25 -0500
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id q0UIPLfQ011159
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Jan 2012 13:25:22 -0500
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id q0UIPLni016760;
	Mon, 30 Jan 2012 13:25:21 -0500
In-reply-to: <4F26DF7B.7050109@ubuntu.com>
Comments: In reply to a message from "Phillip Susi <psusi@ubuntu.com>" dated "Mon, 30 Jan 2012 13:20:43 -0500."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189391>


In message <4F26DF7B.7050109@ubuntu.com>, Phillip Susi writes:

    git stash makes two commits, one that has no changes from the base,
    and one to stash your changes in.  Why?

git-stash can make up to three commits:

working directory (of files git knows about)
index
working directory (of files git does not know about)

The third commit only appears if you use --all or --include-untracked.

Most likely you do not use -u/-a and your index has not been touched
yet, so you only see two commits, of which one is empty.

					-Seth Robertson
