From: =?UTF-8?Q?Romain_Vimont_=28=C2=AEom=29?= <rom@rom1v.com>
Subject: [BugReport] git tag -a / git show
Date: Fri, 24 Feb 2012 11:24:48 +0100
Message-ID: <b05f03b381140ca57a7d03a934f605bd@rom1v.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 24 11:44:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0sdk-0006vG-5a
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 11:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671Ab2BXKof convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 05:44:35 -0500
Received: from rom1v.com ([78.236.177.60]:51045 "EHLO rom1v.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab2BXKoe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 05:44:34 -0500
X-Greylist: delayed 554 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Feb 2012 05:44:34 EST
Received: by rom1v.com (Postfix, from userid 33)
	id 6C36A10DA; Fri, 24 Feb 2012 11:24:48 +0100 (CET)
X-PHP-Originating-Script: 1000:main.inc
X-Sender: rom@rom1v.com
User-Agent: Roundcube Webmail/0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191427>

$ git --version
git version 1.7.5.4

$ git log --pretty=3Donline
0ef41513d0b6d0ad28f21d0ac1da7096ad1dc6ff This is the last commit
a4702c69c28484d357179166cf3b116764da20a4 This is a commit

Now, I edit some files (for example in a config file "mock_data=3Dtrue"=
),=20
then I want to tag without commiting this change.

$ git tag -a v0.1 -m 'My v0.1 with mock data'

$ git show v0.1
tag v0.1
Tagger: Me <me@me.me>
Date:   Fri Feb 24 11:23:38 2012 +0100

     My v0.1 with mock data

commit 0ef41513d0b6d0ad28f21d0ac1da7096ad1dc6ff
Author: Me <me@me.me>
Date:   Fri Feb 24 11:14:19 2012 +0100

     This is the last commit

diff --git a/myfile b/myfile
index 8430bf6..20feeb6 100644
=2E..


And it shows the diff between a4702c69c28484d357179166cf3b116764da20a4=20
and 0ef41513d0b6d0ad28f21d0ac1da7096ad1dc6ff (the two last commits).
Instead, it should show the diff between=20
0ef41513d0b6d0ad28f21d0ac1da7096ad1dc6ff (the last commit) and v0.1 (th=
e=20
tag).

Best regards,
=C2=AEom
