From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv7.4 0/4] Gitweb caching v7.2
Date: Fri,  3 Dec 2010 20:25:31 +0100
Message-ID: <1291404335-25541-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 03 20:26:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PObGi-0002FV-IW
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 20:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006Ab0LCT0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 14:26:01 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59210 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab0LCT0A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 14:26:00 -0500
Received: by bwz15 with SMTP id 15so8656191bwz.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 11:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=xLV1R4pxVuElGmNK4IkMv2PHzO2xfSKFfNGsazctx08=;
        b=tusgV2y9MjNua2VLSXJg4KvhHOg1GJLiZv5Wg8fwkaDPL9j/oLcUuHAXEbq8QG3igs
         LV95ikas21hx2aOnHR5PsAFOEVvMr4mHjOVzoA6e/LUXKUcF0DJoElqrKM816uquGwq7
         uzTFFqJQvffnC1whQS6GHiSLd6X5qlAduvND4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Hv16Jz0vMPvtZSl6SLTyCD1B3L3l740B9GYCwNpAdtFatFFDyYLYBJwZtoTX6DFaIW
         V7wPP1puo1TwAP4d5603GDyCsC6uQzsl96s0JOnObLA1EKZv+C78ilGL03/D1JERGj4t
         Y+ozcyJtFregRzy0lWVttAKCRCfsmXEZh6JQ0=
Received: by 10.204.116.201 with SMTP id n9mr3015850bkq.138.1291404355611;
        Fri, 03 Dec 2010 11:25:55 -0800 (PST)
Received: from localhost.localdomain (abrz239.neoplus.adsl.tpnet.pl [83.8.119.239])
        by mx.google.com with ESMTPS id b17sm1064634bku.8.2010.12.03.11.25.52
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 11:25:53 -0800 (PST)
X-Mailer: git-send-email 1.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162830>

This series is a bit fixed up and a tiny bit cleaned up version of
"Gitweb caching v7" series from John 'Warthog9' Hawley:
  http://thread.gmane.org/gmane.comp.version-control.git/160147

This version of this series is based on top of 'master'


Compared to initial v7.1 fixup of "Gitweb caching v7" series it
contains fix to "gitweb: Prepare for splitting gitweb" preventing
installation and fix to "gitweb: File based caching layer (from
git.kernel.org)" that generated problems with t9501 test, as noticed
by Thomas Rast in
  http://article.gmane.org/gmane.comp.version-control.git/162787
  http://marc.info/?l=git&m=129137257619613&w=2

It also includes trivial fixup in "gitweb: Minimal testing of gitweb
caching"... but still those new tests don't pass, at least for me.
John Hawley is (according to information from #git IRC channel) is
working on "Gitweb caching v8"; I hope that it is fixed there.

Shortlog:
~~~~~~~~~
Jakub Narebski (2):
  gitweb: Prepare for splitting gitweb
  gitweb: Minimal testing of gitweb caching

John 'Warthog9' Hawley (2):
  gitweb: add output buffering and associated functions
  gitweb: File based caching layer (from git.kernel.org)

Table of contents:
~~~~~~~~~~~~~~~~~~
 [PATCHv7.4 1/4] gitweb: Prepare for splitting gitweb
 [PATCHv7.4 2/4] gitweb: add output buffering and associated functions
 [PATCHv7.4 3/4] gitweb: File based caching layer (from git.kernel.org)
 [PATCHv7.4 4/4] gitweb: Minimal testing of gitweb caching

Diffstat:
~~~~~~~~~
 gitweb/Makefile                           |   21 ++-
 gitweb/gitweb.perl                        |  136 +++++++++++-
 gitweb/lib/cache.pl                       |  348 +++++++++++++++++++++++++++++
 gitweb/static/gitweb.css                  |    6 +
 t/gitweb-lib.sh                           |   15 ++
 t/t9500-gitweb-standalone-no-errors.sh    |   20 ++
 t/t9501-gitweb-standalone-http-status.sh  |   13 +
 t/t9502-gitweb-standalone-parse-output.sh |   33 +++
 8 files changed, 581 insertions(+), 11 deletions(-)
 create mode 100644 gitweb/lib/cache.pl

-- 
1.7.3
