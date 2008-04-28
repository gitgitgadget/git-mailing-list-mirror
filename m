From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH resend] make "git push" update origin and mirrors, "git
 push --mirror" update mirrors
Date: Mon, 28 Apr 2008 13:24:38 +0200
Message-ID: <4815B3F6.1030402@gnu.org>
References: <7vzlrgmrvb.fsf@gitster.siamese.dyndns.org> <20080427043014.GI29771@spearce.org> <20080427044049.GJ29771@spearce.org> <7vabjflvlh.fsf@gitster.siamese.dyndns.org> <20080427173446.GM29771@spearce.org> <7vy76zf449.fsf@gitster.siamese.dyndns.org> <4814E097.7030407@gnu.org> <20080428012613.GB15121@sigill.intra.peff.net> <48155B7F.8020202@gnu.org> <20080428090948.GC16153@sigill.intra.peff.net> <20080428091150.GA16209@sigill.intra.peff.net> <48159688.2030202@gnu.org> <alpine.DEB.1.00.0804281132420.5399@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 13:25:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqRUO-00084k-M8
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 13:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763092AbYD1LYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 07:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763069AbYD1LYm
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 07:24:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:32415 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759399AbYD1LYl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 07:24:41 -0400
Received: by fg-out-1718.google.com with SMTP id l27so4908333fgb.17
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 04:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=SN5M4bA+5LaZj2ybHjQ6oaDliQz+BU43CnxuD+GKXm0=;
        b=DOPz1xW8g40RnXQiqNvwR/TwppH/FZvgpkCEYg37IJGh2VUbt3umjNXXnIcrOMTY6dbkpxxNeaQZIdGlZxYhVI6TkkVCLu2gwbroYe82fhE4hgI160jycuXPMjddRHbF75FSY8PJHrdaJf8r/KLpI8w6ZmVDtGnmo8uwZysnfic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=oVedouzsJ8FVYM0WVfYzx6CtNF12hE4FrFieEk7zl8PQTVjR0zt/iOnqUMS2UULPumNdNp/Y/QlHjJMbSbZnXcdqiPjooHInRIOJBqvzfaTFbmN4QpGY+7g2QpfQddEaXgmsvb4BOwTvYucV9/qUpLErhlcoqCJpE/DuJCv3Nk4=
Received: by 10.86.97.20 with SMTP id u20mr7385184fgb.40.1209381879605;
        Mon, 28 Apr 2008 04:24:39 -0700 (PDT)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id s10sm8777096mue.15.2008.04.28.04.24.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Apr 2008 04:24:38 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <alpine.DEB.1.00.0804281132420.5399@eeepc-johanness>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80525>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 28 Apr 2008, Paolo Bonzini wrote:
> 
>> I'm preparing a patch that has "git fetch" fetch from all remotes (same 
>> as "git remote update" with no groups defined)
> 
> Funny, I would think that this functionality belongs into git-remote 
> instead of git-fetch.

Maybe, but I'm pretty satisfied with the result.  It would take more 
effort than that to add all the functionality within "git remote 
update", and my patch series removes most of the magic associated with 
"origin".

> Especially since it would be possible to reuse the 
> code you referred to...

I checked and there's not much to reuse, since we don't care about 
groups or anything else.

Stay tuned -- I'm looking forward to any criticism.

Paolo
