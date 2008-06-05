From: "jenny w" <veganjenny@gmail.com>
Subject: Problems reverting (includes reverting a merge)
Date: Thu, 5 Jun 2008 10:45:55 -0700
Message-ID: <b1d95faa0806051045t67ea0f46r55cdaeb794dc2f5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 19:46:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4JY1-00040k-P6
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 19:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190AbYFERp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 13:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752907AbYFERp5
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 13:45:57 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:36063 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbYFERp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 13:45:57 -0400
Received: by an-out-0708.google.com with SMTP id d40so170730and.103
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 10:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=UEUc4RMBjG4xasw5om4Ri9199yHnhCLWIf53+m2hbM8=;
        b=KTIXTvuARc2wIiSW+4SY7XmCZZC8L8bA6M8xc8FK51W5S0mxcfbWItvYnU4TMSuuMm
         zsLsC6wPnHIL0kUkXYQEICv/K6snsjAtp6OBNrBnJ5LRTw1wuhUFEp7sP04zG6jlHx1K
         0ilZBgbRjF3Lq2NhiWtxyNuzhdXVRdc+J0cZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=aZth97YUASHB2I+0o59cwbFSlgh/PfHUc4xSAMTGqaOZS/ijcAcVnHXsuiaUErntTB
         8wANNyVmJ50ktJOphHUndO7wfSI5QTKkulAuHOVyXkRCMYy0+eQIz+6xoPT8ufoHFwZX
         0olzjL+BAxt01pz2k8XXS8zzKBgmOVfXw/Ehc=
Received: by 10.100.190.15 with SMTP id n15mr2875047anf.113.1212687955908;
        Thu, 05 Jun 2008 10:45:55 -0700 (PDT)
Received: by 10.100.135.17 with HTTP; Thu, 5 Jun 2008 10:45:55 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83946>

Someone made a few commits that I'm trying to revert. There are three
commits in a row, the middle of which is a merge. There are presently
no commits following the ones that we want to revert.

I tried git revert on the latest commit and that worked fine.

The second latest commit was a merge, so I had to use the -m switch.
I'm not exactly sure what the parent-number refers to, so I created a
separate branch to try things out. Since it expects I a number, I
started from 1. That was kind of a disaster, so I deleted my branch
and made another off of master, and then tried doing the same command
with -m 2. This worked fine.  However ...

I then tried to revert the next commit. This said there's a conflict.
Since there are no other commits after the ones I'm trying to revert,
this makes me think I'm doing something wrong ... shouldn't it just be
able to roll back?

What I'd really like to do is just zap the last 3 commits ... is there
another way to just make things the way they were before these patches
were applied?

Any help with any of the above would be greatly appreciated!
