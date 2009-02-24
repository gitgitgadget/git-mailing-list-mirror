From: Jan Kara <jack@suse.cz>
Subject: git bisect goes wild?
Date: Tue, 24 Feb 2009 19:44:14 +0100
Message-ID: <20090224184414.GE22108@duck.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 19:45:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc2Hq-0000ak-QP
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 19:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757408AbZBXSoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 13:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757310AbZBXSoT
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 13:44:19 -0500
Received: from ns1.suse.de ([195.135.220.2]:48816 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757080AbZBXSoR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 13:44:17 -0500
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 79EF9456F7
	for <git@vger.kernel.org>; Tue, 24 Feb 2009 19:44:15 +0100 (CET)
Received: from duck.suse.cz (duck.suse.cz [10.20.1.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.suse.cz (Postfix) with ESMTP id 0115362807F
	for <git@vger.kernel.org>; Tue, 24 Feb 2009 19:44:14 +0100 (CET)
Received: by duck.suse.cz (Postfix, from userid 10005)
	id AFB8D1F1E2F; Tue, 24 Feb 2009 19:44:14 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111327>

  Hi,

  I've been bisecting some change in Linux kernel. The output of
"git bisect log" is:
git-bisect start
# good: [bbf25010f1a6b761914430f5fca081ec8c7accd1] Linux 2.6.23
git-bisect good bbf25010f1a6b761914430f5fca081ec8c7accd1
# bad: [49914084e797530d9baaf51df9eda77babc98fa8] Linux 2.6.24
git-bisect bad 49914084e797530d9baaf51df9eda77babc98fa8
# bad: [fe071d7e8aae5745c009c808bb8933f22a9e305a] oom: add
# oom_kill_allocating_task sysctl
git-bisect bad fe071d7e8aae5745c009c808bb8933f22a9e305a
# good: [117494a1b65183f0e3fcc817b07944bc5c465050] Merge
# master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6
git-bisect good 117494a1b65183f0e3fcc817b07944bc5c465050
# bad: [419217cb1d0266f62cbea6cdc6b1d1324350bc34] Merge branch
# 'v2.6.24-lockdep' of
# git://git.kernel.org/pub/scm/linux/kernel/git/peterz/linux-2.6-lockdep
git-bisect bad 419217cb1d0266f62cbea6cdc6b1d1324350bc34
# good: [c8c55bcb43d790d97790cfa319d80045a71fde39] Merge
# git://git.infradead.org/mtd-2.6
git-bisect good c8c55bcb43d790d97790cfa319d80045a71fde39
# good: [3e9830dcabdeb3656855ec1b678b6bcf3b50261c] sched: run
# sched_domain_debug() if CONFIG_SCHED_DEBUG=y
git-bisect good 3e9830dcabdeb3656855ec1b678b6bcf3b50261c

  But after the last command, I was sent to commit
9ec76fbf7d6da3e98070a7059699d0ca019b0c9b which is far outside the window
between the last good and bad commit. How come? git version is 1.5.6.
  Thanks for any suggestions.

								Honza

PS: Please CC me since I'm not on the list.
-- 
Jan Kara <jack@suse.cz>
SUSE Labs, CR
