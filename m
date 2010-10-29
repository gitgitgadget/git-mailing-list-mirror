From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 42/42] t1510: all failed tests are now fixed
Date: Fri, 29 Oct 2010 15:29:59 +0700
Message-ID: <20101029082959.GA18708@do>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
 <1288334934-17216-43-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 10:30:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBkLs-0004pW-Rf
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 10:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759061Ab0J2IaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 04:30:03 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54579 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756013Ab0J2IaA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 04:30:00 -0400
Received: by pwj3 with SMTP id 3so733293pwj.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 01:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2qNYsBumuEZkDlf0N0xWBZyzdnVmT1PrtwiwWaQQ/lg=;
        b=U5JIh4LvNeaY2XzJpokhK/5Bx5pK4oodLdXTX3r/c60/FSzMTCFZgIkJsacnrN95Zw
         1u62sv4DVzCGosuF/StuE428FhAf+QItum2+dXMps0qJW4wA5OZGCIHYFfiq/GydEc2G
         z+las9Ad0aWiZ+KXr0JecVvP98MwrsyOuQnIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YPkI+ohgvyTVtlYmEeSUKd/1TaL+qUOwfPI9LrBLaIPXgA3bx7PtUTARvg0tFyRZe8
         7m4l4xjeCxajJvWLC3199QK+8bpUI9qHVF/BBY7xJbJTUaXfdyENlWUelMuj/LmHYgub
         INqfgFXUUnibTI0dVWszFvGW+ZzTrBG8avG8U=
Received: by 10.142.188.6 with SMTP id l6mr1079407wff.45.1288340999940;
        Fri, 29 Oct 2010 01:29:59 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id w14sm1240889wfd.18.2010.10.29.01.29.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Oct 2010 01:29:58 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 15:29:59 +0700
Content-Disposition: inline
In-Reply-To: <1288334934-17216-43-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160317>

On Fri, Oct 29, 2010 at 01:48:54PM +0700, Nguyyyyn Thhhi Nggggc Duy wrote:
> get_git_work_tree() clean up patch impacts all three setup_* functions
> and makes it impossible to mark what patch fixes what tests. But
> everything is OK now.

And I forgot to amend the last bits in.

---8<---
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 3eddc71..0343045 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -779,7 +779,7 @@ EOF
 	GIT_DIR="$TRASH_DIRECTORY/6/.git" test_repo 6/sub/sub
 '
 
-test_expect_failure '#6: GIT_DIR(rel), core.worktree=../.. at root' '
+test_expect_success '#6: GIT_DIR(rel), core.worktree=../.. at root' '
 	cat >6/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/6/.git
 setup: worktree: $TRASH_DIRECTORY
@@ -790,7 +790,7 @@ EOF
 	GIT_DIR=.git test_repo 6
 '
 
-test_expect_failure '#6: GIT_DIR(rel), core.worktree=../..(rel) at root' '
+test_expect_success '#6: GIT_DIR(rel), core.worktree=../..(rel) at root' '
 	cat >6/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/6/.git
 setup: worktree: $TRASH_DIRECTORY
---8<---
