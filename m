From: "Ray Chuan" <rctay89@gmail.com>
Subject: Re: [PATCH 3/3] http-push: update tests
Date: Sat, 17 Jan 2009 21:00:16 +0000
Message-ID: <be6fef0d0901171300t44b60aedm801f6f18d88b654b@mail.gmail.com>
References: <be6fef0d0901161859qbea135bwe89e48caaa69a77c@mail.gmail.com>
	 <alpine.DEB.1.00.0901170621440.3586@pacific.mpi-cbg.de>
	 <be6fef0d0901170040r7e11806et87cc5dc3c6f13a2a@mail.gmail.com>
	 <7vsknh7og5.fsf@gitster.siamese.dyndns.org>
	 <be6fef0d0901171155p26e14aa1t90c0d7b8ec7925f3@mail.gmail.com>
	 <m3zlhpy981.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 22:01:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOIIX-00062S-Nf
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 22:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762560AbZAQVAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 16:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762245AbZAQVAU
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 16:00:20 -0500
Received: from qb-out-0506.google.com ([72.14.204.236]:41224 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760502AbZAQVAS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 16:00:18 -0500
Received: by qb-out-0506.google.com with SMTP id f11so977548qba.17
        for <git@vger.kernel.org>; Sat, 17 Jan 2009 13:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=zkzyFYEOt5PGOalBQivZax6ZmAvJY0D2ICZO7Q3Y+xM=;
        b=aD817GiC3sZ+XvZVbS0IP4QMSwnsnYnXiNIapdYx89YZrf4YI4WqDaDLyxvqCWUA3l
         eko3wwa4eD1O1SfjW8kGaJinB8vjl4CpC7HG7peT/velaVh/YIMVsZF6za6sC2W+nU/T
         J9OYIau/3Eyox1Ef4/TCBdct+XeroNrQ43mgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=RV+E4m/Ye/+J4rxh/HqR1BFLPkJnTfSvqN2POCH18poSswNwoSPXStwCTj0ilzGyvt
         3FS61Rm3wv55iRJYEfwaU+G7YzGHTNhDIcxwqD1kPzCVd4vQjQX5Uhq9uCZJvtIkUfIZ
         C0mnngmhImFxola8Fmzrl0OWqijrFv7yG19RM=
Received: by 10.114.59.1 with SMTP id h1mr2834391waa.87.1232226016381;
        Sat, 17 Jan 2009 13:00:16 -0800 (PST)
Received: by 10.114.196.2 with HTTP; Sat, 17 Jan 2009 13:00:16 -0800 (PST)
In-Reply-To: <m3zlhpy981.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106105>

change tests to expect success.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5540-http-push.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index da95886..4acc087 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -51,17 +51,17 @@ test_expect_success 'clone remote repository' '
 	git clone $HTTPD_URL/test_repo.git test_repo_clone
 '

-test_expect_failure 'push to remote repository' '
+test_expect_success 'push to remote repository' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	: >path2 &&
 	git add path2 &&
 	test_tick &&
 	git commit -m path2 &&
-	git push &&
+	git push origin master &&
 	[ -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/refs/heads/master" ]
 '

-test_expect_failure 'create and delete remote branch' '
+test_expect_success 'create and delete remote branch' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	git checkout -b dev &&
 	: >path3 &&
-- 
1.5.6.3
