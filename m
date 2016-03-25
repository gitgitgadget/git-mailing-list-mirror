From: Jacob Nisnevich <jacob.nisnevich@gmail.com>
Subject: [PATCH 0/2] mergetools: add support for ExamDiff
Date: Fri, 25 Mar 2016 16:17:55 -0700
Message-ID: <1458947877-31764-1-git-send-email-jacob.nisnevich@gmail.com>
References: <xmqqio0a17ux.fsf@gitster.mtv.corp.google.com>
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jacob Nisnevich <jacob.nisnevich@gmail.com>
To: davvid@gmail.com
X-From: git-owner@vger.kernel.org Sat Mar 26 00:18:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajazp-0006HZ-5C
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 00:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbcCYXSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 19:18:21 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33286 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbcCYXSU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 19:18:20 -0400
Received: by mail-pf0-f195.google.com with SMTP id x3so12899191pfb.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 16:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YcJXY/zzc3My2nYzKuNt9Rk9NRIDgAR7UHhBeFqAblo=;
        b=jZa8+GyMHXxJ4B/ZJeUqJ7buIq6kbBO4ZxYglTVHym0tbLje/lTuajL3h4o+IhCHLX
         udZ2VI/2OVnhLSFIgnAceNvum/FsLtGc8HL1FNcgIWByoj0ttZlPGRq9vdMNM0TI7zTz
         NggymCXT2cvWAP/f+54b/SxdlB2wbN3lV8TCF2j+QtB5m0THTl/MzP3+P7Em5qEDunhs
         MAkpvNXUljuAEx0HyuTZNxeBdvA+7h0IAYcsixH+cFus9C/WBfmcEZz4oEAvF7fZIENT
         eOuudB1mHg1YTNf9O9nVF7QQZmzepfQkEmzEES8G5htYYRD3oBp0LlRuBZdrp1AO5sq/
         /Xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YcJXY/zzc3My2nYzKuNt9Rk9NRIDgAR7UHhBeFqAblo=;
        b=ZjnbTsZvWq4tqjPY9GDI97NfWvRou34zIfTJC8riiInSa2fqp7EUoEBO5T1RaohLbX
         kvjRcVFDjSb9rFoy+e6GCYPryiDZEN8Bl9QTmMjWsCSw26sZNvipUzBJxkPNVFqGzsBe
         c1DsL5zbUpPbseT3AwKF+X8kJmxO7PDuzJk4kZiVbbtvqGRdwCCjzLOIxTeeUxJ+0mkt
         Cv4+MfmKqPBAWt9DD/Tb9C1GCA2nM+JNyyTOpQCCA8TpzQwrLwf71yezxFUVIGvBVszD
         dlXfQMV3uxFJAW9f2llUWet5keGjOk8M8ce43EvHGr0Ah3ihJAKiuSv1/xHJZhz52d+i
         Q7bA==
X-Gm-Message-State: AD7BkJIcAK8jnbWQESuz1d1BVtSQDcntXoTzRokX9rvZu4YVjMsqAiGQH4X+MyW0zQZ0lQ==
X-Received: by 10.98.16.71 with SMTP id y68mr16594805pfi.106.1458947899986;
        Fri, 25 Mar 2016 16:18:19 -0700 (PDT)
Received: from localhost.localdomain (cpe-108-185-180-179.socal.res.rr.com. [108.185.180.179])
        by smtp.gmail.com with ESMTPSA id y23sm18674072pfi.22.2016.03.25.16.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Mar 2016 16:18:19 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <xmqqio0a17ux.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289967>

OK I add the quotes and modified the comment. I also changed $folder to 
$sub_directory. I think that makes a little bit more sense and sounds a lot
better.

Jacob Nisnevich (2):
  mergetools: create mergetool_find_win32_cmd() helper function for
    winmerge
  mergetools: add support for ExamDiff

 git-mergetool--lib.sh | 25 +++++++++++++++++++++++++
 mergetools/examdiff   | 18 ++++++++++++++++++
 mergetools/winmerge   | 21 +--------------------
 3 files changed, 44 insertions(+), 20 deletions(-)
 create mode 100644 mergetools/examdiff

-- 
1.9.1
