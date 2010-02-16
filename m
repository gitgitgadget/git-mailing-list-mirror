From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: [PATCH v3 0/4] Refactoring: remove duplicated code
Date: Tue, 16 Feb 2010 23:42:51 +0000
Message-ID: <cover.1266360267.git.michael.lukashov@gmail.com>
Cc: Michael Lukashov <michael.lukashov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 00:43:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhX4h-0007JW-Vj
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 00:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933373Ab0BPXnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 18:43:21 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:50925 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757060Ab0BPXnV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 18:43:21 -0500
Received: by bwz19 with SMTP id 19so5008437bwz.28
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 15:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=SGx2Wr0gtXUw9fwBOuAx3kVOTJzQofTXnKf/55+EbkI=;
        b=ZSBoCuPc/dCCq58GfbsjdAEPMJpcGtDvJxXYtGdmA19kRDZiUUzerliC78RxzTkevZ
         yqNVB7lL12xsErIHtoGzdeMSLQhEeXiY5t7f08joZgRX+n1TmIgQHwuzz5XMaBv0VrXZ
         6aLesGihFh/GznN546smmLli/xPCihR0U3sY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=jbt6eCdEyJG7N3LRS8jm/D8ZbPnJWXKC5ef9i6mtsa7CzBvW9Tf1XmUm1t7NfJx7oZ
         XPoGm1m40+iqDSGlAm9pQcJcWJawSWtZIbkg3nY+4mVAu8TMD5VXvaoR+FtcxJn9ZTGX
         5m9e10ldRH9ec+XbimWbJ6DYjHHaceiXxez0Y=
Received: by 10.204.48.136 with SMTP id r8mr2315427bkf.149.1266363798063;
        Tue, 16 Feb 2010 15:43:18 -0800 (PST)
Received: from localhost (nat-nz.wwwcom.ru [195.62.62.242])
        by mx.google.com with ESMTPS id 13sm3315621bwz.10.2010.02.16.15.43.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 15:43:16 -0800 (PST)
X-Mailer: git-send-email 1.7.0.14.g7e948
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140174>

Hi,

Here is 3rd iteration of my refactoring patches. These patches take into
account suggestions made by Tay Ray Chuan, Johannes Sixt, Jeff King and Junio C Hamano

Michael Lukashov (4):
  Refactoring: remove duplicated code from builtin-send-pack.c and
    transport.c
  Refactoring: connect.c: move duplicated code to a new function
    'get_host_and_port'
  Refactoring: move duplicated code from builtin-pack-objects.c and
    fast-import.c to sha1_file.c
  Refactoring: move duplicated code from builtin-checkout.c and
    merge-recursive.c to xdiff-interface.c

 builtin-checkout.c     |   24 +-----
 builtin-fetch.c        |   20 +++---
 builtin-pack-objects.c |   31 +-------
 builtin-send-pack.c    |  191 ++----------------------------------------------
 cache.h                |    8 ++
 connect.c              |   83 +++++++--------------
 fast-import.c          |   29 +-------
 merge-recursive.c      |   23 +-----
 sha1_file.c            |   20 +++++
 transport.c            |   22 +++---
 transport.h            |   11 +++
 xdiff-interface.c      |   17 ++++
 xdiff-interface.h      |    1 +
 13 files changed, 123 insertions(+), 357 deletions(-)
