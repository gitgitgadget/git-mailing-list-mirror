From: =?UTF-8?Q?Carl_M=C3=A4sak?= <cmasak@gmail.com>
Subject: [BUG] 'git merge --quiet' is not always quiet
Date: Thu, 2 Apr 2015 14:42:30 +0200
Message-ID: <CADwUm8do1+2aAqSnwMmViTCwA9jpAZM21DtRP9YiniVtCenFKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 02 14:42:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdeSC-0006hx-Nc
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 14:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbbDBMmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 08:42:32 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38232 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbbDBMmb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 08:42:31 -0400
Received: by wibgn9 with SMTP id gn9so103957160wib.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 05:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=VONU+7zbYmGzF+rv42x+oSSxIpC42GNByuzf7E89uxg=;
        b=oGhn7rNhXlX2dhOGhsnO7IN0ZOvULpRoNgjhM6T0VDsak0nLjfy0cI2hG/g4dhPvRF
         Utzs4rti5kqNfUraj5I5jwEg0kmxavjSsd9QZXoaPPwNgDaS1cFx8BO8A0PrWK/6UqMc
         Qsd2zFw+mjCIRU3vK5P+68N4gnWk0Z5XDFlzD5bqF0t54mK1bbfxv1OR/rq4FhSaI/j9
         UWrRMWh+C5Rqx1YErXYa1TJwUT7QEKaXls8v+M2JNAdK7zfc+I7UtJ1EG4VEmMZMjiLk
         VgDyxkEbpsHETnTHlJ4kA081dmaBQyJcojti0lHn9KefkDHSlXwi7AvWCTlwmVGuIxGy
         L3pQ==
X-Received: by 10.180.21.230 with SMTP id y6mr24757682wie.67.1427978550548;
 Thu, 02 Apr 2015 05:42:30 -0700 (PDT)
Received: by 10.194.158.199 with HTTP; Thu, 2 Apr 2015 05:42:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266640>

In the following session, a 'git merge' command shows some output even
with the '--quiet' flag supplied.

    ~/tmp $ git init example
    Initialized empty Git repository in /tmp/example/.git/
    ~/tmp $ cd example/
    ~/tmp/example $ git commit --allow-empty -m'initial commit'
    [master (root-commit) a7329b5] initial commit
    ~/tmp/example $ git checkout -b b1
    Switched to a new branch 'b1'
    ~/tmp/example $ git commit --allow-empty -m'commit on branch'
    [b1 d15e5ac] commit on branch
    ~/tmp/example $ git checkout master
    Switched to branch 'master'
    ~/tmp/example $ git merge --quiet --no-ff --no-edit b1
    Already up-to-date!
    ~/tmp/example $

My expectation is that '--quiet' would suppress all output, even this one.

I'm on Git 1.9.1, but I've been informed on IRC that this happens even
on latest.

// Carl
