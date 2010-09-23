From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC PATCH 0/2] submodule aware grep
Date: Thu, 23 Sep 2010 14:17:05 -0700
Message-ID: <1285276627-7907-1-git-send-email-judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 23 23:17:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OytAT-0002xQ-Os
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 23:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117Ab0IWVQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 17:16:56 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47226 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756238Ab0IWVQz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 17:16:55 -0400
Received: by pwj6 with SMTP id 6so445358pwj.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 14:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=phbq4MePTqi60vzwsX666bdX+82LoJnGQW7nqCrhBkg=;
        b=vKYZQelsTiyuQBwoSpLVLhmNku1pZ+3Hq1sqc3KdahxEWsh8pXiXhWKcQ+X0FZOLZ2
         vE/zuob+UJivqz+nQfBC0Wq8Kywh6pGVIJ6w5Cy9/RPBTnbwUf06NeR85TbCSeFpP7en
         CWQZuxITWsnSTAup6ri6HuPIK2n3WGpbNqGBA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=xSZJpKJQwtg4Vp6PKJNBoLf2gCI7vA3y1PMWfiD7TvTMvFlpAkorjNaYLfMiz1HoDN
         l/3+tUiWQCkXkCiI5K+IURtjS4HLv7RXVAOoX7d+LnPjoCoGLha4lyUvoZca+IHjrWXH
         VpUtdfI614BGvfCL0p/NcoDdNeea/owMzruZk=
Received: by 10.114.36.1 with SMTP id j1mr2456938waj.141.1285276614811;
        Thu, 23 Sep 2010 14:16:54 -0700 (PDT)
Received: from localhost.localdomain (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id o17sm2133641wal.21.2010.09.23.14.16.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Sep 2010 14:16:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156913>

This series contains 2 RFC patches that both implement a grep feature for
submodules.  The first patch is a self-contained script for contrib that should
work with most current git versions. The 2nd is basically the same
implementation but done as a proper git submodule command with some of the
helper code moved to git-sh-setup.sh

There are a couple of questions for this. Technically I'm making submodule 
grep-aware, should I be making grep submodule-aware instead? I haven't looked 
at the grep code yet but I imagine its harder.

Should I be putting the submodule_root* routines in git-sh-setup or should I be
looking at adding it to 'git rev parse' instead. I'm guessing eventually more 
commands might want to be able to get at the base superproject.

Chris Packham (2):
      contrib: add git-submodule-grep.sh
      submodule: add grep command
