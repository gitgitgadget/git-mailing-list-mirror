From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 00/10] Sequencer Foundations
Date: Thu, 26 May 2011 15:53:43 +0000
Message-ID: <1306425233-504-1-git-send-email-artagnon@gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 17:54:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPcsu-0001Db-Mc
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 17:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274Ab1EZPx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 11:53:58 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47458 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928Ab1EZPx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 11:53:57 -0400
Received: by qyk7 with SMTP id 7so2796499qyk.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 08:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=W/u8u6KLT1Opi2cEhLcI1rCs2Ku/b9qVglX2onn8Nws=;
        b=H7toFqZiXBGth4Ora4evgqCzjp+VZ3SCZDHnYyU8KBNQyXzwgSDYj5UKQaVfgt32Up
         gh28omHa8JgTHlvOjIEyE+Muwi53TyeBgYqfRTpSbRg5NA9n9w4sorjQ5em9ZaE22yf2
         UB6jO98Dbe0guVE5I96UAxDAIu8tO245+VZhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kTdQyv1gQ0TkfkuLYpJ0rksmQINWZZFrMINI542UJFP9hxsDJnvcKudYiGLZsQ4tvA
         PuT9svOliTqMuWo+OaJRE8j3gda+xzh5r4Ej49EvsfL1DWmYLwqbbWT7KHS4nmRW8RIL
         FrxjsFuIxkCJW1v+SSr3jKt0PEmhaqnq9SnU8=
Received: by 10.224.201.130 with SMTP id fa2mr703068qab.364.1306425236986;
        Thu, 26 May 2011 08:53:56 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id j18sm513435qck.27.2011.05.26.08.53.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 May 2011 08:53:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174526>

Hi,

This is a quick re-roll after Junio's review of the previous
iteration; the previous iteration was posted less than 24 hours ago.
I'm in a hurry, because I want to make sure that this is ready (or
nearly ready) for merge before I actually implement more features.

Thanks for reading.

Ramkumar Ramachandra (10):
  advice: Introduce error_resolve_conflict
  revert: Propogate errors upwards from do_pick_commit
  revert: Eliminate global "commit" variable
  revert: Rename no_replay to record_origin
  revert: Introduce struct to keep command-line options
  revert: Separate cmdline parsing from functional code
  revert: Catch incompatible command-line options early
  revert: Introduce HEAD, TODO files to persist state, plan
  revert: Implement parsing --continue, --abort and --skip
  revert: Implement --abort processing

 advice.c         |   17 ++-
 advice.h         |    1 +
 builtin/revert.c |  492 ++++++++++++++++++++++++++++++++++++++----------------
 3 files changed, 360 insertions(+), 150 deletions(-)

-- 
1.7.5.GIT
