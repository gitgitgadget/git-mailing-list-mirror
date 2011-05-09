From: Luke Diamand <luke@diamand.org>
Subject: [PATCH/RFC v2 0/2] git-p4: user preservation improvements
Date: Mon,  9 May 2011 07:40:01 +0100
Message-ID: <1304923203-26278-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Pete Wyckoff <pw@padd.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 08:40:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJK91-000769-GT
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 08:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267Ab1EIGke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 02:40:34 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:36566 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217Ab1EIGke (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 02:40:34 -0400
Received: by wwk4 with SMTP id 4so2047019wwk.1
        for <git@vger.kernel.org>; Sun, 08 May 2011 23:40:33 -0700 (PDT)
Received: by 10.227.197.83 with SMTP id ej19mr6546816wbb.105.1304923233008;
        Sun, 08 May 2011 23:40:33 -0700 (PDT)
Received: from localhost.localdomain (cpc4-cmbg14-2-0-cust166.5-4.cable.virginmedia.com [86.30.143.167])
        by mx.google.com with ESMTPS id w25sm3545638wbd.5.2011.05.08.23.40.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 May 2011 23:40:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173197>

Junio suggested that git-p4 should warn people about username
lossage in a more sensible way. This pair of changes is
an attempt to do that.

(a) The first change is a few small improvements to git-p4, but without
spurious warnings (a bit more paranoid, get rid of a superfluous -G
and don't bother to change the user if it's already correct).

(b) The second change adds a warning to the commit message if
the authorship (based on git email vs p4 email) is going to be lost and the
user is *not* using --preserve-user. The warning can be suppressed with a git
config option.

Luke Diamand (2):
  git-p4: small improvements to user-preservation
  git-p4: warn if git authorship won't be retained

 contrib/fast-import/git-p4     |   49 ++++++++++++++++++++++++++++++++++-----
 contrib/fast-import/git-p4.txt |   16 +++++++++---
 t/t9800-git-p4.sh              |   46 +++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 11 deletions(-)
