From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 00/21] remote-hg: general updates
Date: Thu, 11 Apr 2013 07:22:56 -0500
Message-ID: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 14:24:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGYF-0006ee-6o
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934936Ab3DKMYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:24:22 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:57724 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933891Ab3DKMYV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:24:21 -0400
Received: by mail-qc0-f182.google.com with SMTP id k19so653002qcs.41
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 05:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=VPjN1FWAgDtPJtW7CI4j3G9WL/9IhOJJiRyWXEr7OmU=;
        b=Kr1mMonCLkiwQJeruU7S7exhnIU8eXGjSibHG92pu4l9IcysOHM+geudVuvKuPlP70
         zzrikLeQ437KZwJ1dP/VrAwjFI2wGmJGKpWUSAUoE19u6gKWus08fbTFlqoh+ETD/Gir
         JlcCIyHBJVgYa6gyQmHJvHYVxODn8JSQQU3LDrTk9OZFJlwjHyuupW0OCfzUnHTKPURT
         f5Nkd8qThGHDJT1Ba7A1EoTVUiHkp2wITD+Ao9x3q47LQrNJIHhrGeE16eRvjqc0QdIz
         /SzMk9KEiy7RbIp9SC2YgUVMtbyCdMh42dzenAmVBnH3v3gVa/cQneLY4fck3Ar6Wv67
         FnXg==
X-Received: by 10.224.106.73 with SMTP id w9mr6448743qao.20.1365683061237;
        Thu, 11 Apr 2013 05:24:21 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id bt19sm7020552qab.0.2013.04.11.05.24.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 05:24:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220853>

Hi,

This is a reroll of the previous series due to a few minor issues. As the
previous version, forced pushes remain a configuration option. Also, I picked
up a fix for test regarding hg_log() that was sent to the mailing list.

Antoine Pelisse (1):
  remote-hg: activate graphlog extension for hg_log()

Dusty Phillips (2):
  remote-hg: add missing config variable in doc
  remote-hg: push to the appropriate branch

Felipe Contreras (15):
  remote-hg: trivial cleanups
  remote-hg: properly report errors on bookmark pushes
  remote-hg: make sure fake bookmarks are updated
  remote-hg: trivial test cleanups
  remote-hg: redirect buggy mercurial output
  remote-hg: split bookmark handling
  remote-hg: refactor export
  remote-hg: update remote bookmarks
  remote-hg: update tags globally
  remote-hg: force remote push
  remote-hg: show more proper errors
  remote-hg: add basic author tests
  remote-hg: add simple mail test
  remote-hg: fix bad state issue
  remote-hg: fix bad file paths

Peter van Zetten (1):
  remote-hg: fix for files with spaces

Simon Ruderich (2):
  remote-hg: add 'insecure' option
  remote-hg: document location of stored hg repository

 contrib/remote-helpers/git-remote-hg     | 122 +++++++++++++++++++++++++------
 contrib/remote-helpers/test-hg-bidi.sh   |  11 ++-
 contrib/remote-helpers/test-hg-hg-git.sh |   8 +-
 contrib/remote-helpers/test-hg.sh        |  36 +++++++++
 4 files changed, 148 insertions(+), 29 deletions(-)

-- 
1.8.2.1
