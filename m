From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking (incremental)
Date: Wed, 25 Apr 2012 08:17:30 -0700
Message-ID: <xmqq8vhjet85.fsf@junio.mtv.corp.google.com>
References: <xmqq8vhmhzpk.fsf@junio.mtv.corp.google.com>
	<xmqqobqgeex1.fsf@junio.mtv.corp.google.com>
	<87r4vcqiy8.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Apr 25 17:17:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN3yM-0006i1-JA
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 17:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216Ab2DYPRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 11:17:34 -0400
Received: from mail-we0-f202.google.com ([74.125.82.202]:39081 "EHLO
	mail-we0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab2DYPRd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 11:17:33 -0400
Received: by wejx9 with SMTP id x9so10597wej.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 08:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=SD9S+dIcbEYYEV+G5RMQoUhqyH+AFvtSkP+Xo4GTXxw=;
        b=RKFzDp36jhOB6SP3xwNLnonKBVZ+B2Ion22fGjaoy/5hGfHCFIsY6OrOenmYZiPoVG
         iZsm+sganCeewluREczApEo5ycbm2KBj+W4sO1XHqU7L2w9WBn8S0TISTiXoXIC9T79S
         35cabd8Bux1E7T8nmHKTHmMYj/llZm9rQ1jWxVuxNAe3uMMtU+DV7EAW/xHsXARpSu1P
         64TbCPQUukCf4R49c7v8xWqcd5rmTdYl7U+4kxbaezmVLr+rr/F/hEzPY67H0CXWFWUl
         Un/yZVOEGL4mEomY1vx+ZP1hLOQT2jtx1yp6Zj7G2UIEBpRqxuwoadhhIRxh0+Xyn/wb
         Bgxw==
Received: by 10.213.26.20 with SMTP id b20mr345798ebc.12.1335367051767;
        Wed, 25 Apr 2012 08:17:31 -0700 (PDT)
Received: by 10.213.26.20 with SMTP id b20mr345786ebc.12.1335367051413;
        Wed, 25 Apr 2012 08:17:31 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id t8si16471321eef.1.2012.04.25.08.17.31
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 25 Apr 2012 08:17:31 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 37C3F5C0050;
	Wed, 25 Apr 2012 08:17:31 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 76637E125C; Wed, 25 Apr 2012 08:17:30 -0700 (PDT)
In-Reply-To: <87r4vcqiy8.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
	"Wed, 25 Apr 2012 11:06:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlc/q9tPmREtWOyeB1yBLCwPjhR/cUH6kMRrGbti7h7Am8BQRgNPeuwDScoS1UvFL1jS2mvKHdbwYpyTE89hXVnRqkkWSM9Fu7WMJD9yKgJxkzItVuaTuuF9c2OdWE7d8H4DdPADkD4iLRItPmBa0n4I3waa5YwO5yqD78TG3H7C7uT3OM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196316>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I've merged the following topics to 'next':
>>
>>   * tr/xdiff-fast-hash (2012-04-09) 1 commit
>>   * cb/daemon-test-race-fix (2012-04-19) 1 commit
>>   * ld/git-p4-tags-and-labels (2012-04-24) 6 commits
>>   * nh/empty-rebase (2012-04-24) 4 commits
>>   * pw/t5800-import-race-fix (2012-04-24) 1 commit
>>   * nd/i18n (2012-04-24) 10 commits
>>
>> Some of them are scary and somewhat iffy (I had to apply a last minute
>> fix and rebuild 'next' to one of them), so please test them throughly to
>> help us avoid breakages on 'master'.
>
> Umm, which one?
>
> As the author of the first, I'm kind of curious whether I need to
> scramble to fix (or at least further test) something :-)

Authors do not need to "scramble"; they are trusted to have done as good
a job as they can possibly do before submitting anyway.

It is sufficient to just use the resulting Git in your daily work, but
paying extra attention to notice if there is any behaviour that feels
strange.
