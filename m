From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/17] Documentation: clarify quoting in "git rm" example
Date: Fri, 20 Aug 2010 05:30:24 -0500
Message-ID: <20100820103024.GF10407@burratino>
References: <20100820101902.GA10356@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Carl Worth <cworth@cworth.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 12:32:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmOtT-0002jC-4f
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 12:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336Ab0HTKcJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 06:32:09 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48323 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904Ab0HTKcG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 06:32:06 -0400
Received: by gwj17 with SMTP id 17so1158800gwj.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 03:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=nXgSWqSy9QCZK4acoYhYOPz2Ho4XsbHPAQIKZhkaDps=;
        b=kg4NmaJRw21oRJu1IILtsdyvn8pJTfGHeC8u+glxENy/O70qa1pZp0rd7hfQ28DaQp
         5fzhNiYQLstN6W3OCgJCyPFZnOgtV3jebO/8AZbKYF79kG4r2emRLvbO0QRqcKt38FH1
         JvH//T3o8QXg17ec93x8P02UoSFWwr+MueJq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=G/r6MqI+JEoATBovG4odnibBDlsJcE92ifrQbw12psfYuWWGKy7Bi4NgTdsBRDqisG
         dCr/JTlHRIw4sXCylwgIfZ2ntxwkmmntUW86tInVAzjGZOLoCQyUcB13XgT7W51BugwM
         NGFhk4xWxs3EIL0iIl6RRZlFQyu2yixr77E0M=
Received: by 10.100.232.8 with SMTP id e8mr1422810anh.42.1282300325741;
        Fri, 20 Aug 2010 03:32:05 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id u14sm4332048ann.0.2010.08.20.03.32.04
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 03:32:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820101902.GA10356@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154000>

Intended output:

	git rm Documentation/\*.txt
		Removes all *.txt files from the index that are under
		the Documentation directory and any of its
		subdirectories.

		Note that the asterisk * is quoted from the shell in
		this example; this lets git, and not the shell, expand
		the pathnames of files and subdirectories under the
		Documentation/ directory.

Without this change, there are too many backslashes output.
Tested with asciidoc 8.5.2.

Reported-by: Fr=C3=A9d=C3=A9ric Bri=C3=A8re <fbriere@fbriere.net>
Cc: Carl Worth <cworth@cworth.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-rm.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index d146751..71e3d9f 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -136,11 +136,11 @@ git diff --name-only --diff-filter=3DD -z | xargs=
 -0 git rm --cached
=20
 EXAMPLES
 --------
-git rm Documentation/\\*.txt::
-	Removes all `\*.txt` files from the index that are under the
+git rm Documentation/\*.txt::
+	Removes all `*.txt` files from the index that are under the
 	`Documentation` directory and any of its subdirectories.
 +
-Note that the asterisk `\*` is quoted from the shell in this
+Note that the asterisk `*` is quoted from the shell in this
 example; this lets git, and not the shell, expand the pathnames
 of files and subdirectories under the `Documentation/` directory.
=20
--=20
1.7.2.2.536.g42dab.dirty
