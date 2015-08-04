From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/10] Port branch.c to ref-filter.
Date: Tue, 4 Aug 2015 18:29:44 +0530
Message-ID: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 04 15:01:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMbq8-00035K-Sl
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933888AbbHDNBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:01:03 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35172 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933552AbbHDNAO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:00:14 -0400
Received: by oihn130 with SMTP id n130so4468614oih.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=SfWUiJrMT4s2itIzrYI6I352BHmf0kc0RhY0MH5z3+4=;
        b=EleVlHyo4VAeptp5iQDsgultEhyNrh+4lhOA3LoSCIL0fscXNzVrPjzePg9sMT1ct7
         pyfyy0OySYguyAlP6lu99bVpTd4PY0z+nUz47YUEraUIX/HNRjPDJjYeludqkOr88ia+
         N3IRWAS81Dkh7x334DM4Gg1HVUFsKP9IUomi6vH2AGR0tX7Ppxy4SePp/n/AqrhWLYOw
         7IgJJf7d5DD2w6W1qg29lx4aH+VpIHMKyZcJl0FqSyPEeRWL90qC0cSBSJ4Mc1Lf/eZt
         O/lbJ1UdFYI9REHX72BRtkyKdYsI+3buU4c+kzWfqqTytRr6TWuSEbaFyg9Kr8M7u6os
         aBYQ==
X-Received: by 10.202.180.133 with SMTP id d127mr2861298oif.104.1438693213866;
 Tue, 04 Aug 2015 06:00:13 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Tue, 4 Aug 2015 05:59:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275264>

This is part of my GSoC project to unify git tag -l, git branch -l,
git for-each-ref.  This patch series is continued from: Git (next)
https://github.com/git/git/commit/bf5418f49ff0cebc6e5ce04ad1417e1a47c81b61

This series consists of porting branch.c over to using the ref-filter
APIs. This does not involve the usage of show_ref_array_item() as it
has its own changes to be made, and on suggestion of my mentors I have
decided to split the porting of branch.c to this and eventually
implementation of the "--format" option.

The RFC version can be found here :
article.gmane.org/gmane.comp.version-control.git/274737

This is a follow up to the port of tag.c to use ref-filter APIs.
(currently in the 9th iteration)

Changes :
* Change the order of ref_kind[] structure in filter_branch_kind.
* Commit message changes.
* Comments added if required.
* Small code changes.

No interdiff as this was a split version and might as well be treated
as the start of the patch series.

-- 
Regards,
Karthik Nayak
