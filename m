From: Steven Penny <svnpenn@gmail.com>
Subject: git pull --quiet is not quiet
Date: Mon, 23 Jul 2012 20:56:31 -0500
Message-ID: <CAAXzdLWaeZLLwKDQVMNNcKpUXcVb99TJZNwdg+xUxzykZ-Xbrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 24 03:56:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StUMZ-0005fq-MO
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 03:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195Ab2GXB4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 21:56:34 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50552 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755091Ab2GXB4d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 21:56:33 -0400
Received: by yhmm54 with SMTP id m54so6174540yhm.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 18:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=5EFmbko760DH4XqXnq7caNAV7XV5pLZWzlYDGZ94Fzc=;
        b=MMfxKMbklGUDRWuDr67jHQqI65LKnBCsqEIaGz7tsVvBsP8d2e9HyJEvG/nM+UZhMO
         ZuBs5Jh+5ysN6r+gbuz3ntr89lY2MCqRBPzENopfN9EKk4rvpIQLWvkfBe5IMoNDxYeL
         lRcgxTpKndTD0uNF+8UZfldsN436BqSyp5dBDGmJTV9/BC9XJ+WQiiCdJZl0TuPcIZI1
         EevhChRbLhBHweAR1AHndBvtSAGsbVBGQDlFeT+TcoCov82MkcktzNJ2srIJmrhjpCqw
         7zPDLedFRdZtzgWOr8g/r1nXXLqwlED5wnK4DvjZTAauKjMFg2SEnqy/RpV+tl+Sg3rN
         aePQ==
Received: by 10.43.136.66 with SMTP id ij2mr10927700icc.40.1343094991646; Mon,
 23 Jul 2012 18:56:31 -0700 (PDT)
Received: by 10.231.64.68 with HTTP; Mon, 23 Jul 2012 18:56:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202007>

I have noticed that

  git pull --quiet

is actually only "quiet" if no problems are found

If unmerged error occurs, output is seen on BOTH stdout and stderr

  $ git pull -q >/dev/null
  Pull is not possible because you have unmerged files.
  Please, fix them up in the work tree, and then use 'git add/rm <file>'
  as appropriate to mark resolution, or use 'git commit -a'.

  $ git pull -q 2>/dev/null
  U       AdobeHDS.php

The --quiet option should at least silence the stdout.
