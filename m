From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH resend] make "git push" update origin and mirrors, "git
 push --mirror" update mirrors
Date: Mon, 28 Apr 2008 07:03:40 +0200
Message-ID: <48155AAC.5020106@gnu.org>
References: <4812DA50.3000702@gnu.org> <20080426170126.GC29771@spearce.org> <7vzlrgmrvb.fsf@gitster.siamese.dyndns.org> <20080427043014.GI29771@spearce.org> <20080427044049.GJ29771@spearce.org> <7vabjflvlh.fsf@gitster.siamese.dyndns.org> <20080427173446.GM29771@spearce.org> <7vy76zf449.fsf@gitster.siamese.dyndns.org> <20080428033237.GN29771@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 07:04:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqLXT-0005S4-0Z
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 07:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbYD1FDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 01:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752618AbYD1FDo
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 01:03:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:41613 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbYD1FDn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 01:03:43 -0400
Received: by fg-out-1718.google.com with SMTP id l27so4787343fgb.17
        for <git@vger.kernel.org>; Sun, 27 Apr 2008 22:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=eT10CSgXJIVGIR7Nt2/FUrNs19Wrfmgi4LEyvF6fJLY=;
        b=OiwXxQYWryBUTwjQcVlBD8eCqchRxXR0dou8DDqB8TcvQw8alXomwDj8y6Xau77uoMnv74IxTkt9Dpc3dRLAmteSsSOWqcBKBlmva3SAbJAV4ZG/xi7udRvEsXJUC8uBnzAmyzRkyEM4jAj1o5rpo6n/zbAsiH5l2onXbowOjdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=J5CYqK9mAvEFpSaYmpwya0aIqeupJFl6A9rO00qTeUzv6Z0mHFtfMLfUsmaldv3CyCS/LvBPsMFazsZTrkGqZQZN/dAJsWsODlR2kyZZVGTeQKwXqoYcPXdqDLhggFzv2s5ns3gy2U9zMe9IQ5AiRxSoYswnhaWYbHtz0qMWSeM=
Received: by 10.86.78.4 with SMTP id a4mr6386363fgb.73.1209359022417;
        Sun, 27 Apr 2008 22:03:42 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id j10sm8160699muh.16.2008.04.27.22.03.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 27 Apr 2008 22:03:41 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <20080428033237.GN29771@spearce.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80501>


> Yes, I think that is what I was thinking.  By making users always say
> where they are pulling, fetching or pushing from/to it becomes less
> weird when you have to give a refspec too.
> 
> But this clearly harms the `git pull` case that relies upon the magic
> branch.$name.remote and branch.$name.merge keys, as now git-pull is
> expecting the user to supply a remote name, but one was already saved
> for this current branch.

I would have no problem at all in removing the defaulting to "origin". 
Leaving the magic branch.<name>.{remote,merge} as the only case where 
0-argument "git pull" is allowed, would be much simpler to explain, and 
would not impact the "centralized" operation mode.

Paolo
