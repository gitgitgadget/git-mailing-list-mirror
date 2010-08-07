From: "Amir E. Aharoni" <amir.aharoni@mail.huji.ac.il>
Subject: tests failing on Cygwin
Date: Sun, 8 Aug 2010 00:37:00 +0300
Message-ID: <AANLkTimeE-dJrSrjJSuP9Zm93tF9woNakO+HwspJg6CZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 07 23:37:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ohr5H-0002iU-8v
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 23:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436Ab0HGVhX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Aug 2010 17:37:23 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:38666 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754316Ab0HGVhW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Aug 2010 17:37:22 -0400
Received: by qyk7 with SMTP id 7so882390qyk.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 14:37:20 -0700 (PDT)
Received: by 10.220.122.24 with SMTP id j24mr9006041vcr.154.1281217040141; 
	Sat, 07 Aug 2010 14:37:20 -0700 (PDT)
Received: by 10.220.193.2 with HTTP; Sat, 7 Aug 2010 14:37:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152866>

Hallo,

I couldn't find a better place to report this and i don't know whether
anyone really cares about this, but i'll try anyway.

I want to make a few corrections to the core documentation. I cloned
git.git and before starting the actual i built it and ran `make test',
just in case, and some tests failed.

I am doing this on XP/Cygwin. Some of them may be irrelevant for
Cygwin; if so, they probably should be skipped. And maybe i am just
misunderstanding something.

Here's the list of files and names of failed tests:

t0001-init.sh:
* init notices EPERM

t1004-read-tree-m-u-wf.sh:
* funny symlink in work tree, un-unlink-able

t3300-funny-names.sh:
* git diff-tree delete with-funny
* ... and all the test from here until the end of that file

t3301-notes.sh:
* test_expect_success 'git notes copy --for-rewrite (disabled)' '
        git config notes.rewrite.bar false &&
        echo $(git rev-parse HEAD~3) $(git rev-parse HEAD) |
        git notes copy --for-rewrite=3Dbar &&
        git log -2 > output &&
        test_cmp expect output
    '

t556x_common:
* direct refs/heads/master not found
* no export by default
* static file if http.getanyfile true is ok
* http.uploadpack false
* http.receivepack default disabled
* http.receivepack false

t7300-clean.sh:
* removal failure

t7606-merge-custom.sh:
* merge c2 with a custom strategy

--=20
=D7=90=D6=B8=D7=9E=D6=B4=D7=99=D7=A8 =D7=90=D6=B1=D7=9C=D6=B4=D7=99=D7=A9=
=D7=81=D6=B8=D7=A2 =D7=90=D6=B7=D7=94=D6=B2=D7=A8=D7=95=D6=B9=D7=A0=D6=B4=
=D7=99
Amir Elisha Aharoni

http://aharoni.wordpress.com

"We're living in pieces,
=C2=A0I want to live in peace." - T. Moore
