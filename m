From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/3] Support for old:new remote-helper push
Date: Wed,  8 May 2013 20:31:32 -0500
Message-ID: <1368063095-22861-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 09 03:33:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaFjI-0006x9-Qr
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 03:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619Ab3EIBdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 21:33:03 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:54665 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab3EIBdB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 21:33:01 -0400
Received: by mail-oa0-f50.google.com with SMTP id l10so2834075oag.37
        for <git@vger.kernel.org>; Wed, 08 May 2013 18:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=yJ7FzMum+Dc2BlswqavyHBfpSxN3nxAikABabI6HTec=;
        b=KzZOv8KsspM1Xuvfr0u1wcjthNQ4mTVJxAIVQbN1Ks/Dll3OlslMe61XMNI4MZo1oA
         jHKxBecl7ojBpGprSR80tjzF3X2qbi5Nw/MUf6ReRacRMIEkUj/7pxsT+LStO9Rdz2Ah
         suZXg3Rghz8aAQqNrlnmTwo1n/iD7/PD4e7xxPKAwD7chbTDz3iEqPxXWOHBuXKibOqg
         G+rmO2dJ24HT7HscqFoznZKCsXGXQYnO3Va1i/NJle4TA7IydxDEfvemmR/mLIvi8uc4
         WetC77YNBbkUWd8fqSP/AWpEp66QmGkbOpr7NNSjdIWdDpLJ/ZvDAwStcsmRyBi5vses
         OqqA==
X-Received: by 10.182.92.133 with SMTP id cm5mr3142940obb.73.1368063180688;
        Wed, 08 May 2013 18:33:00 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id eq4sm1153617obb.5.2013.05.08.18.32.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 18:32:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.553.gac13664
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223706>

Hi,

In order to support pushing old:new refspecs in remote-helpers, the best way to
do what is to add an option to fast-export to rename the refs in the stream, so
here it is:

Felipe Contreras (3):
  fast-export: improve argument parsing
  fast-export: add new --refspec option
  transport-helper: add support for old:new refspec

 Documentation/git-fast-export.txt |  4 ++++
 builtin/fast-export.c             | 33 ++++++++++++++++++++++++++++++++-
 t/t5801-remote-helpers.sh         |  2 +-
 t/t9350-fast-export.sh            |  7 +++++++
 transport-helper.c                | 14 ++++++++++++--
 5 files changed, 56 insertions(+), 4 deletions(-)

-- 
1.8.3.rc1.553.gac13664
