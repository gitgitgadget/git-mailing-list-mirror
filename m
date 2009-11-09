From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 20/24] http-fetch: add missing initialization of argv0_path
Date: Mon,  9 Nov 2009 09:05:00 -0600
Message-ID: <1257779104-23884-20-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:56:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7VfE-0002nn-0l
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003AbZKIOzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755712AbZKIOzr
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:55:47 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:44620 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755931AbZKIOzp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:55:45 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3179619ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=F3/6nncxjir3R5QA0bQK4kUgqORqSsEj6Myrg1e8LYQ=;
        b=S85dE98t2GpgMFQcEvZrZ7xIbtzt/cJQr8e8RSmbbpnJbOT6t6lS36YygM3V1hfETr
         wnCTrN4dFM36DUd3ktpaZM4E9WNvH76J5zy8QWkVyMTam4Zamt4avaJzZuSu5Gc5Hy4Q
         x4QSn1CQHOy9QE/BDh/4CQzA2NoGt440xTRcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nhfbxaQLmXFExAmakzP9LIZ00vZ31SzNVWDsovJ7HUZkSQjGDd1dMsPRKv8+uhLW4n
         1k2ENd/SW8he4wt4DbkojYdmJLL21oB0k8pGfAVyZrvhBQOPpVVFj6j9btr+oOC4FeCV
         8WoRa8lD+nPQoYg60/ga7ovEHUd6Qkn2fWCNg=
Received: by 10.216.85.132 with SMTP id u4mr1507121wee.191.1257778550293;
        Mon, 09 Nov 2009 06:55:50 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.48
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:49 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132471>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 http-fetch.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index 52a4f6d..ffd0ad7 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -23,6 +23,8 @@ int main(int argc, const char **argv)
 	int get_verbosely = 0;
 	int get_recover = 0;
 
+	git_extract_argv0_path(argv[0]);
+
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
 			get_tree = 1;
-- 
1.6.5.2
