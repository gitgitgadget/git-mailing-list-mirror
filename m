From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Tue, 7 Jan 2014 22:17:46 +0530
Message-ID: <CALkWK0=VT_MaLJKzhRyrEjG_PH=rEGiMuyHeuEXpSqgeVLqjuA@mail.gmail.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
 <1389028732-27760-3-git-send-email-artagnon@gmail.com> <xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
 <CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
 <xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com> <20140106201854.GA28162@sigill.intra.peff.net>
 <CAEBDL5UaS2Hd-Yb417W+Fw_7j1+5sRAgszko-PbU7z901_X+cw@mail.gmail.com>
 <20140106204203.GI3881@google.com> <CAEBDL5VD9C8DXFUS9VawxZhAC0AnR=abV-FEVTdi25NVBPvDVg@mail.gmail.com>
 <CALkWK0mQJcFw45uWz08h+gzn6rTdVOdHkUtU3oRTyQ00LbtcbA@mail.gmail.com> <CAEBDL5W+3zRb1c51N2JfTR2acwvrUi8TpOw-DkjUn_r114mhAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Tue Jan 07 17:48:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0ZpQ-0008Qv-AO
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 17:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbaAGQs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 11:48:29 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:40450 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbaAGQs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 11:48:27 -0500
Received: by mail-ie0-f172.google.com with SMTP id qd12so660679ieb.17
        for <git@vger.kernel.org>; Tue, 07 Jan 2014 08:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5kP3DtvACR8XL6s4LjBosqna1p611rDeXM1qyXGfPA4=;
        b=AhyucX9OkgpFQgwTvslY43poIbkNbqs5yah0eGl9140bZlLT4G26+Ss6wBqv/x045C
         d4lnjgtxBGvnglocsQ1AZyFS4LbD0REuLQVjli2hFaLAMAV70UfNQUt3fCsyv1XCn+Ie
         Na8erOC9nr0lUBf22kFiGxqfhPkf4DggHNzEyz8nrxwOgtdYYhpK/LtGQN7a10/taLEQ
         kpHRcF6vuqiR4ue4jQ25pLMCQ04Z+pPqzPyCsD2zgOX2SaLnpdIC9sGYQO4fOocknxHK
         ysA/MmIr2DXqrsdH44QInDQzO3sKiN2XOrZHEb4tFs/nMbBPIJoPKHE3hoz9MDaEP+6B
         ysxw==
X-Received: by 10.50.79.228 with SMTP id m4mr26507521igx.47.1389113307018;
 Tue, 07 Jan 2014 08:48:27 -0800 (PST)
Received: by 10.64.17.10 with HTTP; Tue, 7 Jan 2014 08:47:46 -0800 (PST)
In-Reply-To: <CAEBDL5W+3zRb1c51N2JfTR2acwvrUi8TpOw-DkjUn_r114mhAA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240109>

John Szakmeister wrote:
> I guess it's not a good idea to
> set 'push.default' to 'upstream' in this triangle workflow then,
> otherwise the branch name being pushed to will be 'branch.*.merge'.
> Is that correct?  I just want to make sure I understand what's
> happening here.

push.default = upstream does not support triangular workflows. See
builtin/push.c:setup_push_upstream().

> Given this new found knowledge, I'm not sure it makes sense for `git
> status` to show me the status against the upstream vs. the publish
> location.  The latter makes a little more sense to me, though I see
> the usefulness of either one.

Currently, status information is only against @{u}; we haven't
invented a @{publish} yet.
