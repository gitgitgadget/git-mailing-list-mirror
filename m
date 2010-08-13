From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/2] Fix windows portability issues in en/d-f-conflict-fix series
Date: Thu, 12 Aug 2010 20:09:10 -0600
Message-ID: <1281665352-10533-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, Johannes Sixt <j.sixt@viscovery.net>,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 04:02:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojjar-0007Bj-45
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 04:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761249Ab0HMCBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 22:01:49 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42003 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761191Ab0HMCBs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 22:01:48 -0400
Received: by ywh1 with SMTP id 1so684078ywh.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 19:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=xmOHpq+cSNOCX3c/TK7ZLKAi4QeOFJlW1pDa7j7pNLE=;
        b=NsqxSLOxJr9KhxzM4MoORSrieVKYfCniwG+dEYzWHRN1tBFCgsqR3cIh//FiqxSt3/
         yS6a1hzBREV9C/EKOmZff9B6yzzBAOyrBwP8hCNVf+0a7sAHCtjJBCdtYEUrlpq4Lwyi
         NgplVPRfxlFS13BzHnaJ4US2AjH23ff35wlGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DHn0j5E7Rgv03QtuMPLX5dhuUTqws/ctvkBNbPaWcNVQ+BZQe4YWQg8HxKoBrfpSOH
         mRvAD9/UsaAsMfq3G6lrJVT9HVn+jP3WU4DISppuX1RC+5cB+JGZeewrsTkpKD89rdRP
         ttQfM/vdjEokk16fwhplR7tGnUSrqCcn7uU30=
Received: by 10.231.171.3 with SMTP id f3mr658769ibz.145.1281664907708;
        Thu, 12 Aug 2010 19:01:47 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id h8sm625597ibk.21.2010.08.12.19.01.45
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Aug 2010 19:01:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.121.gb1ae7a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153457>

This fixes two issues in next for Windows reported by Hannes, both due
to my en/d-f-conflict-fix patch series:

On Thu, Aug 12, 2010 at 3:23 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Today's next produces this warning:
>
> merge-recursive.c: In function 'process_df_entry':
> merge-recursive.c:1246: warning: unused variable 'o_sha'
>
> (line number may be different) because o_sha is only used inside assert().
> I don't know how you would like this fixed.


>> * en/d-f-conflict-fix (2010-07-27) 7 commits
>>   (merged to 'next' on 2010-08-03 at 7f78604)
>>  + t/t6035-merge-dir-to-symlink.sh: Remove TODO on passing test
>>  + fast-import: Improve robustness when D->F changes provided in wrong order
>>  + fast-export: Fix output order of D/F changes
>>  + merge_recursive: Fix renames across paths below D/F conflicts
>>  + merge-recursive: Fix D/F conflicts
>>  + Add a rename + D/F conflict testcase
>>  + Add additional testcases for D/F conflicts
>
> The new tests in t/t3509-cherry-pick-merge-df.sh and t9350-fast-export.sh
> need SYMLINKS prerequisite.

Elijah Newren (2):
  merge-recursive: Workaround unused variable warning
  Mark tests that use symlinks as needing SYMLINKS prerequisite

 merge-recursive.c               |    1 +
 t/t3509-cherry-pick-merge-df.sh |    6 ++++++
 t/t9350-fast-export.sh          |    2 +-
 3 files changed, 8 insertions(+), 1 deletions(-)

-- 
1.7.2.1.119.gca9fe.dirty
