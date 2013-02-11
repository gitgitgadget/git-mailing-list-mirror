From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCHv3 0/5] Add git-credential support to git-send-email
Date: Mon, 11 Feb 2013 17:23:34 +0100
Message-ID: <cover.1360599057.git.mina86@mina86.com>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:24:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4wB5-0001qa-Ey
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 17:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757886Ab3BKQX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 11:23:59 -0500
Received: from mail-ee0-f42.google.com ([74.125.83.42]:33335 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987Ab3BKQX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 11:23:58 -0500
Received: by mail-ee0-f42.google.com with SMTP id b47so3239680eek.1
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 08:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=jdJwbwvD6g7xGvJgAQGfL2MGR7SNgiL70czCBh4zyrE=;
        b=a9EgSX8wnfVlI1WMTvPZrkuCp+2L72Vp0KStGIOjXuqepKivx5kNxkpv4yPIbvY5sG
         ycSyMnFyNc7igds+/WbO0QAbjqyChcR6sX7dYTV66Xf/ViNZtyTAbf5Y1oObyAuvxBR5
         7sVWX24l/s2BRY0epVze2sQNzgINF9AZlyS4C4OnP/W30tD/NwPetoQLUPny0TSy1POw
         gaFUKgYl/xbgcaqy+752c3MQg+U94DrZeSFsxml1ELs1qwKdNOE/b9mmUNXh9Jm4IjXN
         oz/hseB7itQ76TPqlaq+0mWdGMpQHB0X4YkKm1fPDdL8cnbBDemzYp/DRYesaVD+InJe
         d4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=jdJwbwvD6g7xGvJgAQGfL2MGR7SNgiL70czCBh4zyrE=;
        b=ey86QhjErPyGjz/nu0/U6nX1gJ7dy6JtyCVrqbD69jcJ8GdEnNZWOrfkgh2pwiptrM
         ekXWpSDf+zwtQxyv9wGItDZVwtAjpfYrzGwRdMxhvWEIe9siieNDdbwEKzgb2Q/Z0PMB
         j2EBV9oR1INi6VMB20+50yuJyn09D4L+loH/2XLzxR8idLYFojVmdKedlzcyLj9pfx66
         GHlV2OBWJ4Y7Ob17l8H+wVFP7uFpy+h3dJxb005OxNOUpDYbErtYxa7BP+oUdHth8Wl4
         7cJswvex8D1bHz/RDLneORtirjSzO71Tfpnkn0jdrCq81ObGblMSpkzKWKcHBjhFnjAZ
         H43g==
X-Received: by 10.14.224.137 with SMTP id x9mr51856924eep.11.1360599836777;
        Mon, 11 Feb 2013 08:23:56 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:1d0a:8048:51b4:44a9])
        by mx.google.com with ESMTPS id 3sm63347527eej.6.2013.02.11.08.23.55
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Feb 2013 08:23:55 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.571.g3f8bed7.dirty
X-Gm-Message-State: ALoCoQnfbhrp/t0ekkqg/+m6oDnciEv3U7qnlPjNX27oQel6Ctwmdv/62BtTUqeR2FSiwq5yKisiISjE5T/9Mkm4f1F0tajsZEIexU39tDSkpbB1qPvdpC4VLudAifQfCnxIKkEKdzMUfijP+Q1Xcngd4V+FYc/UoTjGLGkRtRUBto0qiSrnO3lf6y3N9YablD+vcCRTbUOJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216040>

From: Michal Nazarewicz <mina86@mina86.com>

The third version of the patch with changes suggested by Jeff in the
4/5 patch.  Also credential_read and credential_write are now public
functions in case someone wants to write a helper in perl.

Michal Nazarewicz (5):
  Git.pm: allow command_close_bidi_pipe to be called as method
  Git.pm: fix example in command_close_bidi_pipe documentation
  Git.pm: allow pipes to be closed prior to calling
    command_close_bidi_pipe
  Git.pm: add interface for git credential command
  git-send-email: use git credential to obtain password

 Documentation/git-send-email.txt |   4 +-
 git-send-email.perl              |  59 ++++++++------
 perl/Git.pm                      | 166 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 198 insertions(+), 31 deletions(-)

-- 
1.8.1.3.571.g3f8bed7
