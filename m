From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 02:41:38 +0530
Message-ID: <CALkWK0=GtOae9sizcftgCoqnoAOuQdGVQrcr2tKf7OCLDgMVSg@mail.gmail.com>
References: <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
 <20130407175210.GI2222@serenity.lan> <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de> <CALkWK0mNQesytoDwaVHb1cdY+EC=33WRCefpE03hwp_9za1Vbw@mail.gmail.com>
 <20130407210225.GL2222@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Apr 08 08:47:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5pc-0000sy-Jj
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934350Ab3DGVMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 17:12:19 -0400
Received: from mail-ia0-f177.google.com ([209.85.210.177]:37347 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762413Ab3DGVMT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 17:12:19 -0400
Received: by mail-ia0-f177.google.com with SMTP id w33so4464014iag.8
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 14:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=TnrB4+o9Cp5CNWUvS/aqQhicJWVOsgEpzsBTwhRP2xI=;
        b=uwMBWKlqOu2VJkTGt4brJVZ0jcF9U0lBp+Qu3FDk09l55TpciSTrENBwnjRptSBu7Z
         0pYijKlBOBp1goXGPHU8eFmf4HrOdlprtHAGLbAPoh28/onjOHlnpOtrdkoQdFQRipKi
         7rkgyhoa+BMSfsgnpgrvIRzEraBMvJZJtxLtkdMf0gicOqBFWYVrjqdnUv9E1/vi1L7G
         f/saRlKkN97M9oFEQVvzWOl062gkNbxvKj+Y4qOTWa20o/x9mquRn2hherTDSTPb6ldn
         D6DqWOEKnFRTbM05HXxXAhc7oxGDOz0uJpdMUtQ9LzVQyBc5rD1aEcvzIuJFf0rGzMmB
         z3Bg==
X-Received: by 10.50.17.71 with SMTP id m7mr5108947igd.14.1365369138588; Sun,
 07 Apr 2013 14:12:18 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 7 Apr 2013 14:11:38 -0700 (PDT)
In-Reply-To: <20130407210225.GL2222@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220383>

John Keeping wrote:
> I do.  I quite often use "git add -p" to sort things out and submodules
> currently fit into that seamlessly: I can add the submodule and then
> wait until later to commit it, without needing to either clone and
> remember to "submodule add" later or commit and play with rebase.
>
> Losing the ability to do that is a major usability regression as far as
> I'm concerned.

I didn't realize people cared so deeply about this.  Sure, we can
emulate it: keeping the information in .git/link-specs/ doesn't sound
like a bad idea.  While it may feel like a hack, I think it's the
right approach if we want to support non-fs-backed objects in our
tree.
