From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 00/20] remote-hg: general updates
Date: Mon,  8 Apr 2013 12:13:14 -0500
Message-ID: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:14:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFeS-0003dh-He
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934358Ab3DHROg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:14:36 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:44489 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762484Ab3DHROg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:14:36 -0400
Received: by mail-ob0-f178.google.com with SMTP id ni5so1420571obc.23
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=HBYcIss2zgndEjlONqACrgZ++xtqsdZrvkJllEOxqWY=;
        b=eBJlJ/l3QIlF0KmVxszquAez+tvaIz9odeXOoetqVqG+jr7pQ9bRwLcBu8yWe9P99c
         T/oCwa++r+4Na/2OcdiG9qSplke3Y0ZpslI40IvlRf2mgk46VSvum2BKG3wkE4B4Keuu
         WQ2H1nK2k6A21lCmGijl8Is0kljt4et7AYG5IRWjYywvUSc6j/oxql9kSH/C+0EvdhCc
         3csboVaGG+O6F2MTr5hWhzGloBwPHhpOS7BlaTFF5cDgrwIIYxyJeX5uM0VuMlJBHmwr
         IH5ga8WdsQaXBINQyiBszCbUJY+E6rGkyLBLDv4pbXbcMmN52/ScYYituZWBLn2hatXF
         5Odg==
X-Received: by 10.60.30.131 with SMTP id s3mr16482826oeh.106.1365441275520;
        Mon, 08 Apr 2013 10:14:35 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id a3sm26137689oee.8.2013.04.08.10.14.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:14:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220443>

Hi,

Since forced pushes make some people nervous, this new patch series adds a
configuration variable. Also, I added a few more patches that should be safe,
fix important issues and/or add nice features.

I'm still holding on to the ones that I consider less safe.

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
 contrib/remote-helpers/test-hg-bidi.sh   |   6 +-
 contrib/remote-helpers/test-hg-hg-git.sh |   4 +-
 contrib/remote-helpers/test-hg.sh        |  36 +++++++++
 4 files changed, 141 insertions(+), 27 deletions(-)

-- 
1.8.2
