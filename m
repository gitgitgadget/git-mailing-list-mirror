From: "Paul Oliver" <puzza007@gmail.com>
Subject: [PATCH] [ is explicitly disallowed by bad_ref_char
Date: Fri, 23 May 2008 09:42:04 +0100
Message-ID: <a4cc77ec0805230142n7dda9f7ahe4bde3b80f369220@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 10:43:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzSs0-0002eK-GQ
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 10:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbYEWImH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 04:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbYEWImG
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 04:42:06 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:24136 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbYEWImE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 04:42:04 -0400
Received: by rv-out-0506.google.com with SMTP id l9so636224rvb.1
        for <git@vger.kernel.org>; Fri, 23 May 2008 01:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=BZk315tzrVFHmGNlxLbLVDfKTzQSIBPm9YDnZrHlMwU=;
        b=ZZLx5PYpg2watKMoPW+rfewWOz6Y9gnWeIxWENPlWSHjtNuK4CHPDbIhwaRHY7KAEj0kd9jiJzG5bruN+xM5T/d1eVzU0pf+uIfbav1ovrZIdoKDm5tD6DUEs3iqeLkf6CP/Bsm3QTHLCllR4pwzqqJeGJ3Wx0RKJOwJKLymTW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rKbcxeOufE5XtY6Kaazhff3ctJHNrm44R931IJ9DavZvTQRwYgtcjf3k8E31/tVl2uyjvjpruDgk1xqfQ0sx1LjjjyoAKqDplLI4YLmKZ7Zbo8n2JaKcv3vwpFXft8eW510ppHAuaUNV7HasMo0AaxFtRzO/fh9oM0gi+Mc1h5k=
Received: by 10.141.171.6 with SMTP id y6mr534290rvo.143.1211532124342;
        Fri, 23 May 2008 01:42:04 -0700 (PDT)
Received: by 10.141.136.7 with HTTP; Fri, 23 May 2008 01:42:04 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82691>

---
 git-cvsimport.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index bdac5d5..5a02550 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -780,6 +780,7 @@ sub commit {
 		$xtag =~ s/\s+\*\*.*$//; # Remove stuff like ** INVALID ** and ** FUNKY **
 		$xtag =~ tr/_/\./ if ( $opt_u );
 		$xtag =~ s/[\/]/$opt_s/g;
+		$xtag =~ s/\[//g;

 		system('git-tag', '-f', $xtag, $cid) == 0
 			or die "Cannot create tag $xtag: $!\n";
-- 
1.5.3.6
