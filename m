From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [RFC] Interactive-rebase doesn't pick all children of "upstream"
Date: Sat, 21 May 2011 01:51:17 -0400
Message-ID: <1305957078-19111-1-git-send-email-andrew.kw.w@gmail.com>
References: <20110517161234.GA21388@sigill.intra.peff.net>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 08:53:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNg4H-000538-4p
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 08:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728Ab1EUGxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 02:53:40 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35536 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab1EUGxi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 02:53:38 -0400
Received: by iyb14 with SMTP id 14so3434773iyb.19
        for <git@vger.kernel.org>; Fri, 20 May 2011 23:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=oE7E/bEzcKCIr9g57CngliQi040sAEoWIumzqZsT1oU=;
        b=M9rmpJHeODRde6Jbt+fBK/4Dazn89vHwDy6fnF/bAfAkT2LxOQMDg4Kb1NFJnblHE4
         urvLpyPbcFfRICzJCwKS3yql5GrJ8Qsd+GkQHKpPTUyUfeHH7mbbRa8MegcqOyH6BGQc
         1/p9QCMUksRjI0mtPfOslWPH31gaHlUhOy4Uo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GJ9V8q7+EVtGXSBIM1zpiulMjnuI8f9neWbC5APwhi75NRm6jixsKGcN/7KEoXJcKS
         uHWLKVkuGsA92QFhshtcFYIr+igDG6wTlpqc9M4geoPptePYde4pb2VSVu8u+a0oDn1I
         4YKOjU/bGZK59RRdbyfugsLSPnWFtyyPsG71U=
Received: by 10.42.171.9 with SMTP id h9mr6033013icz.37.1305960818410;
        Fri, 20 May 2011 23:53:38 -0700 (PDT)
Received: from localhost.localdomain (24-246-58-202.cable.teksavvy.com [24.246.58.202])
        by mx.google.com with ESMTPS id xe5sm1665579icb.22.2011.05.20.23.53.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 May 2011 23:53:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.2.316.gd7d8c.dirty
In-Reply-To: <20110517161234.GA21388@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174092>

This is a work-in-progress patch for this issue.  Since this patch changes a
fairly significant behavior in interactive-rebase, I want to try to get some
feedbacks before I go ahead and start writing some tests for this new behavior.

Andrew Wong (1):
  Interactive-rebase doesn't pick all children of "upstream"

 git-rebase--interactive.sh               |    7 +++++--
 t/t3404-rebase-interactive.sh            |    2 +-
 t/t3411-rebase-preserve-around-merges.sh |    2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

-- 
1.7.5.2.316.gd7d8c.dirty
