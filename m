From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/3] log: prettier decorations
Date: Thu, 14 May 2009 00:22:03 +0300
Message-ID: <1242249726-8514-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 23:22:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4LuR-0006Qz-AO
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 23:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755675AbZEMVWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 17:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753098AbZEMVWL
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 17:22:11 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:54588 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551AbZEMVWK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 17:22:10 -0400
Received: by fxm2 with SMTP id 2so916293fxm.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 14:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=R89QhoG0WlXCvUqX9FgKaNZfMUZ0iRErNpVdT2qdCAE=;
        b=oQ2pSj6FiNdK0WvN40oeY7Iwj53UUz491QwOdnH916vx3uH7UOSE1Uk6Nwq+f61ZD+
         Z652h2w2WQAqCU1rsl9rHqS5fYTtihQMiee0o12pOqdRYtzlJSBTdb+tbVDEcH4edVYM
         hYG1eMfQMC1Z0Oa0GCzH+WuCl9Hq/QH9kBq6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=oRDRyjJ9udbENCHw3HjiCCLhAh8XmxTZkitxWVmW96JPo9jpMWSYvk1YDtu41ZjvIt
         UMvB4JJTieckUkxckAou62ZDaaOpSD1CWrZGt8GTul7P9j800hOvTHEiuBjLuMJk3kO+
         kZavO16Ink3r32a2Hzmft4MONxUAld5VKC/pg=
Received: by 10.86.70.3 with SMTP id s3mr1755974fga.12.1242249730266;
        Wed, 13 May 2009 14:22:10 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id e11sm4004732fga.21.2009.05.13.14.22.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 May 2009 14:22:09 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119110>

Hi,

This patch series simply improves log decorations so that they look like:

(tag: v1.6.3.1, origin/maint, master)

Instead of:

(tag: refs/tags/v1.6.3.1, refs/remotes/origin/maint, refs/heads/master)

In order to do that I had to change prettify_ref to prettify_refname because
add_ref_decoration doesn't have the ref object.

Felipe Contreras (3):
  Change prettify_ref to prettify_refname
  Prettify log decorations even more
  Fix test for new log decorate

 builtin-fetch.c                   |    2 +-
 builtin-send-pack.c               |    4 ++--
 log-tree.c                        |    1 +
 refs.c                            |    3 +--
 refs.h                            |    2 +-
 t/t4013/diff.log_--decorate_--all |    6 +++---
 transport.c                       |    4 ++--
 7 files changed, 11 insertions(+), 11 deletions(-)
