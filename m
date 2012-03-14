From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 0/5 v2] contrib/diffall: improvements
Date: Wed, 14 Mar 2012 12:38:01 -0400
Message-ID: <1331743086-32304-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 14 17:39:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7rDx-0003Ug-9c
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 17:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180Ab2CNQis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 12:38:48 -0400
Received: from mail-fa0-f46.google.com ([209.85.161.46]:37498 "EHLO
	mail-fa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756178Ab2CNQir (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 12:38:47 -0400
Received: by faas1 with SMTP id s1so430148faa.19
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 09:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=VFVPqFh/wo74wjraYo+mgFHAcCOjQWWI29KGyxA1Lcg=;
        b=OKhniCQ1QGquLTHicojlyAihSYAoSP/DjJOrqnl9vV9CzIaNiFoYXeuN7rY91tdDr6
         MoCxjiOntntXQirgjActuEjArkECQxZ18D63sTq4Ep0jGCx97VaDpZkZ1Mai8bZGuSk6
         2vNobzak8ehqh2Qgryf98PG/Dv+mc6SakMe1AQEj4oiODkFf0EEHqqhlypzxfHW4Zjrd
         QUBBAzcY3/zcS9XaM0dWi1/iiSLTvEClgSrnpi4PpNMnsLkCOjdkTFjuYIEFh1xEmSMi
         aVlRaoOHnI+o7SB81Pox9mGIolhfdnOoY9ApmYb202hhF/zuHXyBiuQUbmEqmWgFtOH8
         YWQQ==
Received: by 10.224.222.141 with SMTP id ig13mr3777689qab.63.1331743126045;
        Wed, 14 Mar 2012 09:38:46 -0700 (PDT)
Received: from localhost ([99.38.69.118])
        by mx.google.com with ESMTPS id eo4sm9627120qab.16.2012.03.14.09.38.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Mar 2012 09:38:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193126>

This series implements a number of changes to make the script more
robust.

Changes in v2:
  - Fixed a bug in patch 3/5 that copied modified working copy files
    to the wrong tmp directory location. This affected any modified
    working copy file not located at the repo root.
  - Added patch 5/5 to insure that the tmp dir is actually deleted
    when the script is run on Windows.
  - Shortened the commit message summary line for each patch.


Tim Henigan (5):
  contrib/diffall: comment actual reason for 'cdup'
  contrib/diffall: create tmp dirs without mktemp
  contrib/diffall: eliminate use of tar
  contrib/diffall: eliminate duplicate while loops
  contrib/diffall: fix cleanup trap on Windows

 contrib/diffall/git-diffall |   52 ++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

-- 
1.7.10.rc0
