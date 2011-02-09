From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v3 0/3] Updated patch series for default upstream merge
Date: Tue,  8 Feb 2011 19:23:45 -0500
Message-ID: <1297211028-14382-1-git-send-email-jaredhance@gmail.com>
References: <1297198129-3403-1-git-send-email-jaredhance@gmail.com>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 09 01:24:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmxqx-0001Po-L7
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 01:24:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756009Ab1BIAYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 19:24:07 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45295 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755995Ab1BIAYG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 19:24:06 -0500
Received: by qyk12 with SMTP id 12so5311853qyk.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 16:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=nRb3RqsSCk74TvoEmJgREr0s057MPD/raRCCqn6kgt8=;
        b=KuzG/iBKhwrJ0V7QEv7GVR+XNxYMGXfMdFc8vVfOQuth37SYhao2o1wFCGhbn11jgK
         CkP7kqtVj8LR08ti1A0SI1ilioWYvHkXLaSMdaOQLXhECs+UB7l5sY2j4fm0H5UjYsDF
         H4A/aP04j0n0qqYN4Zh9xv/DzoYcRaHdVe06w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lTMQhEqV04ZrNsMPodusJGr02wMS79zBjknPPCYuwNYu7JkU/0VZdqpaWLR9LNxZPZ
         lKHUdGr1FZzX9fVjio95HyUgzflfusjO3uzk897QNCEQHHGu0aR7Os+FFeVU3fNn9pij
         n18ovH9yyBOhWYl3y7DhWLWRHPBVhWZIekzJA=
Received: by 10.229.91.147 with SMTP id n19mr14306391qcm.153.1297211044904;
        Tue, 08 Feb 2011 16:24:04 -0800 (PST)
Received: from localhost.localdomain (cpe-75-186-7-248.cinci.res.rr.com [75.186.7.248])
        by mx.google.com with ESMTPS id nb15sm35516qcb.26.2011.02.08.16.24.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Feb 2011 16:24:04 -0800 (PST)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1297198129-3403-1-git-send-email-jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166377>

This patch series allows for `git merge` to default to the upstream branch
of the current branch.

Notes/Complications:
	- I'm not sure whether the option should be merge.defaultUpstream
	  or merge.defaultToUpstream
	- Should [remotes] be changed to [branches]? I felt like it was
	  a completely different change and didn't belong in the patch series.
	- I left one of the ifs with unnecessary braces for clarity because
	  of a nested if-else: is this the preferred style?

Jared Hance (3):
  Add setup_merge_commit function to merge/builtin.c.
  Add function per_branch_config.
  Add support for merging from upstream by default.

 Documentation/config.txt |    6 +++
 builtin/merge.c          |   87 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 68 insertions(+), 25 deletions(-)

-- 
1.7.4
