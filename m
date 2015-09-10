From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2015, #02; Wed, 9)
Date: Thu, 10 Sep 2015 08:54:42 -0700
Message-ID: <xmqqbnda5kxp.fsf@gitster.mtv.corp.google.com>
References: <xmqqpp1r5n2d.fsf@gitster.mtv.corp.google.com>
	<20150910092922.GB6633@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 10 17:54:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za4BU-0002Ur-SS
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 17:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbbIJPyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 11:54:45 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34668 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbbIJPyo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 11:54:44 -0400
Received: by padhy16 with SMTP id hy16so46642144pad.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 08:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=8dz8FjpREEh+LlPwm6Q3blaMmOqimMEnDO+fNY/ZkiE=;
        b=mEojiVCMRlj78/XCMVwGkP4BXh/3sK4VrO1vPEFoay+dHEmBn5aNsF8x3oD2Q4wwff
         FqnZmhCKeBA58XRlvbXNpwA+GV+wXxm4ubY94YDsTNliONZbRluIQHymcA+l5SkfJbDt
         9rHJVldq6Zaf39uaKDeBaWXxcJnzsofZKDwWbv0IJ4Ngo8Ec480tWTORDOjuQbfIptS7
         vpIxuX/TVUw3s4Xnscup0vSVfEC/DypbsBBL1epoTK9WrurfbrxCi8zo2CLUTugKscyX
         neDwSeTkwNhgOy8UcCkBbSNkqSO82poLPbBVxNEacBTc8NAOjaThwN6pSdzDozOKa//0
         SkbA==
X-Received: by 10.67.22.169 with SMTP id ht9mr75200017pad.35.1441900483665;
        Thu, 10 Sep 2015 08:54:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8419:5a5:3940:dfa0])
        by smtp.gmail.com with ESMTPSA id o3sm12831734pap.37.2015.09.10.08.54.42
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 10 Sep 2015 08:54:42 -0700 (PDT)
In-Reply-To: <20150910092922.GB6633@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 10 Sep 2015 05:29:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277595>

Jeff King <peff@peff.net> writes:

> I did wonder if we needed to deal with any fallout from f4c3edc
> (vreportf: avoid intermediate buffer, 2015-08-11). That _is_ new in this
> release, so regressions are fair game during the -rc period.

Yeah, and the most obvious way to deal with it is just to revert,
but as you point out, it is not really introducing a new issue, so
there is not much point doing that, I would think.

> I don't think it should matter, though. Though it does add an fflush(), it
> is replacing an existing fprintf(), and both should be taking the same
> lock on stderr (so it probably _is_ still a potential problem, but not a
> new one).

Yeah, I reached the same conclusion.

Thanks.
