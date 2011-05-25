From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/2] gitweb: Improve handling of configuration files
Date: Wed, 25 May 2011 18:35:25 +0200
Message-ID: <1306341328-11108-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Drew Northup <drew.northup@maine.edu>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 18:35:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPH3n-0002q9-Ob
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 18:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159Ab1EYQfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 12:35:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37415 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757793Ab1EYQfo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 12:35:44 -0400
Received: by fxm17 with SMTP id 17so5498279fxm.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 09:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=7rEI0AOrxr+8b2FrbTUKdiY+6unjVRKN+Gr/s1/OLE4=;
        b=aKKqfb6gbdyN6jGgOjHFC10ERuk4NFYFU/03SADzFPELdhNmA+Mydk7BRp8ClqdNCb
         eJFWBalBAk3J+atGD4SQqH7f4LCGZkKlxs0D566zOLYu+AkVdCEcJSZZxfpSXD1w/duC
         brHq9AHtmTvmljb7h8G4rbSium4f3y5f+ZUU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nrIbZ3igW+doWURSXc8XJeIi+1DpY9oPQOwzw7vs4Q4+wfHUURTqsN+DqT0VKSJDip
         W/0kjhw8Y3ehYQ0IbBtGhr0MOzqHeGFs91A2qx+YDuQyKZ/0sMdaPZeTL59daSXAMDoo
         Eo870VlF7arV4LNC322JrjH6Em1dL3frfHvJw=
Received: by 10.223.41.89 with SMTP id n25mr5336520fae.7.1306341343440;
        Wed, 25 May 2011 09:35:43 -0700 (PDT)
Received: from localhost.localdomain (abvv43.neoplus.adsl.tpnet.pl [83.8.219.43])
        by mx.google.com with ESMTPS id i6sm295066faa.10.2011.05.25.09.35.41
        (version=SSLv3 cipher=OTHER);
        Wed, 25 May 2011 09:35:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.189.gcec93
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174424>

This two-in-one series is response to Junio's concerns about being
backwards-incompatibile and different ways of solving "system-wide
policy" problem.

Patches 2/2 version A and 2/2 version B are mutually exclusive.
Junio, you would have to choose which one to include.

Drew, is the solution proposed in version A (making it easy to include
system-wide config in per-instance config) acceptable solution?

Table of contents:
~~~~~~~~~~~~~~~~~~
 [PATCH 1/2] gitweb: Refactor reading and parsing config file into
 [PATCHv1 2/2 (version A)] gitweb: Mention read_config_file in gitweb/README
 [PATCHv3 2/2 (version B)] gitweb: Use /etc/gitweb.conf even if gitweb_conf.perl exist

Shortlog:
~~~~~~~~~
Jakub Narebski (2):
  gitweb: Refactor reading and parsing config file into read_config_file
  gitweb: Mention read_config_file in gitweb/README

or

Jakub Narebski (2):
  gitweb: Refactor reading and parsing config file into read_config_file
  gitweb: Use /etc/gitweb.conf even if gitweb_conf.perl exist


Diffstat:
~~~~~~~~~
 gitweb/README      |   10 ++++++++++
 gitweb/gitweb.perl |   28 ++++++++++++++++++++--------
 2 files changed, 30 insertions(+), 8 deletions(-)

or

 gitweb/INSTALL     |    8 +++++---
 gitweb/README      |    2 +-
 gitweb/gitweb.perl |   29 +++++++++++++++++++++--------
 3 files changed, 27 insertions(+), 12 deletions(-)

-- 
1.7.5
