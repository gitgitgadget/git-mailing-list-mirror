From: Tim Stoakes <tim@stoakes.net>
Subject: git-svn messing with timezones
Date: Tue, 26 Feb 2008 23:17:48 +1030
Message-ID: <20080226124748.GH31792@mail.stoakes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: normalperson@yhbt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 13:48:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTzES-0001I4-1q
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 13:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296AbYBZMrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 07:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752232AbYBZMrw
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 07:47:52 -0500
Received: from hosted03.westnet.com.au ([203.10.1.215]:53745 "EHLO
	hosted03.westnet.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbYBZMrv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 07:47:51 -0500
Received: from hosted03.westnet.com.au (hosted03.westnet.com.au [127.0.0.1])
	by hosted03.westnet.com.au (Postfix) with SMTP id 3B01230A3F8;
	Tue, 26 Feb 2008 21:47:46 +0900 (WST)
Received: from mail.stoakes.net (dsl-202-173-137-105.sa.westnet.com.au [202.173.137.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hosted03.westnet.com.au (Postfix) with ESMTP id 86DD030A39A;
	Tue, 26 Feb 2008 21:47:43 +0900 (WST)
Received: from noodle.stoakes.net (unknown [192.168.20.209])
	by mail.stoakes.net (Postfix) with ESMTP id D2A3228C0DF;
	Tue, 26 Feb 2008 23:17:42 +1030 (CST)
Received: by noodle.stoakes.net (Postfix, from userid 1000)
	id D005A7F025; Tue, 26 Feb 2008 23:17:48 +1030 (CST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-PMX-Branch: TNG-Outgoing
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75133>

Hi all,

When I commit to git, the log shows the correct timezone:
  Date:   Tue Feb 26 23:10:24 2008 +1030

However, when I then dcommit this to SVN with git-svn, the timezone gets
mangled. If I now 'git log', the same commit shows
  Date:   Tue Feb 26 12:40:24 2008 +0000

The 'svn log' of that same revision shows the correct timezone:
r151 | foo | 2008-02-26 23:10:24 +1030 (Tue, 26 Feb 2008) | 2 lines
so, I know it's git-svn doing it, not svn itself.

The same mangling has happened to commits that came through the original
git-svn import, and subsequent 'git-svn rebase's.

I've tried things like:
$ TZ=Australia/Adelaide git svn dcommit
all end in the same result - UTC appears in the logs.

I'm using:
git version 1.5.4.3

Can anyone help?
Thanks
Tim

-- 
Tim Stoakes
