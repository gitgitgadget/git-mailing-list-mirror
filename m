From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [GUILT] [PATCH 3/7] Testsuite: get rid of "Broken pipe" errors from
 yes.
Date: Tue, 15 Jan 2013 18:28:01 -0800
Message-ID: <20130116022801.GL12524@google.com>
References: <20130116022606.GI12524@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>,
	Theodore Ts'o <tytso@mit.edu>, Iulian Udrea <iulian@linux.com>,
	Axel Beckert <abe@deuxchevaux.org>
To: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 03:28:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvIjt-00015k-Hc
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 03:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757473Ab3APC2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 21:28:09 -0500
Received: from mail-da0-f54.google.com ([209.85.210.54]:61750 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756818Ab3APC2I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 21:28:08 -0500
Received: by mail-da0-f54.google.com with SMTP id n2so331855dad.27
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 18:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=amvDlxVw6ljIaQYMuK1k4s0Xrw0GOC8q+gDz9iFx7Dg=;
        b=NDC0SO0eksGjrA5A2FwEqfRoN8PT8VdKosYFstc/syi5P0ytezghZns0jUbsuGbe+q
         U46gPuMPoc0ftptRvqxWmYmU9HASLZPuTtdl175+RARvU1xixwVJJAgNwYZlLKzHbwSU
         fkPM60h0e+1NSz5ZKyVmzimFE0iryovYNpGD9wJKAROwLqQRF+7efi0Gh+V2YPoP+tt7
         1v7i10usinpjU6TGDnWcut7oqAqa2LfrJUosJSf30NKXiAanb4OXqJ5IOnoIZfRepVCY
         WnPEF17dCQY+qMcLJgS1E6oYc8S/LfrfRABqaSQRslJ0Thddy9LD5frulSEQ9jy572SK
         2Enw==
X-Received: by 10.66.90.1 with SMTP id bs1mr247329617pab.19.1358303285169;
        Tue, 15 Jan 2013 18:28:05 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id gl5sm11286627pbc.51.2013.01.15.18.28.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Jan 2013 18:28:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130116022606.GI12524@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213711>

From: Per Cederqvist <cederp@opera.com>
Date: Mon, 30 Apr 2012 12:27:21 +0200

Signed-off-by: Per Cederqvist <cederp@opera.com>
Acked-by: Jeff Sipek <jeffpc@josefsipek.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 regression/t-029.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/regression/t-029.sh b/regression/t-029.sh
index 83e1d2b..09450c6 100755
--- a/regression/t-029.sh
+++ b/regression/t-029.sh
@@ -21,11 +21,11 @@ echo | shouldfail guilt repair --full
 
 cmd list_files
 
-yes n | shouldfail guilt repair --full
+yes n 2>/dev/null | shouldfail guilt repair --full
 
 cmd list_files
 
-yes y | cmd guilt repair --full
+yes y 2>/dev/null | cmd guilt repair --full
 
 cmd list_files
 
@@ -33,6 +33,6 @@ cmd guilt push -a
 
 cmd list_files
 
-yes Y | cmd guilt repair --full
+yes Y 2>/dev/null | cmd guilt repair --full
 
 cmd list_files
-- 
1.8.1
