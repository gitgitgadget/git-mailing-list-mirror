From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/4] Deprecate "not allow as-is commit with i-t-a entries"
Date: Tue,  7 Feb 2012 19:46:40 +0700
Message-ID: <1328618804-31796-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 13:41:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RukMn-0006rE-0d
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 13:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756282Ab2BGMlf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Feb 2012 07:41:35 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44448 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755676Ab2BGMle (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 07:41:34 -0500
Received: by pbdu11 with SMTP id u11so5850829pbd.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 04:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=W3+z4YWJ9G+LizmiCZ8ubUbriVxRANrjnBKgUAWX648=;
        b=oCJ+aua6k1Tj+aJhpUY7mNrIfIRkMKF6Eiaf5H3vazbxkkAuOje8XWFbpGdk8KkhMN
         j+5wV/GdMMH3/3QiWIAssdGfrhw/mrn4Vj19pv8YzdWvKVV8NjAehpkf6IXJkqtZKMg0
         q4Rk9cCDkRHZrGsQbaXFgeK6zYiLipBY3ADt8=
Received: by 10.68.225.71 with SMTP id ri7mr57876713pbc.129.1328618494202;
        Tue, 07 Feb 2012 04:41:34 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id b7sm46333185pba.2.2012.02.07.04.41.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Feb 2012 04:41:32 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 07 Feb 2012 19:46:45 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190167>

 - git-add.txt changes are removed. In the end all kinds of commit
   behave the same way, not worth putting more explanation during the
   transition.

 - reword config text and warning text (or more precisely copy/paste
   from Junio/Jonathan's words)

 - Hard coded release numbers are removed. Now it's simply "in future".

 - Step 2 may be too annoying. Users are warned on every commit if
   commit.ignoreIntentToAdd is set. I think it's good because it keeps
   config file clean, but people may think otherwise.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  cache-tree: update API to take abitrary flags
  commit: introduce a config key to allow as-is commit with i-t-a entri=
es
  commit: turn commit.ignoreIntentToAdd to true by default
  commit: remove commit.ignoreIntentToAdd, assume it's always true

 builtin/commit.c       |    9 ++++++---
 cache-tree.c           |   35 +++++++++++++++++------------------
 cache-tree.h           |    5 ++++-
 merge-recursive.c      |    2 +-
 t/t2203-add-intent.sh  |   21 ++++++++++++++++++++-
 test-dump-cache-tree.c |    2 +-
 6 files changed, 49 insertions(+), 25 deletions(-)

--=20
1.7.8.36.g69ee2
