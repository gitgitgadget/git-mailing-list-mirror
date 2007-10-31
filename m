From: Alejandro Martinez Ruiz <alex@flawedcode.org>
Subject: Re: unmerging feature branches
Date: Wed, 31 Oct 2007 22:16:58 +0100
Message-ID: <20071031211658.GA5430@inspiron>
References: <20071023152445.GA10070@piper.oerlikon.madduck.net> <alpine.LFD.0.999.0710230922240.30120@woody.linux-foundation.org> <20071023171611.GA18783@piper.oerlikon.madduck.net> <alpine.LFD.0.999.0710231026011.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 31 22:16:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InKvJ-0002nT-Q4
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 22:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760592AbXJaVP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 17:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760580AbXJaVP5
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 17:15:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:50306 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760558AbXJaVPz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 17:15:55 -0400
Received: by ug-out-1314.google.com with SMTP id z38so383068ugc
        for <git@vger.kernel.org>; Wed, 31 Oct 2007 14:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=EqP60S2Fv47RTY0kMPwBdajweBpJFyg9/DRBeP3JSLg=;
        b=jhwDtIwKdIJ0/cpSakwnViUhdoQ4F/OXf5X1UfKD6hO9IDe6j/Bu1OD1opye9ZN6XBVb07meCLNMNlwcFKKTeJHDDeWGUOxH30An0HNLrcBHZ+Vt9Tfla3X9dnG9Aqa5TgFanHnhT2Aehsce6FysEv07IoGhHgaDVGJRUD6nnwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=GXH2M2qpAw4ClGYq9P11sO2ghY0VCzJgHlNoIdpMwXcgjA/wMW/nZ6qjGVZ4SmyzLIMxmuzxa9ixg5pNeUDs4iTIUXDCYWSfw8Zwf0nmWtbTTRK001JlsakK7qKX5mA3GTvE3y5wZXxhaq4aRpbCFDLTsz2j9nnkJy26ZS/7HIA=
Received: by 10.67.20.11 with SMTP id x11mr244491ugi.1193865352799;
        Wed, 31 Oct 2007 14:15:52 -0700 (PDT)
Received: from unleashed.kicks-ass.org ( [89.129.136.193])
        by mx.google.com with ESMTPS id 18sm4445174ugk.2007.10.31.14.15.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 31 Oct 2007 14:15:50 -0700 (PDT)
Received: by unleashed.kicks-ass.org (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	alex@flawedcode.org; Wed, 31 Oct 2007 22:17:01 +0100 (CET)
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710231026011.30120@woody.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62872>

On Tue 23 Oct 2007, 10:40, Linus Torvalds wrote:
> 
> So a "revert" is fundamentally different from a "undo". Most of the time 
> 
> [cut]
> 
> So sometimes the behaviour of "git revert" will be exactly what people 
> expected and wanted ("good, I'll never get that commit again when I pull, 
> because I told git that I don't want that commit"), and sometimes it will 
> _not_ be what people expected and wanted ("oh, I didn't get that commit, 
> even though I was now ready for it - because I had reverted it back when I 
> was *not* ready for it").
> 
> See? The logic is exactly the same in both cases, but one was good, the 
> other bad, and the only difference was really the mindset of the user.
> 
> A tool can't ever get "mindset of the user" differences right. At least 
> not until we add the "esp option" ;)
> 
> So I really don't want to push this as a problem or deficiency, I think 
> it's a good thing. But it's a good thing only when people are *aware* of 
> what "revert" really means.

So how about an "undo" command or a switch for revert with a special
meaning like "hey, this one is a nice commit, but it ain't ready yet,
I'd like you to ignore I ever committed the thing when merging or
rebasing again, thanks"?

Alex
