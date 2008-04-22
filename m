From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: git remote update -> rejected
Date: Tue, 22 Apr 2008 15:53:16 +0200
Message-ID: <480DEDCC.8020809@gnu.org>
References: <1208857733.4695.37.camel@marge.simson.net> <20080422103458.GA14751@sigio.intra.peff.net> <1208861703.18689.2.camel@marge.simson.net> <20080422111113.GB11238@sigill.intra.peff.net> <20080422124118.GA3098@mithlond.arda.local> <alpine.DEB.1.00.0804221354180.4460@eeepc-johanness> <20080422130122.GB27577@sigill.intra.peff.net> <alpine.DEB.1.00.0804221404360.4460@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Teemu Likonen <tlikonen@iki.fi>,
	Mike Galbraith <efault@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 22 15:54:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoIx4-00089B-Op
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 15:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759000AbYDVNxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 09:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763274AbYDVNxd
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 09:53:33 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:25304 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759000AbYDVNxc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 09:53:32 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2196029fgb.17
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 06:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=IuuZiZdvhAcuHm5hCkfLXUoIed1UH02eYJGBzpxpV4Q=;
        b=L7oz00pKgAjkSJ1BtOeayACn+l/ZxQ3u2Tb6kOg5YQ1+O/H4yqTNiNZCCT9cJiPJAv17wdGByTn9upY+/ivmzoWMgiCGXtZkwzc8do5+IDaPzcBXInB4qjju824frYyAbDD+7LlEMRuaqbrT06V5plhxpDQytcC/FGOhy3gWHKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=HER1G8MxPnKCYZJor5csZlwWZkiOKireVRBi3C0iaKVWSud7K8Vha4FiT2Jy51nSL5PO+hup7pgx1gywjm+fRNXMWeO1q3CSI5sKk2RWZVT5M2rNTlOzBinN6jds4AdkSqtGxGA5JQdJtFGDeu1Ru/8HBRwJ/bs/zjKqnuayNXc=
Received: by 10.86.98.18 with SMTP id v18mr563740fgb.56.1208872397828;
        Tue, 22 Apr 2008 06:53:17 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.176.226])
        by mx.google.com with ESMTPS id 4sm4390956fge.3.2008.04.22.06.53.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Apr 2008 06:53:16 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <alpine.DEB.1.00.0804221404360.4460@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80120>

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 22 Apr 2008, Jeff King wrote:
> 
>> OTOH, if you are using non-separate-remote layout, I think it makes
>> sense to _not_ have the "+". OTOOH, when you call the option --mirror,
>> it makes me think of "push --mirror" which implies "+".
> 
> I am glad somebody else than me finds this to be a dilemma.

Pushing to a mirror implies a "+".  But pulling from a mirror had better 
not imply a "+", as Dscho pointed out in this thread and implemented in 
his patch.

Non-fast-forward pulls from a non-mirror are safe, so they can imply a "+".

Maybe, "git remote add --mirror" should add a "push" line instead of a 
"fetch" line, and should not allow -f or -t options.

Paolo
