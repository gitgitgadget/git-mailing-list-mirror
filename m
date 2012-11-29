From: Steven Penny <svnpenn@gmail.com>
Subject: git describe not matching git log
Date: Thu, 29 Nov 2012 03:04:14 -0600
Message-ID: <CAAXzdLWNb7E1qincviX5y_uEsT71bbepuUtLR7Q_+Exm8Od6yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 29 10:04:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te02z-0006xi-4L
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 10:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302Ab2K2JES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 04:04:18 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51945 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab2K2JEP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 04:04:15 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so11680568iea.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 01:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=6JnVmAYKlb034s4FmIXUogyYA/cCFVYUR3JxsGZideQ=;
        b=CPimUqfUZFTe6Etmt1YyFSYNfpgtESaTX34iRuvGuDMrARvrlKJ6IWmUVgrp8KUwjr
         3830xJWwZL/AjAtc8soNQ9/biIsuv+G034Dj7v2bz1OhL8zTrHEQqxxq41tNCLVHMWpT
         8sQEP/oru2m0zKrK3tUCimM9tKyVS5MzpvvnAqNQG+KHo/YuyiOog1BZRZx2JAeOboMD
         XEvd2/Lp24CFsn6EdKsvoQwwrOEq0V4cGS6YCrTFvpa+yAhjF5JjV9jRjvILJbGFwTVH
         j7nll/zme95TKdA+zJxiH0PkDu685QkEUf8QM3WXQKzvE76aEByw5pKTzEY3nUR0yxND
         ZiVQ==
Received: by 10.50.202.97 with SMTP id kh1mr24962099igc.15.1354179855049; Thu,
 29 Nov 2012 01:04:15 -0800 (PST)
Received: by 10.231.30.65 with HTTP; Thu, 29 Nov 2012 01:04:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210824>

It seems "git describe" is not matching "git log" as detailed in the help, in
some cases. From git describe --help

  [torvalds@g5 git]$ git describe parent
  v1.0.4-14-g2414721

  The number of additional commits is the number of commits which would
  be displayed by "git log v1.0.4..parent".

GOOD

  $ git clone git://github.com/antirez/redis.git

  $ cd redis

  $ git describe unstable
  with-deprecated-diskstore-1050-g7383c3b

  $ git log --oneline with-deprecated-diskstore..unstable | wc
     1050   11779   78709

BAD

  $ git clone git://github.com/git/git.git

  $ cd git

  $ git describe master
  v1.8.0.1-264-g226dcb5

  $ git log --oneline v1.8.0.1..master | wc
      260    1650   14154
