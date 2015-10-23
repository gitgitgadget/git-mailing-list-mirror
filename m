From: Noam Postavsky <npostavs@users.sourceforge.net>
Subject: git --literal-pathspecs add -u says "fatal: pathspec ':/' did not
 match any files"
Date: Fri, 23 Oct 2015 19:39:29 -0400
Message-ID: <CAM-tV--Q=DjTwLk8sZVm7-xMQsGwKmyjy4XiT08QpQ5-dffL0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 24 01:39:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zplvr-0004DN-9Y
	for gcvg-git-2@plane.gmane.org; Sat, 24 Oct 2015 01:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075AbbJWXjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 19:39:31 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37716 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbbJWXja (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 19:39:30 -0400
Received: by wicfv8 with SMTP id fv8so50828805wic.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2015 16:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=BCDeZKJ4jA6LfEZ/yDVHU25PxrGfhRoPFVmZpVl0Wms=;
        b=d0Cg/r0VVNYWBrOgTPi8xaQ8vQ4bFbS5WwuJ4bhIIDPZp5G5VOfZocadj2fXosGNbb
         1Gu/tXqsYk3JpvRSm6JwUcyns8RcvREQ+Fzc2WyZkYErvDTMAQGjOjlAGiuWgZzH3zmp
         94xAnuJorULV+Stmn2m8qA7SvF7V0GdXsBrdbXuVP9oOhM+4CVglSsFCvFAv1pWjvR0A
         dQ28WhSiN/7wBn04V+RJArSN25YtJVHFb7JGIGOwRJk+sJgEGWT/9fK+iPofgTwj4Rai
         +DQnJwXKupNfcDq6kuhNr1mNflfLTGTnaPwQdAX40QFSyZico6koyqXLvZ0efYpQf0A1
         2haA==
X-Received: by 10.180.93.197 with SMTP id cw5mr7641845wib.53.1445643569532;
 Fri, 23 Oct 2015 16:39:29 -0700 (PDT)
Received: by 10.28.29.87 with HTTP; Fri, 23 Oct 2015 16:39:29 -0700 (PDT)
X-Google-Sender-Auth: OWv5twF8UYDibNKHioBvTgfATbs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280114>

~/tmp/tmprepo$ git init
Initialized empty Git repository in /home/npostavs/tmp/tmprepo/.git/
~/tmp/tmprepo$ git --literal-pathspecs add -u
fatal: pathspec ':/' did not match any files
~/tmp/tmprepo$ git --version
git version 2.6.1

It was reported[1] that 2.0.2 and several following versions also fail
with the same error; I found that version 1.9.5 succeeds.

Adding a "." argument:

   git --literal-pathspecs add -u .

succeeds in all versions.

[1]: https://github.com/magit/magit/issues/2354#issuecomment-150665961
