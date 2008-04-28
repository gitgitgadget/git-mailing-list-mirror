From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH resend] make "git push" update origin and mirrors, "git
 push --mirror" update mirrors
Date: Mon, 28 Apr 2008 11:19:04 +0200
Message-ID: <48159688.2030202@gnu.org>
References: <7vzlrgmrvb.fsf@gitster.siamese.dyndns.org> <20080427043014.GI29771@spearce.org> <20080427044049.GJ29771@spearce.org> <7vabjflvlh.fsf@gitster.siamese.dyndns.org> <20080427173446.GM29771@spearce.org> <7vy76zf449.fsf@gitster.siamese.dyndns.org> <4814E097.7030407@gnu.org> <20080428012613.GB15121@sigill.intra.peff.net> <48155B7F.8020202@gnu.org> <20080428090948.GC16153@sigill.intra.peff.net> <20080428091150.GA16209@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 11:19:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqPWf-000579-Ue
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 11:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbYD1JTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 05:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761664AbYD1JTK
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 05:19:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:8273 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759014AbYD1JTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 05:19:09 -0400
Received: by fg-out-1718.google.com with SMTP id l27so4866558fgb.17
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 02:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=cmF2hFMVqXYImSQNoLeCPOVX2vbsHUyx9nemkRY+Aas=;
        b=W0f/4fTDkrGFtFee+uB9eZ8QoqO1qKfXBGPLnhKNL0cVt4q3u85wB77i+oiB9sIXzUZw2S1yha5rKjIpWBCcqb4FSn/TuO9Mmq1QhMMGFHnGTvgoatYLASwHvxXBtEliGyf18srGhI6HPELUz7g+qbu6lmMcAEqHKR26vp4pk7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=e2s44Wd7P+4gF2CWt8KCIbrr6M1bpJN38euOdUAFJDfNI/sAoi4sup2JdPRuK+oMxflhNvzeWyRpwtvQ1vcDkFAQU5/JMQsE48gADqRPAJJY2Xc/6RZju7TLJqwuhnPfavNe3CtZd9Zyl4osyIRLolFGod/7tv5GAbZ5ceBKqFg=
Received: by 10.86.97.7 with SMTP id u7mr7138137fgb.39.1209374348154;
        Mon, 28 Apr 2008 02:19:08 -0700 (PDT)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id u26sm8541663mug.19.2008.04.28.02.19.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Apr 2008 02:19:02 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <20080428091150.GA16209@sigill.intra.peff.net>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80514>


> BTW, I find myself decreasingly using "git fetch" in favor of "git
> remote update" which handles fetching from multiple remotes. That seems
> to be analagous to what you want with "git push". IOW, maybe instead of
> changing the default behavior of "git push" you would be happy with a
> "git remote push" which impacted multiple remotes.

I'm preparing a patch that has "git fetch" fetch from all remotes (same 
as "git remote update" with no groups defined) and "git push" push to 
all remotes.  I think this is much more sound; and it's not really as 
easy as this, but that's the idea. :-)

As always, thanks to the list for straightening my first design.  It 
happened for --track, for prepare-commit-msg (by the way, I am using it 
now that it's in 1.5.5, and it helps me so much) and for this too.  I 
hope that my improvements to git is worth your time, guys.

Paolo
