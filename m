From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/7] environment.c: remove unused variable
Date: Sat, 2 Oct 2010 03:35:29 -0500
Message-ID: <20101002083529.GD29638@burratino>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org>
 <20100810032647.GA2386@burratino>
 <20101002082752.GA29638@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 02 10:38:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1xcC-0003v5-Sa
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 10:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521Ab0JBIij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Oct 2010 04:38:39 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46531 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab0JBIii (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Oct 2010 04:38:38 -0400
Received: by iwn5 with SMTP id 5so4739992iwn.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 01:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=xcWWKS3yuoHDYl8E/+MaR0UjFxnOh/qkr+gGz/XxITE=;
        b=STEKXsC9yK8ar0XK/HNGWuGdi8aOOTgg875EVP9AxazWvH9dP9ehGWToMUpzUMqOPW
         S+A++tqIpi+F3HBWbH6qLwjLVju58aKQHEHUCdVdM1GbJdtEU2btMZV7+bRSiozU4mQx
         CusOcXwIsclwRX7yoJmjGzc0kqySQF914LXAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FGIBjXuMoeo9Dc5TNXs6MBkWsyOVqsQ/C5H5n6ESsEZA665xlpDvUHaJ/QWYMKWQDo
         HeeF+d0MlsmAUq5bwBzjpetX8wjplkDMA6JLZtar99KvJfOZPOkzQU+fM2yJIKuNZw8l
         4/uSNT5bcF9iOek0cKLm5gcbhmYIZBMGuZ880=
Received: by 10.231.36.8 with SMTP id r8mr2240397ibd.128.1286008718131;
        Sat, 02 Oct 2010 01:38:38 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id g31sm2230104ibh.4.2010.10.02.01.38.37
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 01:38:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101002082752.GA29638@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157798>

After v1.6.0-rc0~230^2^ (environment.c: remove unused function,
2008-06-19), git_refs_dir is not used any more.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 environment.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/environment.c b/environment.c
index 2d0c315..c44a30b 100644
--- a/environment.c
+++ b/environment.c
@@ -64,7 +64,7 @@ char *git_work_tree_cfg;
 static char *work_tree;
 
 static const char *git_dir;
-static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
+static char *git_object_dir, *git_index_file, *git_graft_file;
 
 /*
  * Repository-local GIT_* environment variables
@@ -96,8 +96,6 @@ static void setup_git_env(void)
 		git_object_dir = xmalloc(strlen(git_dir) + 9);
 		sprintf(git_object_dir, "%s/objects", git_dir);
 	}
-	git_refs_dir = xmalloc(strlen(git_dir) + 6);
-	sprintf(git_refs_dir, "%s/refs", git_dir);
 	git_index_file = getenv(INDEX_ENVIRONMENT);
 	if (!git_index_file) {
 		git_index_file = xmalloc(strlen(git_dir) + 7);
-- 
1.7.2.3
