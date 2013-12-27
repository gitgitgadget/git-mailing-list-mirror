From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Remove the line length limit for graft files
Date: Fri, 27 Dec 2013 14:32:40 -0800
Message-ID: <20131227223240.GG20443@google.com>
References: <alpine.DEB.1.00.1312272146590.1191@s15462909.onlinehome-server.info>
 <20131227210447.GE20443@google.com>
 <alpine.DEB.1.00.1312272208070.1191@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBD6LRKOE4AIRBDEA7CKQKGQEKPLIN7A@googlegroups.com Fri Dec 27 23:32:45 2013
Return-path: <msysgit+bncBD6LRKOE4AIRBDEA7CKQKGQEKPLIN7A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f63.google.com ([209.85.219.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD6LRKOE4AIRBDEA7CKQKGQEKPLIN7A@googlegroups.com>)
	id 1VwfxV-0004TN-CD
	for gcvm-msysgit@m.gmane.org; Fri, 27 Dec 2013 23:32:45 +0100
Received: by mail-oa0-f63.google.com with SMTP id n16sf2078737oag.28
        for <gcvm-msysgit@m.gmane.org>; Fri, 27 Dec 2013 14:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=AIaRAUQL6GMWlDq9v4sVq2F0yySPz3eixEONTbnTmsI=;
        b=O0VI/UNUycHHCiGwxvf1UdK+ft806IqDIKasGdwBT8JBUP8kOSxQcaHTZYv+u+X3Kn
         mVnaOOjR91doC8nlN74VYd6UnE9Yc/Lw9xRT/uwrz0WAD2QbGtocdAfOQhKbnGvYA87+
         bCahzUw6EEXU+/aU50oSKS/fJev/bKsE7Zv0l3jHxnvKYhiq6xaqTg92GYIvLawCQDMN
         qi4gdqcFexb78bICV9Yj4pWqhXLCuiiVYY+41wbXVAO6K7dRVZzd5korQGLfmoK/kv3l
         y6We87/FX4uQXl67mZt4KgFK3oOioNiXz42gdghdxEqy8/hlvtfzUvWtWjYtOYmXfjKm
         LujA==
X-Received: by 10.182.158.167 with SMTP id wv7mr17622obb.29.1388183564423;
        Fri, 27 Dec 2013 14:32:44 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.128.130 with SMTP id no2ls1201700obb.88.gmail; Fri, 27 Dec
 2013 14:32:43 -0800 (PST)
X-Received: by 10.182.19.164 with SMTP id g4mr20559110obe.21.1388183563987;
        Fri, 27 Dec 2013 14:32:43 -0800 (PST)
Received: from mail-yh0-x22c.google.com (mail-yh0-x22c.google.com [2607:f8b0:4002:c01::22c])
        by gmr-mx.google.com with ESMTPS id i24si10766753yhe.6.2013.12.27.14.32.43
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 27 Dec 2013 14:32:43 -0800 (PST)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:4002:c01::22c as permitted sender) client-ip=2607:f8b0:4002:c01::22c;
Received: by mail-yh0-f44.google.com with SMTP id f64so2032951yha.3
        for <msysgit@googlegroups.com>; Fri, 27 Dec 2013 14:32:43 -0800 (PST)
X-Received: by 10.236.113.237 with SMTP id a73mr656285yhh.147.1388183563840;
        Fri, 27 Dec 2013 14:32:43 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id c44sm48468261yho.20.2013.12.27.14.32.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Dec 2013 14:32:43 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1312272208070.1191@s15462909.onlinehome-server.info>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Original-Sender: jrnieder@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:4002:c01::22c
 as permitted sender) smtp.mail=jrnieder@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239754>

Johannes Schindelin wrote:
> On Fri, 27 Dec 2013, Jonathan Nieder wrote:

>> Is this easy to reproduce so some interested but lazy person could
>> write a test?
>
> Yep. Make 25 orphan commits, add a graft line to make the first a merge of
> the rest.

Thanks.  Here's a pair of tests doing that.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/annotate-tests.sh          | 21 +++++++++++++++++++++
 t/t6101-rev-parse-parents.sh | 16 +++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index c9d105d..304c7b7 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -116,6 +116,27 @@ test_expect_success 'blame evil merge' '
 	check_count A 2 B 1 B1 2 B2 1 "A U Thor" 1
 '
 
+test_expect_success 'blame huge graft' '
+	test_when_finished "git checkout branch2" &&
+	test_when_finished "rm -f .git/info/grafts" &&
+	graft= &&
+	for i in 0 1 2
+	do
+		for j in 0 1 2 3 4 5 6 7 8 9
+		do
+			git checkout --orphan "$i$j" &&
+			printf "%s\n" "$i" "$j" >file &&
+			test_tick &&
+			GIT_AUTHOR_NAME=$i$j GIT_AUTHOR_EMAIL=$i$j@test.git \
+			git commit -a -m "$i$j" &&
+			commit=$(git rev-parse --verify HEAD) &&
+			graft="$graft$commit "
+		done
+	done &&
+	printf "%s " $graft >.git/info/grafts &&
+	check_count -h 00 01 1 10 1
+'
+
 test_expect_success 'setup incomplete line' '
 	echo "incomplete" | tr -d "\\012" >>file &&
 	GIT_AUTHOR_NAME="C" GIT_AUTHOR_EMAIL="C@test.git" \
diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index 7ea14ce..10b1452 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -20,7 +20,17 @@ test_expect_success 'setup' '
 	test_commit start2 &&
 	git checkout master &&
 	git merge -m next start2 &&
-	test_commit final
+	test_commit final &&
+
+	test_seq 40 |
+	while read i
+	do
+		git checkout --orphan "b$i" &&
+		test_tick &&
+		git commit --allow-empty -m "$i" &&
+		commit=$(git rev-parse --verify HEAD) &&
+		printf "$commit " >>.git/info/grafts
+	done
 '
 
 test_expect_success 'start is valid' '
@@ -79,6 +89,10 @@ test_expect_success 'final^1^! = final^1 ^final^1^1 ^final^1^2' '
 	test_cmp expect actual
 '
 
+test_expect_success 'large graft octopus' '
+	test_cmp_rev_output b31 "git rev-parse --verify b1^30"
+'
+
 test_expect_success 'repack for next test' '
 	git repack -a -d
 '
-- 
1.8.5.1

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
