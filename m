From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] gitk: Add comments to explain encode_view_opts and
 decode_view_opts
Date: Sat, 6 Mar 2010 16:48:38 -0600
Message-ID: <20100306224837.GB7064@progeny.tock>
References: <20100306224605.GA7064@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steve Cotton <steve0001@s.cotton.clara.co.uk>,
	Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Mar 06 23:48:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No2nT-0001cP-Dx
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 23:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898Ab0CFWsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 17:48:30 -0500
Received: from mail-iw0-f202.google.com ([209.85.223.202]:42392 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632Ab0CFWs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 17:48:29 -0500
Received: by iwn40 with SMTP id 40so1291879iwn.1
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 14:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SEBxM3t1GdECTfUeHrrTNPEBmwkU0yfQC8b1RMb3U9k=;
        b=P1KrPdJQ5AFKRhkJRCW9FAOrEdIUWqFCx/GiDY/J4gb2Ksee9iiXsnOzJe1N3LOWvz
         HOOJJRogcqUctg++sfmepJ9KB7EJNiUhRVXujxsQuurceRyuN0rBIYE7ERMENDrxGHUI
         svXjkPf8oexV/cyFWxkg64wgC9aCgLH9VLXoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=D5hLLx0OvRsUX7tthmV9eWDmzODbuyR2uHjX94FRcJFXn6d6N6uvSDu7dly2FNR1jW
         q1krWkNTqCTIsd5cNxN86FL8gwqpLpzWMpLrwZeR/qItBqueAbAWk7TWid40rsINjR1h
         Fz3f6Hj7h7drJfUtuI9nLHQP3CmODcbZ1ruH8=
Received: by 10.231.160.205 with SMTP id o13mr1144996ibx.13.1267915709308;
        Sat, 06 Mar 2010 14:48:29 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm2844554iwn.5.2010.03.06.14.48.28
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 14:48:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100306224605.GA7064@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141625>

Summarize these functions to save the reader some time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 gitk |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 1f36a3e..7f498b5 100755
--- a/gitk
+++ b/gitk
@@ -3845,6 +3845,7 @@ set known_view_options {
     {cmd       t50= +  {}               {mc "Command to generate more commits to include:"}}
     }
 
+# Convert $newviewopts($n, ...) into args for git log.
 proc encode_view_opts {n} {
     global known_view_options newviewopts
 
@@ -3878,6 +3879,7 @@ proc encode_view_opts {n} {
     return [concat $rargs [shellsplit $newviewopts($n,args)]]
 }
 
+# Fill $newviewopts($n, ...) based on args for git log.
 proc decode_view_opts {n view_args} {
     global known_view_options newviewopts
 
-- 
1.7.0
