From: A Large Angry SCM <gitzilla@gmail.com>
Subject: [PATCH] Fix off-by-one error.
Date: Fri, 25 Nov 2005 19:37:30 -0800
Message-ID: <4387D87A.4000103@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Nov 26 04:37:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efqse-0002v7-P7
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 04:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932716AbVKZDhh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 22:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbVKZDhh
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 22:37:37 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:12322 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932716AbVKZDhh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Nov 2005 22:37:37 -0500
Received: by xproxy.gmail.com with SMTP id s14so881216wxc
        for <git@vger.kernel.org>; Fri, 25 Nov 2005 19:37:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=lXqndjGrMajEOiE2jVhVguMTg260QqNWYq/XdvrhFtNLhChco5fTcEG+8uNoqhw7P6qzVOQMAqfbTSNNMcqW7q/eiGkxp/L4uw0E+6fWL/hCESj8GsUqS096KMhfxtmWC0dBVYwrQ7JRgIQcXQaaMBVqrws3NvQbvOifvjJUo5U=
Received: by 10.70.30.16 with SMTP id d16mr1447688wxd;
        Fri, 25 Nov 2005 19:37:36 -0800 (PST)
Received: from ?10.0.0.6? ( [69.175.230.211])
        by mx.gmail.com with ESMTP id i15sm1086354wxd.2005.11.25.19.37.36;
        Fri, 25 Nov 2005 19:37:36 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12764>


Signed-off-by: A Large Angry SCM <gitzilla@gmail.com>

---

 name-rev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 31b3c7eeb719c61a19922f3e8bf5abd46b49b5bb
d689edabc1af589855047a16d3682dba8fd3f1e5
diff --git a/name-rev.c b/name-rev.c
index 817e36b..2a25958 100644
--- a/name-rev.c
+++ b/name-rev.c
@@ -227,7 +227,7 @@ int main(int argc, char **argv)
 
 			/* flush */
 			if (p_start != p)
-				fwrite(p_start, p - p_start, 1, stdout);
+				fwrite(p_start, p - p_start + 1, 1, stdout);
 		}
 	} else if (all) {
 		int i;
---
0.99.9.GIT
