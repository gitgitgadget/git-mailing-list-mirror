From: Jonathan Nieder <jrnieder@gmail.com>
Subject: jn/add-2.0-u-A-sans-pathspec (Re: What's cooking in git.git (Mar
 2013, #07; Tue, 26))
Date: Wed, 27 Mar 2013 15:25:16 -0700
Message-ID: <20130327222516.GI28148@google.com>
References: <7v620dss3j.fsf@alter.siamese.dyndns.org>
 <20130327203535.GA5220@sigill.intra.peff.net>
 <878v58worp.fsf@linux-k42r.v.cablecom.net>
 <7vy5d8jz0y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 23:25:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKyn0-0000ot-IF
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 23:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482Ab3C0WZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 18:25:22 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:57521 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754205Ab3C0WZV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 18:25:21 -0400
Received: by mail-pb0-f50.google.com with SMTP id jt11so1220039pbb.37
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 15:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=EnqBO8NOQE0weT3sbj1eMvSb3jmjAQhKJZAgMDMDyKk=;
        b=OigCuic2BqawR3zYYtcMSeUhPHBDis1gIFgGVKFQ47KxtcAB8Q/pmZ+kyf5POyare/
         kDOvyhPDwOQlRzBMtcGBZm6C3Ank2lrlw0Pix/iL9UxGubuSuxDGYtrcxZVtj4+AT3+P
         IGa91sqDAk3VKCKCM2dhh+REvXkBkvEtJ2KP7thdYmjbQ7A46r8VfAxXwpic8KWMzwFd
         D0YMHblipE/mpsfUTirBbDb0J8S9rcEOuIAFm7FMyM0vc2GtxYEPLB4Bdiicn3cHqBIw
         UJlX4iuFc3gnicon/MbJqIcApggFtfTkXP9LwB3JjY5qbcojG2PMl7iqESnn9QGP4hLb
         sWTQ==
X-Received: by 10.68.103.5 with SMTP id fs5mr19849980pbb.32.1364423121156;
        Wed, 27 Mar 2013 15:25:21 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ux10sm4310159pab.1.2013.03.27.15.25.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 Mar 2013 15:25:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vy5d8jz0y.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219342>

Junio C Hamano wrote:
> On Tue, Mar 26, 2013 at 03:40:00PM -0700, Junio C Hamano wrote:

>> * jn/add-2.0-u-A-sans-pathspec (2013-03-20) 5 commits
>>  - git add: -u/-A now affects the entire working tree
>>  - add -A: only show pathless 'add -A' warning when changes exist outside cwd
>>  - add -u: only show pathless 'add -u' warning when changes exist outside cwd
>>  - add: make warn_pathless_add() a no-op after first call
>>  - add: make pathless 'add [-u|-A]' warning a file-global function
>>
>>  Replaces jc/add-2.0-u-A-sans-pathspec topic by not warning against
>>  "add -u/-A" that is ran without pathspec when there is no change
>>  outside the current directory.
>
> I recall we had a lengthy discussion on this, but how committed are
> we on the progression of this series?  Are the bottom four ready to
> be merged to 1.8.3, or do they need more polishing?

I wanted to add tests and then other tasks took over.  Sorry.  Probably
best to get the bottom four in "next" and add tests on top later.

I have the following squashed in locally.

-- >8 --
Subject: fixup! add -u: only show pathless 'add -u' warning when changes exist outside cwd

Define ADD_CACHE_IMPLICIT_DOT in cache.h alongside the other add_to_index
flags.  This way, authors of patches adding new flags that might want to
use the same bit can know to be careful.

Requested-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks,
Jonathan

 builtin/add.c | 1 -
 cache.h       | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index ad59182..9f35df7 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -139,7 +139,6 @@ static void update_callback(struct diff_queue_struct *q,
 	}
 }
 
-#define ADD_CACHE_IMPLICIT_DOT 32
 int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
 {
 	struct update_callback_data data;
diff --git a/cache.h b/cache.h
index e493563..5de3480 100644
--- a/cache.h
+++ b/cache.h
@@ -459,6 +459,7 @@ extern int remove_file_from_index(struct index_state *, const char *path);
 #define ADD_CACHE_IGNORE_ERRORS	4
 #define ADD_CACHE_IGNORE_REMOVAL 8
 #define ADD_CACHE_INTENT 16
+#define ADD_CACHE_IMPLICIT_DOT 32	/* internal to "git add -u/-A" */
 extern int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
 extern int add_file_to_index(struct index_state *, const char *path, int flags);
 extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, int refresh);
-- 
1.8.2.rc3
