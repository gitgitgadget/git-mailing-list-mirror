From: Jacob Nisnevich <jacob.nisnevich@gmail.com>
Subject: [PATCH] mergetools: implemented new mergetool file for ExamDiff
Date: Wed, 23 Mar 2016 15:55:44 -0700
Message-ID: <1458773745-783-1-git-send-email-jacob.nisnevich@gmail.com>
References: <xmqqpoulex0b.fsf@gitster.mtv.corp.google.com>
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jacob Nisnevich <jacob.nisnevich@gmail.com>
To: davvid@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 23 23:56:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1airhg-0004qU-S9
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 23:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbcCWW4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 18:56:33 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35392 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbcCWW4c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 18:56:32 -0400
Received: by mail-pa0-f41.google.com with SMTP id td3so6255480pab.2
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 15:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cf3M51nabre0gPR+2unern9VxPnkVzNgYNA565U48w8=;
        b=iy9YExYzuzVMBkUZs3OqFa6WRV/8a3rRN/+ZKL+VcfoVRSdWnkQlGBJfgow0MTJktd
         3ZIrqm2ZJ6rMO5jqQL40ueh105XZm++2hPepCz0dUcrJE3uKR1Kj/lRPOg8Ik4sy4DaH
         fIH/Lhc4JQcjCq+joqq44uVeWJN/y/pqa8URrF+LcoSTs7+bQSS3KAJ/Hk1QB0+jpnfD
         MkFaE5Fdn1KqtqDddERgozJaTLEdjKlHkbTNUve7MaNHB6AiKFz4XdVF+9JmacCB3G73
         Kbn8GNKMAuCGFQZ+P6Fvd88CzK7b8YyUsZUsK89yXMZs9bw+gaI9bVwi/korRlc5+qmT
         Oe4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cf3M51nabre0gPR+2unern9VxPnkVzNgYNA565U48w8=;
        b=Dax85SnZjuYgV9GkJ6COG4XdIGTmpYe9BkGj3OUIERkrA2gMG8xFj9fex/+mTpJHr4
         RJYPcqDQ18ktGQYqKS9cObOIdLlxtK1ksDFlYsq8St3QXxdioZ5wMvaZlUz6eOX8kIhP
         GlAElpUZEa0xtN7jWEaFdqUKtZHwZJmy/kBnNWvZDpdEk5KfaeEsCgVKj3fcuOA7wIA7
         1yZd+EYWFtNun+T8JxXFvLEhEdPgzJqwXQ7MHivuKJyX2a7X+vj+WltGUFnJZ9StrfHp
         LE4afSPxKsaMqDWWXzH183rUDmxVzdICJVLZfGYUtccUA3Cz9zuee3JtMWQgbf/qeCLv
         wGQg==
X-Gm-Message-State: AD7BkJKfF1wPci6k2dXIn+C9FkG8cKGqzJTJUDkZWb0kix1J5KYPGfRDhIE06fQz0uYrPg==
X-Received: by 10.66.249.41 with SMTP id yr9mr7910309pac.86.1458773792220;
        Wed, 23 Mar 2016 15:56:32 -0700 (PDT)
Received: from localhost.localdomain (cpe-108-185-180-179.socal.res.rr.com. [108.185.180.179])
        by smtp.gmail.com with ESMTPSA id ko9sm6471871pab.37.2016.03.23.15.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Mar 2016 15:56:31 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <xmqqpoulex0b.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289691>

Thanks for the hint. I used the other examples to fix the implementation of the 
ExamDiff mergetool. I've tested the Winmerge and ExamDiff mergetools with both
`git difftool` and `git mergetool` and both seem to work as expected. I've 
combined all my changes into one patch. Are there any other issues with my
changes?

Jacob Nisnevich (1):
  mergetools: implemented new mergetool file for ExamDiff

 mergetools/examdiff           | 20 ++++++++++++++++++++
 mergetools/mergetools_helpers | 24 ++++++++++++++++++++++++
 mergetools/winmerge           | 23 +++--------------------
 3 files changed, 47 insertions(+), 20 deletions(-)
 create mode 100644 mergetools/examdiff
 create mode 100644 mergetools/mergetools_helpers

-- 
1.9.1
