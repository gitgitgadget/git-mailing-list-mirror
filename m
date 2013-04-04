From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Thu, 4 Apr 2013 11:47:30 -0700
Message-ID: <20130404184730.GL30308@google.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 20:48:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNpCf-0006WX-MN
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 20:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762752Ab3DDSrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 14:47:36 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:62818 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761312Ab3DDSrf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 14:47:35 -0400
Received: by mail-pa0-f51.google.com with SMTP id jh10so1625541pab.10
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 11:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=KcpepHTtyV01cDOcn/Vg1xGGyv2H12GdOQZkj7cCxts=;
        b=osl9tb8diaNg21MB43qfGt8Tmun9dKyk0yBfMEyZAKFISsDRlaM0mtv6XkYp+dOpkY
         +6ZE1zmZAAf18Al7Q8L+IIsqch1lNlrY6zG2jyo09otfKcPbqENmmOjC2XEOcgE4QlOT
         2NAhCidPMmFW1cjVgi6W/qzi98Zc2AN6u4bujHSx5QxdUrqAcH7/5VMDhgm8qn3JGx6Y
         6w2u6z7YlHafVZI/rKfoDxRtv44h9IrqQfiag8Sc4A86ZWUcO3W5zA9qWPX51kWc20o5
         DhgLwpRBesg3GC7F/sPME0Yxh58j+7l97oll7uHcIm/CVN8+wTBDxgizSZrdy8Sjs5e0
         SHSw==
X-Received: by 10.66.246.168 with SMTP id xx8mr10999115pac.107.1365101255428;
        Thu, 04 Apr 2013 11:47:35 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id lb8sm12476427pab.13.2013.04.04.11.47.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 11:47:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220060>

Ramkumar Ramachandra wrote:

> The purpose of this series is to convince you that we've made a lot of
> fundamental mistakes while designing submodules, and that we should
> fix them now.  [1/7] argues for a new object type, and this is the
> core of the idea.

Oh, dear.

Shouldn't it be possible to explain the same thing using a test
script illustrating intended UI?

[...]
>     $ git clone gh:artagnon/varlog
>     $ cd varlog
>     $ git clone gh:artagnon/clayoven
>     # Notice how it puts clayoven.git in ~/bare

I really would like to be able to continue doing something like

	git clone --recurse-submodules git://repo.or.cz/cgit.git
	# never mind!
	rm -fr cgit

without leaving any clutter behind.  I have used systems that kept
state in my home directory before and found them a pain in the neck to
debug.  Others may disagree, though.

[...]
>     # Again, just works!  No cd-to-toplevel nonsense

Didn't Jens mention that git-submodule requiring that one work
at the toplevel is just a (presumably easily fixable) bug?

[...]
> If you think this is all a big waste of time, and that we should focus
> on improving git-submodule.sh, you're probably deranged.  Because it's

I don't think that *you* should focus on improving git-submodule, as
long as you are not using it and dislike its design.  But I do think
it's strange to at the same time

 1) tell me I'm deranged for liking submodules
 2) dismiss other experiments that have been created as alternatives

I like experimentation, which means sometimes having tools whose
purposes overlap, and I like when it's possible to help something
evolve to be better, even far enough to interoperate with or replace
uses of another tool.

I also believe in "live and let live".  That means that even if
someone is a little crazy, if they are not actively harmful, I do not
destroy their tools.

That probably marks me as deranged.

Hope that helps,
Jonathan
