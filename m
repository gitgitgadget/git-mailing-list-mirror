From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Tue, 29 Apr 2008 18:40:24 +0200
Message-ID: <48174F78.7020400@gnu.org>
References: <cover.1209391614.git.bonzini@gnu.org> <55a4068681841e6c3579f4183b469fc7aa4de266.1209391615.git.bonzini@gnu.org> <20080428181012.GB6710@steel.home> <48161544.90500@gnu.org> <20080428213339.GC10600@steel.home> <4816A989.2010204@gnu.org> <20080429053814.GA3332@steel.home> <4816BAB1.7080601@op5.se> <4816C67E.8010600@gnu.org> <alpine.DEB.1.00.0804291711450.27457@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com,
	peff@peff.net, srb@cuci.nl
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 29 18:41:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqstI-00017M-JT
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 18:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbYD2Qk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 12:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752877AbYD2Qk1
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 12:40:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:23923 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbYD2Qk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 12:40:26 -0400
Received: by fg-out-1718.google.com with SMTP id l27so61335fgb.17
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 09:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=VhyKyoaoETRPbVyQ8E1xs27PO+bhW5RkzGzuksa1aDc=;
        b=eeElH333ygWNp/EDB8w6g16CObHIVcPtrsAFhtBnojHDQaex23qcWu08g7FbJu6oI2RGxESFPm+2zVHLhahE+VckyU1PPNB1tSddjOxE9tBubMQfxEN24ufVCf6+pF3+aapRSF6dxpM1MVakDmZhhWIPdWBVy6CKIHCJDHlPxvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=QoKNWQI/JS/cj32dAtYbWVFWgyxOYmzev6HxaZ2TShbTYB02rQz0EHUVe2FfZ9cwkbNTMVFKgp0FjnXld1cOxHRkPoe7RCgQ006Sax0j5KvXfP9dqq6Vjfh+WNqXtFSpBIzj+VHMzyngkxEgw1y3eDbh5zKFSgcc4fqqEEqlr+I=
Received: by 10.86.81.14 with SMTP id e14mr9808664fgb.42.1209487224124;
        Tue, 29 Apr 2008 09:40:24 -0700 (PDT)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id y37sm129255mug.3.2008.04.29.09.40.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Apr 2008 09:40:23 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <alpine.DEB.1.00.0804291711450.27457@eeepc-johanness>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80704>


>>> Some of them point to my colleagues laptops, where temporary
>>> git-daemons sometimes serve content, and sometimes it doesn't.
>> Again, you should probably have skipDefaultUpdate set on those remotes even
>> now!
> 
> Umm, why?

Because I don't want to make sure my colleagues *all* have their laptops 
turned on when I run "git remote update" (on the default group).  Those 
remotes should be fetched individually as the need arises, or maybe with 
a special group, but not by default.

>> A patch that makes a "wrong" (or incomplete) configuration more
>> apparent, is not necessarily wrong in itself.
> 
> Your suggested changes are actively _making_ them wrong.  They are not 
> wrong now.

Sure, you can consider a configuration that affects "git remote update" 
to be correct if you're not using "git remote update" at all.  But a 
wrong you never saw/experienced is not a right.  My changes are actively 
making the wrongness apply more broadly, that's clear.

> Happily, I am quite certain that Junio will not allow such dramatic 
> changes into Git, at least not without a long, long time of warning, 
> during which I can safely undo the changes in my personal branch.

I wouldn't be surprised if it didn't go in 1.5.6 -- indeed.

Actually I think the "git pull" changes (patches 5 and 6) and the 
matching refs refspec (patches 1 and 2) can go in sooner, but I sort of 
expect the other 3 patches to lie in limbo for a longer time.

> I absolutely hate the idea of "origin" _not_ being special.

Well, Junio and Shawn convinced me of the contrary, so I guess they 
disagree with you on this one...

Paolo
