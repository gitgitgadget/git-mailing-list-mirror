From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC/PATCH 0/4] GSOC remote-svn
Date: Wed, 11 Jul 2012 15:38:49 +0200
Message-ID: <1342013933-14381-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 15:47:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoxGA-0001i6-Dt
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 15:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532Ab2GKNoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 09:44:18 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35780 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757730Ab2GKNjW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 09:39:22 -0400
Received: by bkwj10 with SMTP id j10so1074961bkw.19
        for <git@vger.kernel.org>; Wed, 11 Jul 2012 06:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=DzD+T8ir9LFIU2dcKS6EwZBrWhFny3Ep8w9hpvIZzTo=;
        b=wSXpSzvc4dVeWPFj4U49wJ0QaUZT0U1Ii3GbXJ/yIY7rKNETpSQ7SxopCWA9FmR2uB
         ae8kj04q3rOuGMcoWUVNlKlQCD7Mc8h5/iIfx9WeB4bTni0V3yyu5BeTZDuCvqgaykiw
         XVF9pZ5vUFsmN4H8WUZWreZRmp8mE+btKrLVp5kE/1R7QiUtMpQf9bdFN73xJ/kso7my
         o2s6urbHSXypIl2yOHZAjV6hd14flvh7gy/Y5wcdr4R095w4YpbvhnBdRda+kZSpKl5x
         +XyWup4oLZWDpSd/MaCUfm8CY1qZY5UO3E5DLkVjG0a1EaZTspcvHFK/7WuaxHLUkWKc
         tXUA==
Received: by 10.205.126.14 with SMTP id gu14mr24526602bkc.137.1342013961047;
        Wed, 11 Jul 2012 06:39:21 -0700 (PDT)
Received: from flobuntu.lan (91-115-86-162.adsl.highway.telekom.at. [91.115.86.162])
        by mx.google.com with ESMTPS id fu8sm1207082bkc.5.2012.07.11.06.39.18
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Jul 2012 06:39:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201299>

Hi!

This series adds creating notes to vcs-svn, plus some testing aids.
I picked one patch from Dmitry's existing work.

Next steps are storing the fetched revisions and notes in the right place
in refs/remote/ and adding incremental import using the notes.

Im currently stuck on some unexpected behaviour when fetching via 
remote-svn. The refs/remote/svn/master points to the same commit
as refs/heads/master and not to the fetched one.
It gets overwritten after fast-import terminates.
I'm digging through the internals of fetching..

Florian:

[PATCH 1/4] vcs-svn: add fast_export_note to create notes
[PATCH 2/4] Allow reading svn dumps from files via file:// urls.
[PATCH 3/4] Create a note for every imported commit containing svn
[PATCH 4/4] When debug==1, start fast-import with "--stats" instead
