From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Tue, 7 Jan 2014 04:24:59 +0530
Message-ID: <CALkWK0mQJcFw45uWz08h+gzn6rTdVOdHkUtU3oRTyQ00LbtcbA@mail.gmail.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
 <1389028732-27760-3-git-send-email-artagnon@gmail.com> <xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
 <CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
 <xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com> <20140106201854.GA28162@sigill.intra.peff.net>
 <CAEBDL5UaS2Hd-Yb417W+Fw_7j1+5sRAgszko-PbU7z901_X+cw@mail.gmail.com>
 <20140106204203.GI3881@google.com> <CAEBDL5VD9C8DXFUS9VawxZhAC0AnR=abV-FEVTdi25NVBPvDVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Mon Jan 06 23:55:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0J5J-00034O-JO
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 23:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbaAFWzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 17:55:43 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:49358 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757032AbaAFWzk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 17:55:40 -0500
X-Greylist: delayed 132392 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jan 2014 17:55:39 EST
Received: by mail-ig0-f180.google.com with SMTP id m12so45802iga.1
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 14:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ShxGDW6VAqUUrY+qWJoQP6nTif++TVux1iCU2r4NLFI=;
        b=jXaBL/fKxKLb7SLp3SkuCk6VniAHNkSy4bjuu96PR7zlgU4/KZ6NJmK+ykVIDJYGA4
         /ZiyBLaFL0ev3Houk0CrEsB93vrmLZbWIvYaSKn7FpXpSoSC6oiBiSPHAh7zNYNDm6hi
         DJA270qWqMHzcrMy1lEj3Ff7C36uFAaUwuAP/gsSBLd01OdfJmoVEu9qGqW8P8I99QP+
         sK8YiTvbzt1LDd4CRbA0wCwYjc1H6hj1WndV2xJ2fO1Lt7c9aH/yCCBbK1cWSQbkqXZE
         kUoQ99mi8AZBdNZTYzSui2XXp27pjXNP3/WXQEhdM/lVHsBnlQdNNMsd4hoE20NHAgDu
         xm4w==
X-Received: by 10.50.79.228 with SMTP id m4mr22005259igx.47.1389048939506;
 Mon, 06 Jan 2014 14:55:39 -0800 (PST)
Received: by 10.64.195.9 with HTTP; Mon, 6 Jan 2014 14:54:59 -0800 (PST)
In-Reply-To: <CAEBDL5VD9C8DXFUS9VawxZhAC0AnR=abV-FEVTdi25NVBPvDVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240078>

John Szakmeister wrote:
> Then where does it get pushed?  Do you always specify where to save your work?
>
> FWIW, I think the idea of treating @{u} as the eventual recipient of
> your changes is good, but then it seems like Git is lacking the
> "publish my changes to this other branch" concept.
>
> Am I missing something?  If there is something other than @{u} to
> represent this latter concept, I think `git push` should default to
> that instead.  But, at least with my current knowledge, that doesn't
> exist--without explicitly saying so--or treating @{u} as that branch.
> If there's a better way to do this, I'd love to hear it!

That's why we invented remote.pushdefault and branch.*.pushremote. When you say

  $ git push

it automatically goes to the right remote instead of going to the
place you fetched from. You can read up on how push.default interacts
with this setting too, although I always recommend push.default =
current.
