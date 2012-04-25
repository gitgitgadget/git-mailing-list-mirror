From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking (incremental)
Date: Tue, 24 Apr 2012 19:14:18 -0700
Message-ID: <xmqqobqgeex1.fsf@junio.mtv.corp.google.com>
References: <xmqq8vhmhzpk.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 04:14:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMrkQ-0001UZ-DV
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 04:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757793Ab2DYCOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 22:14:20 -0400
Received: from mail-yx0-f202.google.com ([209.85.213.202]:39013 "EHLO
	mail-yx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757115Ab2DYCOT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 22:14:19 -0400
Received: by yenq2 with SMTP id q2so162091yen.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 19:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type:x-gm-message-state;
        bh=FEWQPdbHGTg8ctag/T4R02s9raxKuWqN+WF0fgFkZhw=;
        b=Qeof6SncVcYWMgHqAgA0Kt/W5eefjMz8kSRvl0brTaPuSFul2oBqiSEkWKPjoRTxev
         5iAIydi9tNHPZqmZYB9t6IenLIHTuIkCVTNAWY72WGFQiRMIyfxle1eVsBxieCYIkXRh
         C6AGG51nxQwwwbCJMYKlZMqSaj+R048QJDADWeXZK0/wnxDDnKYEP3mYtjfigAbvWF0n
         R+GHUBKz20jp33bhWllA/zlQndkdu5ImkHglVcwJk2krZKYjT5T5jZ75MEZMkeXGBeII
         EeWpr7fWPseKFrYZQt+URH7TIMFFTevHqVCPepkzrfBM1g+y0Iq0syJGPE9fAUo+3on6
         e5Vw==
Received: by 10.100.245.33 with SMTP id s33mr380517anh.4.1335320059251;
        Tue, 24 Apr 2012 19:14:19 -0700 (PDT)
Received: by 10.100.245.33 with SMTP id s33mr380507anh.4.1335320059147;
        Tue, 24 Apr 2012 19:14:19 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id z48si20054235yhn.7.2012.04.24.19.14.19
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 24 Apr 2012 19:14:19 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 0F93C10005D;
	Tue, 24 Apr 2012 19:14:19 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id AD3CBE125C; Tue, 24 Apr 2012 19:14:18 -0700 (PDT)
In-Reply-To: <xmqq8vhmhzpk.fsf@junio.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 23 Apr 2012 15:04:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQkxTXfutztrWnGggSQkahjoGPGoZQvBP3d1JWqKR2BlxCP5A3Ly0dOPFpwkt3XIMwSJRGW97/VuzPa18ho5xuIbUNSgKdi7Su3viNOS3pVUiCv2RvCj3NawNHPsODPMJg6BabWTljv+9dt8CaUUu7GwHjQPhgkNayI5oG3ne01X1/ObkP4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196295>

I've merged the following topics to 'next':

  * tr/xdiff-fast-hash (2012-04-09) 1 commit
  * cb/daemon-test-race-fix (2012-04-19) 1 commit
  * ld/git-p4-tags-and-labels (2012-04-24) 6 commits
  * nh/empty-rebase (2012-04-24) 4 commits
  * pw/t5800-import-race-fix (2012-04-24) 1 commit
  * nd/i18n (2012-04-24) 10 commits

Some of them are scary and somewhat iffy (I had to apply a last minute
fix and rebuild 'next' to one of them), so please test them throughly to
help us avoid breakages on 'master'.

On the 'master' front, these have graduated:

  * cc/fix-missing-va-end-in-revert (2012-04-21) 1 commit
  * fc/completion-tests (2012-04-21) 7 commits
  * hv/submodule-recurse-push (2012-03-30) 3 commits
  * it/fetch-pack-many-refs (2012-04-10) 4 commits
  * mh/ref-api (2012-04-10) 13 commits
  * mk/gitweb-diff-hl (2012-04-11) 8 commits
  * pw/fast-import-dataref-parsing (2012-04-10) 1 commit
  * zj/upstream-error-message (2012-04-15) 5 commits

Thanks.
