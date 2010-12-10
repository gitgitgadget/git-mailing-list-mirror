From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/10] vcs-svn: save marks for imported commits
Date: Fri, 10 Dec 2010 04:22:16 -0600
Message-ID: <20101210102216.GB26331@burratino>
References: <20101210102007.GA26298@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 10 11:22:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR07c-0002UM-8x
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 11:22:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244Ab0LJKWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 05:22:35 -0500
Received: from mail-gy0-f194.google.com ([209.85.160.194]:33296 "EHLO
	mail-gy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846Ab0LJKWe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 05:22:34 -0500
Received: by gyf1 with SMTP id 1so1161157gyf.1
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 02:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=guEML7H74hermQFUpVxEe/0mTxpizmBN6WoUPkTbKeQ=;
        b=T680tehb/sGF9VP3Li+obkp4ctwvPzoSWMkYeqVx31zTtlmHa3qRNRSATdCNYmJyaI
         6TZdTXkzEoMuTHrQKs6IFa3glKM+hKB47YB825cYtjeAES3RGtp+vQ4SHw5GdciLwNMU
         EP9DZYG7zbG95hHuzpm9pClCl8zj2HKe5xztM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=j+x+9Jm7C5w3MGWnqXby77JnufH9Scw7NT2NLk+KrHm3dPWNolaVVG0vyE+U9zuBXd
         Aq/rvNa941SofbzTkh1RwetuOrU5gqJutNIM8gWdV8xI/b4SDiEFp8ijiAa6WwslNajc
         9SqduSw3FUDvD/ipSbMmz/cfcCIY2BzBSTgOg=
Received: by 10.236.95.131 with SMTP id p3mr1270585yhf.76.1291976553557;
        Fri, 10 Dec 2010 02:22:33 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.ameritech.net [69.209.58.175])
        by mx.google.com with ESMTPS id 26sm1805375yhl.23.2010.12.10.02.22.31
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 02:22:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101210102007.GA26298@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163397>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/fast_export.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index e6ebdb8..093ce1d 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -61,6 +61,7 @@ void fast_export_commit(uint32_t revision, uint32_t author, char *log,
 		*gitsvnline = '\0';
 	}
 	printf("commit refs/heads/master\n");
+	printf("mark :%"PRIu32"\n", revision);
 	printf("committer %s <%s@%s> %ld +0000\n",
 		   ~author ? pool_fetch(author) : "nobody",
 		   ~author ? pool_fetch(author) : "nobody",
-- 
1.7.2.4
