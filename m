From: Eric Gillum <eric@color.com>
Subject: git rebase keeps saying local changes would conflict..what changes?
Date: Thu, 14 Jun 2012 16:41:17 -0700
Message-ID: <D8381FF2-A6B4-4596-B565-7E5BB3F239D8@color.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Eric Gillum <eric@color.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 15 01:41:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfJfJ-000394-3C
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 01:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab2FNXlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 19:41:21 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54509 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab2FNXlT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jun 2012 19:41:19 -0400
Received: by dady13 with SMTP id y13so3228072dad.19
        for <git@vger.kernel.org>; Thu, 14 Jun 2012 16:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :cc:to:mime-version:x-mailer:x-gm-message-state;
        bh=przJx0v71CFq1/bu4hOWJ/AtUOao1qo4SjH3Zk7Fe3E=;
        b=ow+NNOpthz7mzCG4+pz4nteXle5heHp+BW8Pjcdp3ickoc+EkAB9g/h1KhVpqyPimw
         J7FFo80xcm3SMwmIMLjdT2juv5WM00nXvdc0yH1s/bye/x96FjF9ISSq7qhAg0M+or/l
         qnlGoHhLh6toSwyYC237/G8doBxmaf//+4DlWpWe0QcjZSZcVIIsZvF2oiR3L1uZSpJ7
         owMOubGB3ZOVk0DdFWwE4YSSnI8l0NCvG+4F7enZLuFaUHI9ALOEXM+kIfyJt3ry4tT9
         +XBu3KJgWp6951behvkqMNG7ZcTdPVbCqKX5KfTYcPkM99BEG/ZBN2q/0yffWyHL+uuO
         ktXw==
Received: by 10.68.225.6 with SMTP id rg6mr13437173pbc.100.1339717279324;
        Thu, 14 Jun 2012 16:41:19 -0700 (PDT)
Received: from [10.0.3.163] ([65.50.211.37])
        by mx.google.com with ESMTPS id ol1sm11086417pbb.25.2012.06.14.16.41.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jun 2012 16:41:18 -0700 (PDT)
X-Mailer: Apple Mail (2.1278)
X-Gm-Message-State: ALoCoQkfe1VCpZDJK7S1KY/pFKpMxDydUIqYsBb/CIw4qJKHjwI9SfFsXA7VHl5zQkRxrEjo4QVv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200036>

Hi,

I have a sometimes-reproducible issue when trying to rebase. In short, I've created a local branch B off of master, made several commits on B, switched to master and pulled, switched back to B, then tried "git rebase master", which fails. What I get about half the time is a failure that claims I have local changes to files that would be overridden by the merge. Nothing is reported by git status (I've even tried closing all editors), so I am forced to do git rebase --abort or --skip. I can't skip because the commits only exist on B. So I abort and just try the rebase from scratch, and somewhat less than half the time git claims there are conflicts in certain files. Sometimes I bite the bullet and go fix those conflicts. Sometimes I abort again and rebase again until eventually...it just suc
 ceeds!

What's wrong? Why would I get the local changes warning but have no local changes? The merge conflicts tend to be within a file that has been changed multiple times on B. These "conflicts" are literally changes I've made at one point or another on B. The relevant files were never touched on master while I was working on B. And no changes on B are amends or reverts or anything remotely tricky --  they're simply more changes committed with "git commit". So why would I have to "resolve conflicts"?

This is git version 1.7.9.3. Your insight appreciated.