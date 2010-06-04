From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] branch: don't fail listing branches if one of the
 commits wasn't found
Date: Thu, 3 Jun 2010 21:43:45 -0500
Message-ID: <20100604024344.GB26311@progeny.tock>
References: <20100603065527.GA23439@progeny.tock>
 <1275551282-21557-2-git-send-email-simo.melenius@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	gitster@pobox.com
To: Simo Melenius <simo.melenius@iki.fi>
X-From: git-owner@vger.kernel.org Fri Jun 04 04:43:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKMsY-00042l-16
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 04:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216Ab0FDCnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 22:43:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47583 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079Ab0FDCnU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 22:43:20 -0400
Received: by iwn37 with SMTP id 37so537076iwn.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 19:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9bd5pExOyQ+coHXvtfDHT/XA0qVvx08XyTRRPZ4EziU=;
        b=eQQMx7lZNHFzBjSN/hqlY7mXEEm3jG86HXlzYsxcgwqfmvUMsWz8k9yZ1QzCM8Jfz7
         dNgGD7LL88S9LO5dvX1TOPaUikCsAQRT261DalzEHhkRRGSXsVD7Fjt/L91pgvOipnXG
         qE6xIjNzH8HzyDWHoEbW44jhrKgKprlOsa6i4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vGBI62oO+3YOT/kyjKyiPpweGrxkI5xnGo825ImEftCmfmzwF3Ek3cx0uhZC4NEYVC
         lDqBcSMdzzrBsKcmWvCMdYSAXUvvvsls4RVm/xLSy6utv1SUPUmkRqgvdzCj8megUaO4
         8uiQd5qU1U4F0pSG7kmVyk+vSfguHxJ1Ceepw=
Received: by 10.231.142.158 with SMTP id q30mr233466ibu.145.1275619399363;
        Thu, 03 Jun 2010 19:43:19 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id a8sm3080069ibi.11.2010.06.03.19.43.17
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 19:43:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1275551282-21557-2-git-send-email-simo.melenius@iki.fi>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148377>

Simo Melenius wrote:

> Signed-off-by: Simo Melenius <simo.melenius@iki.fi>

Except as pointed out by Sverre[1],

  Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

[1] http://thread.gmane.org/gmane.comp.version-control.git/148253/focus=148350

diff --git a/builtin/branch.c b/builtin/branch.c
index 2242743..d2d3c26 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -542,7 +542,7 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	free_ref_list(&ref_list);
 
 	if (cb.ret)
-		error("some refs could not be read, review stderr");
+		error("some refs could not be read");
 
 	return cb.ret;
 }
-- 
