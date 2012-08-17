From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 1/5] GSOC: prepare svndump for branch detection
Date: Fri, 17 Aug 2012 22:40:05 +0200
Message-ID: <1345236010-1648-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 22:40:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2TLe-0006Pq-14
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 22:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459Ab2HQUkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 16:40:22 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:63674 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932312Ab2HQUkV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 16:40:21 -0400
Received: by weyx8 with SMTP id x8so2693950wey.19
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=7CmB07NP/HFK07cwQQqYTjb2MAhSSvTBj2SrMarCuLA=;
        b=cJOJyWLKoTQSs34QzoPeamyyd5O3EIkjRBdji5aHjKKdEwMBO5edRncNWLANiCFdpj
         i3hN64KiyNu21yInuOA31l49KDI+w8xwTL40GXgU5R2K1BS2dzNx0LfJMH+SVx1WWdKD
         Zy7dUNX0MoBksxEG3O+7I6zjy8QYnAROMDqcgy/YWgPw2JlJWw/LLIDtTP+oF+fX0ovb
         n1YVWjtJaYv7zDeVrcnzJZHQIAaDIIXaQcFC3kpAxKw74fQY3qSxVNGeXREReH9wSQco
         2NuYfr9GFoSs6LWsP4PCcp11JGp1x+N0EaDQApo3GyaqMFeKtZCuu2eck9sk1VTPSLiU
         kVqw==
Received: by 10.216.237.149 with SMTP id y21mr3235892weq.102.1345236019741;
        Fri, 17 Aug 2012 13:40:19 -0700 (PDT)
Received: from flobuntu.lan (91-115-81-15.adsl.highway.telekom.at. [91.115.81.15])
        by mx.google.com with ESMTPS id b7sm17480686wiz.9.2012.08.17.13.40.17
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 13:40:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203659>

Hi!

This patch series should prepare vcs-svn/svndump.* for branch 
detection. When starting with this feature I found that the existing
functions are not yet appropriate for that.
These rewrites the node handling part of svndump.c, it is very
invasive. The logic in handle_node is not simple, I hope that I 
understood every case the existing code tries to adress.
At least it doesn't break an existing testcase.

The series applies on top of:
[PATCH/RFC v4 16/16] Add a test script for remote-svn.
I could also rebase it onto master if you think it makes sense.

Florian

 [RFC 1/5] vcs-svn: Add sha1 calculaton to fast_export and
 [RFC 2/5] svndump: move struct definitions to .h.
 [RFC 3/5] vcs-svn/svndump: restructure node_ctx, rev_ctx handling
 [RFC 4/5] vcs-svn/svndump: rewrite handle_node(),
 [RFC 5/5] vcs-svn: remove repo_tree
