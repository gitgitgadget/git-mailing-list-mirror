From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/9] Re-roll rr/revert-cherry-pick v2
Date: Fri,  9 Dec 2011 21:11:57 +0530
Message-ID: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 09 16:43:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ2bS-0000ws-1r
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 16:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458Ab1LIPnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 10:43:08 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45239 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab1LIPnG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 10:43:06 -0500
Received: by iakc1 with SMTP id c1so4391329iak.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 07:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=xmP6x+LViE4D/iSh9FovLtRHIFypOHF75263QCT4Q5M=;
        b=xd1hZgVxh2cXXyHKGPr1jD7ZP/31m2s8h5/3MnjJ7kaEVPO3sp49AwNMMv1qHWet3d
         OwcYEv130ZQ8hWViLRaKWT8xt3iKGJ2vLj3kEJ5gVM8C2He/NwfcnpRXx3fRH034VKV4
         o1DVy2SZUQKxt6eX7PuWnAOMqTtIkZAghZ9I4=
Received: by 10.50.87.167 with SMTP id az7mr3786915igb.64.1323445385954;
        Fri, 09 Dec 2011 07:43:05 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id a2sm18298821igj.7.2011.12.09.07.43.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 07:43:05 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186638>

Hi,

The previous iteration had 5 parts ($gmane/186425), and this one has
9.  So, I have to explain where the four new patches came from:

- "revert: report fine-grained error messages from insn parser" arises
  from Jonathan's request to split "revert: allow mixed pick and
  revert instructions".

- "revert: tolerate extra spaces, tabs in insn sheet" comes from
  Junio's request to be considerate towards people with fat fingers.

- I put in the other two patches on my own, because I realized that
  the tests needed some tightening, lest they hide underlying bugs
  (it's happened before).

Apart from that, I've just made changes in response to reviews.  I'm
not yet sure what to do about $gmane/186433.

Thanks for reading.

-- Ram

Jonathan Nieder (1):
  revert: simplify communicating command-line arguments

Ramkumar Ramachandra (8):
  revert: free msg in format_todo()
  revert: make commit subjects in insn sheet optional
  revert: tolerate extra spaces, tabs in insn sheet
  revert: simplify getting commit subject in format_todo()
  t3510 (cherry-pick-sequencer): use exit status
  t3510 (cherry-pick-sequencer): remove malformed sheet 2
  revert: allow mixed pick and revert instructions
  revert: report fine-grained error messages from insn parser

 builtin/revert.c                |  237 ++++++++++++++++++++------------------
 t/t3510-cherry-pick-sequence.sh |  157 +++++++++++++++++++++-----
 2 files changed, 252 insertions(+), 142 deletions(-)

-- 
1.7.7.3
