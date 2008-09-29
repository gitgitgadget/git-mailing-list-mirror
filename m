From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 4/4] cygwin: Use native Win32 API for stat
Date: Mon, 29 Sep 2008 22:26:00 +0400
Message-ID: <20080929182600.GI21650@dpotapov.dyndns.org>
References: <20080927084349.GC21650@dpotapov.dyndns.org> <200809272035.03833.johannes.sixt@telecom.at> <20080927215406.GG21650@dpotapov.dyndns.org> <200809281124.08364.johannes.sixt@telecom.at> <20080929153400.GJ17584@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Marcus Griep <marcus@griep.us>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 29 20:28:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkNTW-0000EV-9v
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 20:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbYI2S0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 14:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751974AbYI2S0u
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 14:26:50 -0400
Received: from gv-out-0910.google.com ([216.239.58.185]:33633 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbYI2S0t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 14:26:49 -0400
Received: by gv-out-0910.google.com with SMTP id e6so130871gvc.37
        for <git@vger.kernel.org>; Mon, 29 Sep 2008 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kYQ4203FRY1/7XIBMoYqqoxU0Pz+xFAiHqpqbUamqcU=;
        b=m/3ZC1Y6W8SFmsSwySEhEdSU4W6uK+4ujX09ap5Z7WPwqsan7pj7CHG/W8FAozFtC2
         MpcUCQj4z8VV+396WhJkf3rgarMUWy1DUDtphPAtc3ZHJm/EogIV8T54q8WTN2dgwAO0
         zAZ7fzh/9fSI39nJSlzTi6gyILX/QrW5Jp0Hs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PIM0d/i4DejNHiRKOZQH3q9gFx2yYpCrZTI4UCpQ85cdQ0HMxwjy7AlRsDdzzEh58/
         xZRLiVw18NA/zaFNsZpqv2VyUCXmfhnpWsZ08H/o5KJVmFXGWP85QjQpuqhb9uza54hf
         U4y6H/+44lmF4P1PnAz2axZP534HC8zn/Lt7g=
Received: by 10.103.243.7 with SMTP id v7mr3989586mur.118.1222712806939;
        Mon, 29 Sep 2008 11:26:46 -0700 (PDT)
Received: from localhost (ppp85-141-239-245.pppoe.mtu-net.ru [85.141.239.245])
        by mx.google.com with ESMTPS id j2sm2856786mue.4.2008.09.29.11.26.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Sep 2008 11:26:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080929153400.GJ17584@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97041>

On Mon, Sep 29, 2008 at 08:34:00AM -0700, Shawn O. Pearce wrote:
> Johannes Sixt <johannes.sixt@telecom.at> wrote:
> 
> > My point is that emphasis on "stat" in the name is wrong: That's about 
> > implementation, but not about the effect. Why wouldn't 'ignoreCygwinFSTricks' 
> > be specific enough?
> 
> I like this a lot better.  I could see us also bypassing other Cygwin
> functions like open() in order to get faster system calls for Git.

If you think that it may be useful to bypass some other functions, and
you want to use the same option to control that then a general name like
that makes sense. Personally, I don't believe that we may want to bypass
something like open() as it is not performance critical, but I said
above I don't care about the name much, so I am going to change my patch
to use ignoreCygwinFSTricks.

Dmitry
