From: Ian Stevens <iancstevens@gmail.com>
Subject: Re: Can I recover lost commits in a SVN repository using a local 
	tracking git-svn branch?
Date: Mon, 26 Apr 2010 08:21:00 -0700 (PDT)
Message-ID: <f01c5562-3cb1-4307-a5ab-f51e5157eba9@c21g2000yqk.googlegroups.com>
References: <904c3ddb-a565-4514-9f5e-83b3706b9fec@t36g2000yqt.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 26 17:21:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Q7t-0003Rh-6Q
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 17:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521Ab0DZPVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 11:21:04 -0400
Received: from mail-yw0-f160.google.com ([209.85.211.160]:49276 "EHLO
	mail-yw0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407Ab0DZPVB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 11:21:01 -0400
Received: by ywh32 with SMTP id 32so10444455ywh.33
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 08:21:00 -0700 (PDT)
Received: by 10.151.115.16 with SMTP id s16mr813700ybm.8.1272295260390; Mon, 
	26 Apr 2010 08:21:00 -0700 (PDT)
Received: by c21g2000yqk.googlegroups.com with HTTP; Mon, 26 Apr 2010 08:21:00 
	-0700 (PDT)
In-Reply-To: <904c3ddb-a565-4514-9f5e-83b3706b9fec@t36g2000yqt.googlegroups.com>
X-IP: 174.137.225.177
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; en-us) 
	AppleWebKit/531.22.7 (KHTML, like Gecko) Version/4.0.5 Safari/531.22.7,gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145823>

Here is how I achieved what I wanted:

1. Re-cloned http://tracked-svn/trunk in a fresh git-svn repo.
2. Added my old git-svn repo as a remote to the fresh repo. (eg. git
remote add -f up-to-date /path/to/repo)
3. git merge remotes/up-to-date/master
4. git svn dcommit

Rebasing on my old repo gives no errors, and dcommit works as
expected.

This might not be the best way to recover commits, but it got me what
I wanted.

Ian.
