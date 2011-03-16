From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/6] fast-import: suppress -Wuninitialized warning by
 initializing to NULL
Date: Wed, 16 Mar 2011 06:38:42 -0500
Message-ID: <20110316113842.GH15739@elie>
References: <20110316024959.GA24932@elie>
 <7vfwqnabbi.fsf@alter.siamese.dyndns.org>
 <4D807E66.40504@viscovery.net>
 <20110316094639.GA8180@elie>
 <4D8088C1.5050901@viscovery.net>
 <20110316105709.GC8277@elie>
 <20110316113540.GB15739@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 12:38:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzp40-00027q-Ao
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 12:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780Ab1CPLis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 07:38:48 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40583 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab1CPLir (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 07:38:47 -0400
Received: by gyf1 with SMTP id 1so607374gyf.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 04:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=UpH17/iOy6aw+XvqOPOD+fyh2aQ3rkwFk87eM/XwVFg=;
        b=ZKhFVRDqTO+0klVqUbfXiquUdrF3b6DXqEw48K63sC9qKki8//9P/+1AcJLTfHqNiG
         HxvMJd8e8vuQCsLK2Z1mYX7iBuogJAO7nNKoLx8Sl7jzHj33W/wc4OdDotLjirjMnPl5
         cKVr+NYXLElTvQ7tjGmRA0EnzS5F4RvqAbhD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=U9XJ/8LG/HhQM7HBuWnum61YnZYxGTwEl+IY+UdGCuTNkE/2TWjn2saNqptLMe9Y7a
         wOBYs4uLXt8G75ju1RWwC5ddiWCIoOsdcH5F0Wc0nQGOi4L1ukR6B2ca1P85RNmf/M3+
         FkPqsx9wC+q8bPixyqPB3XlVJGDsJT7UTQR1k=
Received: by 10.91.199.7 with SMTP id b7mr1219922agq.116.1300275526582;
        Wed, 16 Mar 2011 04:38:46 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id c17sm1140135anc.15.2011.03.16.04.38.45
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 04:38:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110316113540.GB15739@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169147>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's the end. :)

Good night.

 fast-import.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 565d895..75405af 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2196,7 +2196,7 @@ static void file_change_m(struct branch *b)
 	const char *p = command_buf.buf + 2;
 	static struct strbuf uq = STRBUF_INIT;
 	const char *endp;
-	struct object_entry *oe;
+	struct object_entry *oe = NULL;
 	unsigned char sha1[20];
 	uint16_t mode, inline_data = 0;
 
-- 
1.7.4.1
