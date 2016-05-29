From: Dave Nicolson <david.nicolson@gmail.com>
Subject: [PATCH 2/2] Fix tests
Date: Sun, 29 May 2016 15:36:21 +0000
Message-ID: <01020154fd28aaa8-7c49c7ef-eed2-4092-80c5-6f43986f174a-000000@eu-west-1.amazonses.com>
References: <01020154fd28aa12-f536bf3e-58df-4d1f-b903-929b429954d3-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 17:39:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b72ns-0006MY-1G
	for gcvg-git-2@plane.gmane.org; Sun, 29 May 2016 17:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbcE2PgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2016 11:36:24 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:39683
	"EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752730AbcE2PgX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2016 11:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1464536181;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=txe/1rROQT5d7iO6vKTiHZvsWDtxfSt9u2SGtS3LCzo=;
	b=bmsWrOf+0/Jwm/2J8BGOn9WPQgs0JrLa2sXN509yfWWT/Ug7RCFGnl5iJf4RhUXR
	EhR/EGvgAdzaiMyYvOZPURogDs64bbLPKrfWe8iB2S88vbrbF6IyOqVluLNDw7zig60
	Q3DIA9L78UD9kShvS1n+DEAFhFQpPqv3zfExscQw=
In-Reply-To: <01020154fd28aa12-f536bf3e-58df-4d1f-b903-929b429954d3-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.05.29-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295833>

---
 t/lib-diff-alternative.sh        | 4 ++--
 t/t4029-diff-trailing-space.sh   | 2 +-
 t/t4034-diff-words.sh            | 2 +-
 t/t4051-diff-function-context.sh | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/lib-diff-alternative.sh b/t/lib-diff-alternative.sh
index 8b4dbf2..4a5d9d0 100644
--- a/t/lib-diff-alternative.sh
+++ b/t/lib-diff-alternative.sh
@@ -66,7 +66,7 @@ index 6faa5a3..e3af329 100644
 +++ b/file2
 @@ -1,26 +1,25 @@
  #include <stdio.h>
- 
+
 +int fib(int n)
 +{
 +    if(n > 2)
@@ -86,7 +86,7 @@ index 6faa5a3..e3af329 100644
          printf("%d\n", foo);
      }
  }
- 
+
 -int fact(int n)
 -{
 -    if(n > 1)
diff --git a/t/t4029-diff-trailing-space.sh b/t/t4029-diff-trailing-space.sh
index 3ccc237..751469c 100755
--- a/t/t4029-diff-trailing-space.sh
+++ b/t/t4029-diff-trailing-space.sh
@@ -27,7 +27,7 @@ test_expect_success \
      git config --bool diff.suppressBlankEmpty true &&
      git diff f > actual &&
      test_cmp exp actual &&
-     perl -i.bak -p -e "s/^\$/ /" exp &&
+     perl -i.bak -p -e "s/^\$//" exp &&
      git config --bool diff.suppressBlankEmpty false &&
      git diff f > actual &&
      test_cmp exp actual &&
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index f2f55fc..7458e61 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -106,7 +106,7 @@ test_expect_success '--word-diff=porcelain' '
 		-h(4)
 		+h(4),hh[44]
 		~
-		 # significant space
+		# significant space
 		~
 		 a = b + c
 		~
diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
index 001d678..f786139 100755
--- a/t/t4051-diff-function-context.sh
+++ b/t/t4051-diff-function-context.sh
@@ -57,7 +57,7 @@ diff --git a/hello.c b/hello.c
  {
 -	/* Classic. */
  	printf("Hello world.\n");
- 
+
  	/* Success! */
  	return 0;
  }
@@ -73,12 +73,12 @@ diff --git a/hello.c b/hello.c
 --- a/hello.c
 +++ b/hello.c
 @@ -9,9 +9,8 @@ static int a(void)
- 
+
  static int hello_world(void)
  {
 -	/* Classic. */
  	printf("Hello world.\n");
- 
+
  	/* Success! */
  	return 0;
  }

--
https://github.com/git/git/pull/245
