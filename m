From: Eugene Sajine <euguess@gmail.com>
Subject: Proper way to abort incorrect cherry-picking?
Date: Wed, 28 Apr 2010 15:38:15 -0400
Message-ID: <s2m76c5b8581004281238jf7179fffna7d757fee6ab4f10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eugene Sajine <euguess@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 28 21:38:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7D5a-00015x-3F
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 21:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008Ab0D1TiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 15:38:17 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:51412 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796Ab0D1TiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 15:38:16 -0400
Received: by qyk9 with SMTP id 9so21767520qyk.1
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 12:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=cS0XlrlFU5QyXih1ATnZYuUOJYVoq+LBHLWRE+YggMQ=;
        b=Dv8fFic3xmDevy1RwUcU/cxVfOvU8vEwyV/pIXpRaTMwkoatkUrEvv48MPQLE4gEo2
         2DtEQ73uLzrMUf2QbT+HdTQ0T2BO2aOzKTgiuLo8QMwZuc+36OyoAffDDo5zEJ99H6l9
         wfYq14o57VdHOdl20+8ADEzLe+sjAx+eMuZiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=KAHApYRrFlidE9Dck/xuNlA1FQzw3slbIxAXBm/tMaso9G5KpeLsogOb65CU9utG3A
         GpCj5EGm2O0o/33QT+U0Yob5vHEuJbg8h0dAFPCg6yd8Au85ohZ2KmZu5S/gvmArXt7M
         2klDGQ2oxQhVPgqpBysyUF4uQwd7lQ5wSZOwI=
Received: by 10.229.211.210 with SMTP id gp18mr9958562qcb.31.1272483495185; 
	Wed, 28 Apr 2010 12:38:15 -0700 (PDT)
Received: by 10.229.190.202 with HTTP; Wed, 28 Apr 2010 12:38:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146006>

hi,

we have tried to cherry-pick 2 commits from one branch to another
branch, but unfortunately the incorrect commit was chosen to be
applied first.

Thus, the automatic cherry-pick failed and caused conflicts, so in
order to to cancel the whole operation i had to do the following:

1. mark the conflicting files as resolved (without even resolving
them) by doing git add.
2. unstage all files staged for commit as a result of incomplete cherry picking
3. manually checkout touched files to their correct state (git checkout file)

and then i was able to repeat cherry-picking with correct commits.

Is there a better way? Shouldn't there be a "git cherry-pick --abort"
for such cases as it exists for rebase?

Thanks,
Eugene
