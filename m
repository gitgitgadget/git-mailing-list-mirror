From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] Documentation/SubmittingPatches: Explain the rationale of git notes
Date: Wed, 17 Dec 2014 17:08:13 -0800
Message-ID: <1418864895-18583-1-git-send-email-sbeller@google.com>
References: <xmqq1tnx961q.fsf@gitster.dls.corp.google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 02:08:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1Pa0-0003o4-Va
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 02:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbaLRBI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 20:08:29 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36313 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbaLRBI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 20:08:28 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so20281igb.4
        for <git@vger.kernel.org>; Wed, 17 Dec 2014 17:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OY/ma7FsqAwHUMoTyHl1ZlpK1LtNHBVpaKcd19MSoOs=;
        b=cJ8ZJyJsowOG8iQD8D2PNFT5hgH8174d9XH+HpL4AQGcXVsOluwrq+989f5/xLLn9k
         NUvJXVs/y4SHhYN9gwAYFi/klUMj/VkxnwnMO9yVRN2SVKTZc52XvH9nqdWWMKhgBe9E
         VLyeUCiAZ0UwdIOd3jQpvbnTuUQ9l+LzkYCzC1FbpUAr9TzCu+D44BWfepQ9MyUIZ9NE
         ikmkOBl0Lv8rrnJihPqEK90siZWJIfzNkFVGSM1gInJ0XoB8nqizcMfqX18tpiT4v0sH
         s+/6JmRwt7gaFR+3mNS6FlpxUou7TlRsjdcujwJ6leEdb1whve3DcAJ6UW/D28E8zQz2
         5HMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OY/ma7FsqAwHUMoTyHl1ZlpK1LtNHBVpaKcd19MSoOs=;
        b=g6hepmeajmpTcz/T2dcHHzDVS57qFCYuYR6rtrkF6bzXpa+2ZdObbc91vxTNuAKx34
         O+LZsHRPeWnAFUEJZxY9vJhh6t1QufxqyT4am5uRsFRWw3TWqUATwhStFujqEqzZcxq9
         FklO0Mu+d3GV9P7Wk3xJi2B9lzBRUOHEnNj2LTos5dP1vz6Wu48s4paWqVHAsKPKgEF1
         WbhYmIvx4G4kIXw+ChZmpzgJioFJoWizvdTUZvyE/HRsiCeXEXfd+HRQIiTsxNx3xoBA
         3XsSuPwxnLrCbz1MmB1yCl4xo9fdhkdndbMWTJGXEIhmw7Rj+96+h6WzCgtYt36yHLV/
         iL1A==
X-Gm-Message-State: ALoCoQlrOMrT0+iAgWRKDTCdugWz6EeXV2vnCp8H/Gyef3JLZyd4zmwP69dAT2VEUeNZE9ttL4OI
X-Received: by 10.42.212.10 with SMTP id gq10mr38968522icb.79.1418864907885;
        Wed, 17 Dec 2014 17:08:27 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:9f5:d31a:4ba2:b65d])
        by mx.google.com with ESMTPSA id qc7sm8622409igb.5.2014.12.17.17.08.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Dec 2014 17:08:27 -0800 (PST)
X-Mailer: git-send-email 2.2.0.31.gad78000.dirty
In-Reply-To: <xmqq1tnx961q.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261513>

This adds an explanation of why you want to have the --notes option
given to git format-patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    > with optionally update Documentation/SubmittingPatches
    > to point at the file.
    
    That file actually talks about notes already.  I am sending
    two patches touching that file, one of them explaining
    the --notes workflow rationale and one of them just changing
    white spaces.
    
    A few weeks ago I wanted to patch format-patch to remove
    change ids. This is not needed any more for the git workflow
    as I disabled them and do not upload any patches to an optional
    Gerrit code review server anymore.
    
    I do like the workflow using --notes as well from a developers
    perspective as I take literally notes for my own sanity.
    I wonder if I should add a config format.notes = [default-off,
    always, on-if-non-empty] so I don't need always add --notes
    manually to the command line.
    
    Thanks,
    Stefan

 Documentation/SubmittingPatches | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index fa71b5f..16b5d65 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -176,7 +176,11 @@ message starts, you can put a "From: " line to name that person.
 You often want to add additional explanation about the patch,
 other than the commit message itself.  Place such "cover letter"
 material between the three dash lines and the diffstat. Git-notes
-can also be inserted using the `--notes` option.
+can also be inserted using the `--notes` option. If you are one
+of those developers who cannot write perfect code the first time
+and need multiple iterations of review and discussion, you are
+encouraged to use the notes to describe the changes between the
+different versions of a patch.
 
 Do not attach the patch as a MIME attachment, compressed or not.
 Do not let your e-mail client send quoted-printable.  Do not let
-- 
2.2.0.31.gad78000.dirty
