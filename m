From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] setup: document prefix
Date: Sat, 5 Jun 2010 10:04:20 +0200
Message-ID: <20100605080420.GA1151@localhost>
References: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
 <20100603133631.GA31565@localhost>
 <7vocfr7oe6.fsf@alter.siamese.dyndns.org>
 <20100604074442.GA5117@localhost>
 <20100604075034.GB5117@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 10:05:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKoNs-0001BM-0o
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 10:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755598Ab0FEIFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 04:05:10 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:45029 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011Ab0FEIFF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 04:05:05 -0400
Received: by ewy23 with SMTP id 23so497962ewy.1
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 01:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=jSokn43ztOnQ0zBoX0POW8eC2uz+lmkv6PbFh21brkU=;
        b=SGpolKrRrvaL0enyoQdqUasJ3Zf5xSF5wUI6/qzWCOjuCJK5d99ziwJVkhMD1OiNLn
         IIDqs4JZpy2l3/+ANbSkZKCr7GrC/+V2v/4lgc+nfNEIUIdoXagwtmOFDei12cmjJ5UR
         Dglg1CUzuRB1qfcxlycRwkjeKK51/oPM4HDWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=F08nbr2wOL/hbxGkTcCBULUdVVXNv7a0yuzwIA4SJNblJJLa+EQHfMLwp65RrHhHwN
         KBKw4p5q6PRnNkMnkMz6sDgS/ZcGO6Z4+DnbniBYr9eGxpn5fSh21tUZECH19F1n7pwE
         shaqIAE7IAZPKeY8sLwNSBcmjf7NXnRz1RriA=
Received: by 10.213.34.130 with SMTP id l2mr9087099ebd.66.1275725103606;
        Sat, 05 Jun 2010 01:05:03 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id 14sm1219918ewy.2.2010.06.05.01.05.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Jun 2010 01:05:03 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OKoMe-0000SN-Vp; Sat, 05 Jun 2010 10:04:20 +0200
Content-Disposition: inline
In-Reply-To: <20100604075034.GB5117@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148460>

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Fri, Jun 04, 2010 at 09:50:34AM +0200, Clemens Buchacher wrote:
>
> By the way, I noticed that we rely on the fact that a non-empty
> prefix ends with '/'. Is that ok?

I checked and the prefix does always end in a slash currently, but
this guarantee is well hidden in the code. I would feel more at
ease to continue relying on this with the comment below.

Regards,
Clemens

 setup.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/setup.c b/setup.c
index 5716d90..0e4cfe6 100644
--- a/setup.c
+++ b/setup.c
@@ -519,6 +519,12 @@ int check_repository_format(void)
 	return check_repository_format_gently(NULL);
 }
 
+/*
+ * Returns the "prefix", a path to the current working directory
+ * relative to the work tree root, or NULL, if the current working
+ * directory is not a strict subdirectory of the work tree root. The
+ * prefix always ends with a '/' character.
+ */
 const char *setup_git_directory(void)
 {
 	const char *retval = setup_git_directory_gently(NULL);
-- 
1.7.1.2.ga1f6e
