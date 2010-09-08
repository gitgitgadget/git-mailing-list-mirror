From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/5] Re-roll rr/fmt-merge-msg
Date: Wed,  8 Sep 2010 23:29:52 +0530
Message-ID: <1283968797-31793-1-git-send-email-artagnon@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 20:02:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtOyM-0000U4-7A
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 20:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557Ab0IHSCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 14:02:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50851 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab0IHSCF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 14:02:05 -0400
Received: by iwn5 with SMTP id 5so195346iwn.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 11:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=D1jba8wCnR7rwoQTrwEDzix6q93NM6lIoQtq/ll/HrM=;
        b=O7+I9gdWaEaFTiyEhU839j7gyAFTqGPdBF+Ywl6a3oAafy31mONVI5ENIBr4O3WttH
         cn8seUF01dc2SM5X1ESDxsYHICR7Q+9GzvMxufmRZf0ZA0aJrupbqEv63dgf9wfFjJn3
         5JN8lHbcc2KmwIUaugIQMoEbl0pnhpNS6v6/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=VcNKleGmNFEBMqnSeySjUgCWgpNBr9JMSY6duoGJ2kO5WWSxtOVAH9oxRTGIMBWcH+
         cb7tGZr9f2TwOtZiM3XOpTKBdx6sHvX8hk8aQfaDf5H+R8lligDOC6QMy5Ci5htgkJ48
         SuGRx1/XKfIW+sPBekSDQGG1VBnZOOeCRdl08=
Received: by 10.231.176.79 with SMTP id bd15mr2332106ibb.151.1283968923403;
        Wed, 08 Sep 2010 11:02:03 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id z6sm199616ibc.12.2010.09.08.11.02.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Sep 2010 11:02:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155803>

Changes since last time: Negative shortlog length is now treated as an
error. I've done it keeping in mind Jonathan's INF series.

Ramkumar Ramachandra (5):
  fmt_merge_msg: Change fmt_merge_msg API to accept shortlog_len
  merge: Make '--log' an integer option for number of shortlog entries
  merge: Make 'merge.log' an integer or boolean option
  t6200-fmt-merge-msg: Exercise 'merge.log' to configure shortlog
    length
  t6200-fmt-merge-msg: Exercise '--log' to configure shortlog length

 Documentation/git-fmt-merge-msg.txt |   16 ++++--
 Documentation/merge-config.txt      |    6 ++-
 Documentation/merge-options.txt     |    6 +-
 builtin.h                           |    7 ++-
 builtin/fmt-merge-msg.c             |   60 ++++++++++++-----------
 builtin/merge.c                     |   32 +++++++-----
 t/t6200-fmt-merge-msg.sh            |   91 +++++++++++++++++++++++++++++++++++
 7 files changed, 163 insertions(+), 55 deletions(-)

-- 
1.7.2.2.409.gdbb11.dirty
