From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] Consistently use "superproject" instead of "supermodule"
Date: Sun, 20 May 2012 15:28:26 +0200
Message-ID: <4FB8F17A.9090308@web.de>
References: <1337402403-7546-1-git-send-email-jon.seymour@gmail.com> <1337402403-7546-2-git-send-email-jon.seymour@gmail.com> <4FB7ECCF.9020403@web.de> <CAH3AnrrqiXqdHHGZPyOPJ3Zend5JrQX0rKV+pz_mjs3SDjv9DA@mail.gmail.com> <7v4nrbbfer.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 20 15:28:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SW6BZ-0000Cr-Pv
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 15:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755007Ab2ETN2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 May 2012 09:28:33 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:40141 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832Ab2ETN2c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2012 09:28:32 -0400
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate03.web.de (Postfix) with ESMTP id 5DF2C1B4E3676
	for <git@vger.kernel.org>; Sun, 20 May 2012 15:28:30 +0200 (CEST)
Received: from [192.168.178.48] ([79.193.81.251]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MGzFy-1SJOrH0CSw-00DnTx; Sun, 20 May 2012 15:28:29
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <7v4nrbbfer.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:yem47ldwo4mIdeXNWXVJzzTksiR02VqTY6xFpY3u+E/
 IxUhkcV9O4D7s7G79XxpTTA/6yYRlJmcsmetr5zoOezqFTh9xP
 Dxq0ev3jQ2I+8v5KDrvPPTyUTYUbRPnFfQSQdCD2wnTSToSzS1
 vpdCvu7H8Aiy7giQdXE98/fF6wehsns2YFhN0/Ff7pWTIIZO5S
 RppmKNBXnvSNCWZ8hmXjw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198059>

We fairly consistently say "superproject" and never "supermodule" these
days. But there are seven occurrences of "supermodule" left in the current
work tree. Three appear in Release Notes for 1.5.3 and 1.7.7, three in
test names and one in a C-code comment.

Replace all occurrences of "supermodule" outside of the Release Notes
(which shouldn't be changed after the fact) with "superproject" for
consistency.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 20.05.2012 07:16, schrieb Junio C Hamano:
> Jon Seymour <jon.seymour@gmail.com> writes:
> 
>> On Sun, May 20, 2012 at 4:56 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>> Am 19.05.2012 06:40, schrieb Jon Seymour:
>>>
>>> Just a small nit: I'd prefer to replace the 4 occurrences of the term
>>> "supermodule" with "superproject".
>>
>> Sure. I can't argue with precedent, of course, but I guess I was
>> favouring the consistency in the suffixes used with sub and super.
> 
> We fairly consistently say (even outside the documentation---for example,
> listen to the TechTalk Linus gave in May 2007) "superproject" and never
> "supermodule".  You can tell people who were not paying attention when
> they say "supermodule" ;-).

Or they used one of the nine commit messages in current masters history
or one the seven occurrences in the current work tree which use the term
"supermodule" as inspiration ;-)

While we can't change history and shouldn't change Release Notes, the
other uses of "supermodule" should be removed.


 t/t7408-submodule-reference.sh | 4 ++--
 t/t9300-fast-import.sh         | 2 +-
 unpack-trees.c                 | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index a45fadc..b770b2f 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -28,7 +28,7 @@ git prune'

 cd "$base_dir"

-test_expect_success 'preparing supermodule' \
+test_expect_success 'preparing superproject' \
 'test_create_repo super && cd super &&
 echo file > file &&
 git add file &&
@@ -55,7 +55,7 @@ diff expected current'

 cd "$base_dir"

-test_expect_success 'cloning supermodule' \
+test_expect_success 'cloning superproject' \
 'git clone super super-clone'

 cd "$base_dir"
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 7da0e8d..2aa1824 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1657,7 +1657,7 @@ M 160000 :6 sub
 INPUT_END

 test_expect_success \
-	'P: supermodule & submodule mix' \
+	'P: superproject & submodule mix' \
 	'git fast-import <input &&
 	 git checkout subuse1 &&
 	 rm -rf sub && mkdir sub && (cd sub &&
diff --git a/unpack-trees.c b/unpack-trees.c
index bcee99c..ad40109 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1210,7 +1210,7 @@ static int verify_uptodate_1(struct cache_entry *ce,
 			return 0;
 		/*
 		 * NEEDSWORK: the current default policy is to allow
-		 * submodule to be out of sync wrt the supermodule
+		 * submodule to be out of sync wrt the superproject
 		 * index.  This needs to be tightened later for
 		 * submodules that are marked to be automatically
 		 * checked out.
-- 
1.7.10.2.548.g9de9681.dirty
