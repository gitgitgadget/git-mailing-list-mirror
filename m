From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Test failures in contrib/remote-helpers
Date: Sun, 11 Nov 2012 16:02:48 +0530
Message-ID: <CALkWK0mU5O3Rqznkx-qn8VLFEgsMzOba1i8onSvf8X3FBeTs6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 11 11:33:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXUqz-0007bQ-Q9
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 11:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496Ab2KKKdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 05:33:12 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:39544 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab2KKKdL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 05:33:11 -0500
Received: by mail-wi0-f178.google.com with SMTP id hr7so1636285wib.1
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 02:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=XgAdicgX0QjSi1cAfkBranvqF/bVEN4j8yOz0Djc1vY=;
        b=JyzgLIVwxAjeLQjG/lvDU6PJ8rbBn64Wstoz8J0hoLfSuisikd4JbfjaWff9OO/Yvr
         4D80B5sNGmf8ODNp/fpywLpij/lJF2PeQsOHLR83zFEHnkDX28Vfic9KfHT/gOLrCpfB
         7BU/JWGk9gNDEZBnyzpJDS0Bdl3rrSCKZa7fmZr87tEkIYrB4Sy7NE/bDRFN90OFMt3l
         9CXj1LRvea3VO+k4khWsA2WlDZ2v6y4cFQhCNhVgfAbErjx1w8QJnbYCoBPJj8GBd5Ro
         wDhxtKaXuu4g31wNuJYJiMwglwSleqTSk1MKdkh99kbn1OdyBlESLN8zjQfSG8EiQE1O
         tlhQ==
Received: by 10.216.140.33 with SMTP id d33mr6595567wej.68.1352629989794; Sun,
 11 Nov 2012 02:33:09 -0800 (PST)
Received: by 10.217.61.2 with HTTP; Sun, 11 Nov 2012 02:32:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209332>

Hi,

I'm experiencing test failures in contrib/remote-helpers.

>From the first test in test-bzr.sh:

Traceback (most recent call last):
  File "/home/likewise-open/ANT/ramkum/src/git/contrib/remote-helpers/git-remote-bzr",
line 672, in <module>
    sys.exit(main(sys.argv))
  File "/home/likewise-open/ANT/ramkum/src/git/contrib/remote-helpers/git-remote-bzr",
line 651, in main
    repo = get_repo(url, alias)
  File "/home/likewise-open/ANT/ramkum/src/git/contrib/remote-helpers/git-remote-bzr",
line 608, in get_repo
    origin = bzrlib.controldir.ControlDir.open(url)
AttributeError: type object 'ControlDir' has no attribute 'open'

>From the first test in test-hg.sh:

Traceback (most recent call last):
  File "/home/likewise-open/ANT/ramkum/src/git/contrib/remote-helpers/git-remote-hg",
line 785, in <module>
    sys.exit(main(sys.argv))
  File "/home/likewise-open/ANT/ramkum/src/git/contrib/remote-helpers/git-remote-hg",
line 773, in main
    do_import(parser)
  File "/home/likewise-open/ANT/ramkum/src/git/contrib/remote-helpers/git-remote-hg",
line 500, in do_import
    export_head(repo)
  File "/home/likewise-open/ANT/ramkum/src/git/contrib/remote-helpers/git-remote-hg",
line 397, in export_head
    export_ref(repo, g_head[0], 'bookmarks', g_head[1])
  File "/home/likewise-open/ANT/ramkum/src/git/contrib/remote-helpers/git-remote-hg",
line 297, in export_ref
    revs = repo.revs('%u:%u' % (tip, head))
AttributeError: 'localrepository' object has no attribute 'revs'
fatal: stream ends early
fast-import: dumping crash report to
/home/likewise-open/ANT/ramkum/src/git/t/trash
directory.test-hg/gitrepo/.git/fast_import_crash_24346
fatal: Error while running fast-import

>From the first test in test-hg-bidi.sh:

Traceback (most recent call last):
  File "/home/likewise-open/ANT/ramkum/src/git/contrib/remote-helpers/git-remote-hg",
line 785, in <module>
    sys.exit(main(sys.argv))
  File "/home/likewise-open/ANT/ramkum/src/git/contrib/remote-helpers/git-remote-hg",
line 773, in main
    do_import(parser)
  File "/home/likewise-open/ANT/ramkum/src/git/contrib/remote-helpers/git-remote-hg",
line 500, in do_import
    export_head(repo)
  File "/home/likewise-open/ANT/ramkum/src/git/contrib/remote-helpers/git-remote-hg",
line 397, in export_head
    export_ref(repo, g_head[0], 'bookmarks', g_head[1])
  File "/home/likewise-open/ANT/ramkum/src/git/contrib/remote-helpers/git-remote-hg",
line 297, in export_ref
    revs = repo.revs('%u:%u' % (tip, head))
AttributeError: 'localrepository' object has no attribute 'revs'
fatal: stream ends early
fast-import: dumping crash report to
/home/likewise-open/ANT/ramkum/src/git/t/trash
directory.test-hg-bidi/tmp/gitrepo2/.git/fast_import_crash_25121
fatal: Error while running fast-import

I can't `import hggit` (I don't know how hg-git is distributed), so I
didn't run test-hg-hg-git.sh.

I'm currently investigating.

Ram
