From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 01:19:59 -0700
Message-ID: <20130408081959.GD20159@elie.Belkin>
References: <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan>
 <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de>
 <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin>
 <CALkWK0=Q-P-fGLmkoiV3_CJ43MNmFzpfkvFjNUwxB+zOsqTxmg@mail.gmail.com>
 <5162763D.5030708@web.de>
 <CALkWK0m5iN8h0J1EkbMTJoXy6QHHzyTjRfPnhL3XMgi=NAi2eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 00:04:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPK9g-0002Am-L6
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 00:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934844Ab3DHIUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 04:20:08 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:58884 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594Ab3DHIUG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 04:20:06 -0400
Received: by mail-ie0-f177.google.com with SMTP id tp5so6574003ieb.22
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 01:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=suPCAuFB1efEPsxpbr2t2bxw1fsoowfLV+miqQWq0vs=;
        b=zBSNLZ11a3nW/pg6XT0z8jZgiVy1cP/ND7hJC14jrZd2ZjBlVD2QClYEJfS9XSbk1q
         TUvcTwQ6yxxOrIit3t2S684VW9RRMo3k7VfhgPAGH4HcNkGh9yX2Dds5yZKLqm76o6T0
         kfLr3egJtXFQQDtsaqBonqBTp7n/+QzXqMNOetDDF7FZKko1XC1e2hDzQldRjB4eHoUv
         LONsvl5K8LcH/YlswNJC1oe2hGiGMx416T3bfuZEKvJ1oiBWCHgEZit5oiGspF+tnqiH
         5J18w7YwnL8joPqTWpkBNdpZxLbwCq+EnACZwyvAmwEu9L0/KphwDa4w7BC33LGLcoGQ
         NlDw==
X-Received: by 10.50.11.229 with SMTP id t5mr6007873igb.65.1365409205755;
        Mon, 08 Apr 2013 01:20:05 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id wx2sm17824681igb.4.2013.04.08.01.20.02
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 01:20:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0m5iN8h0J1EkbMTJoXy6QHHzyTjRfPnhL3XMgi=NAi2eg@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220409>

Hi Ram,

Ramkumar Ramachandra wrote:

>                                                     In my opinion,
> .gitmodules is a wart that needs to be done away with: it should _not_
> be on the filesystem, just like a commit object isn't on the
> filesystem.

What do you think of .gitignore and .gitattributes?  Should they be
somewhere other than the filesystem as well?

[...]
> What I still fail to understand is why you keep mentioning
> work-in-progress.  You've had five years in which you haven't been
> able to do things that I did in two days.

I don't think Jens had any obligation to work on submodules and
nothing else for the last five years. ;-)

If you end up convincing others that your tools are worth working
on and those tools pleasantly take care of the same workflows that
submodules do, then I imagine people will be happy to migrate.

Speaking only for myself, I actually prefer the submodule UI, despite
not being thrilled with the
single-.gitmodules-file-at-the-root-of-the-worktree feature.  So I
will not be working on your proposed redesign, unless it evolves
enough to be as pleasant a UI as (the long proposed UI of) submodules.

Hope that helps,
Jonathan
