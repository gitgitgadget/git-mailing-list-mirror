From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 14/19] t/t5000-tar-tree.sh: convert test -a/-o to && and ||
Date: Tue, 20 May 2014 06:50:27 -0700
Message-ID: <1400593832-6510-15-git-send-email-gitter.spiros@gmail.com>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 15:51:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmkRh-0000Bh-UP
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 15:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbaETNuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 09:50:55 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:56574 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603AbaETNux (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 09:50:53 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so340235pab.24
        for <git@vger.kernel.org>; Tue, 20 May 2014 06:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wT5KVC3yLPbr01LjVQ1mtquHrY7w585EuIOjjyhBENk=;
        b=TCXQ1e2wluWzluYy4vAIafJfdCoflQ+KWXx7wmmSlAlX+O69AQpmqXPg0ooNJSM8QT
         p71BTGW0pXt/QFDiXuQdK7AMa5g+quuXPTuk20XNFc/LCoiANgugNhg1KbAWdXzFi+u/
         9A+oYKZGGLoFt7xhiAgqFyydLr/TfjXPPyTvwR+KprPO2mHiWFGmkmh9z3GkdL4CKZNj
         X3VmASceyhK3EJ6EvvhkuKxDK2YN+Moixb5/P21Il6kV8NeQ7yQKr30rw09wN7ILQDdJ
         yIXiGFmZScE1km/J54j+a/p2shhsZJ3sYZYE2+uVzVXHSAbITm8XidKe2HqqB5rFOgKZ
         qXnA==
X-Received: by 10.66.233.72 with SMTP id tu8mr50968292pac.112.1400593852666;
        Tue, 20 May 2014 06:50:52 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id oe4sm3317286pbb.33.2014.05.20.06.50.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 06:50:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249669>

The interaction with unary operators and operator precedence
for && and || are better known than -a and -o, and for that
reason we prefer them. Replace all existing instances
of -a and -o to save readers from the burden of thinking
about such things.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t5000-tar-tree.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 1cf0a4e..4b57cbd 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -72,7 +72,7 @@ check_tar() {
 			for header in *.paxheader
 			do
 				data=${header%.paxheader}.data &&
-				if test -h $data -o -e $data
+				if test -h $data || test -e $data
 				then
 					path=$(get_pax_header $header path) &&
 					if test -n "$path"
-- 
1.7.10.4
