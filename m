From: Paul Sokolovsky <pmiscml@gmail.com>
Subject: git rebase is confused about commits w/o textual changes (e.g.
 chmod's)
Date: Tue, 24 Sep 2013 22:56:48 +0300
Message-ID: <20130924225648.48af3f4e@x34f>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 24 21:57:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOYjB-0002tm-AS
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 21:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659Ab3IXT4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 15:56:53 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:63089 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab3IXT4w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 15:56:52 -0400
Received: by mail-ee0-f53.google.com with SMTP id b15so2760352eek.12
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 12:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=zU2WXJBmIxEl2Rjlf5OO1YVkPFvt+MFky5ESFUy16Jc=;
        b=0Yh26u3AmdEZxAFwCkwjjPmEYqvqN0zFt61lAhX8MdeUVQ/1dFZeWLLkOs6hx8qDrf
         1uC4fhCItz/OxrmirJtpBHYfvD4YUj9WuzuwDsAs4AITz2c9jyRp1OTBQcAOlcJxQ2r5
         O0kim0JSnJgRHB6PxsVMamXnwX+AO0F45ffYRWMDuKJPU65euFGuTXFB7jgFH0oQwpRQ
         q9EcMDWpakXnwd7kI4IywS0vHQg5Y7J0D9eW1rJvKCcOpJU+PCtNOFkbhU/vak9+d2k4
         fbzI6wker1WYLstCqM8FWbdXRdGlsD0K0jQJthp8Qm0DcPc/x+1bFr5haVHXZXWmYHWL
         qhHg==
X-Received: by 10.15.93.141 with SMTP id w13mr6555504eez.59.1380052611526;
        Tue, 24 Sep 2013 12:56:51 -0700 (PDT)
Received: from x34f ([95.15.189.106])
        by mx.google.com with ESMTPSA id f49sm56898173eec.7.1969.12.31.16.00.00
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 24 Sep 2013 12:56:51 -0700 (PDT)
X-Mailer: Claws Mail 3.9.1 (GTK+ 2.24.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235314>

Hello,

git rebase is confused about commits like
https://github.com/pfalcon/civetweb/commit/ce8493837bf7676c6d824cdcb1d5e3a7ed476fe1
- it stops, telling user to just run rebase --continue. I remember like
few years ago rebase was confused like that oftentimes, which is in turn
confused novices trying rebase-based workflow. There's big progress
over years, and it would be nice to make it just perfect.

The exact messages are:

+ git rebase --preserve-merges --onto upstream-master e61d4efbe4d34d64e6be50ad5009045e4ff06764 HEAD
The previous cherry-pick is now empty, possibly due to conflict resolution.
If you wish to commit it anyway, use:

    git commit --allow-empty

Otherwise, please use 'git reset'
# rebase in progress; onto a0b43ae
# You are currently rebasing.
#   (all conflicts fixed: run "git rebase --continue")
#
nothing to commit, working directory clean
Could not pick 5831bf1affad12bfa3146c37b8b622ba4e584ca3


-- 
Best regards,
 Paul                          mailto:pmiscml@gmail.com
