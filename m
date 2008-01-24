From: Luke Lu <git@vicaya.com>
Subject: Re: Trying to get GIT running on SCO OpenServer
Date: Wed, 23 Jan 2008 19:01:50 -0800
Message-ID: <3213B93E-42FF-4D63-A3A4-BD742630CEA1@vicaya.com>
References: <20080123212613.GN2230@yugib.highrise.ca> <alpine.LSU.1.00.0801232346010.5731@racer.site> <7vsl0oax42.fsf@gitster.siamese.dyndns.org> <4797F902.4000104@zytor.com> <alpine.LFD.1.00.0801231846540.2803@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Aidan Van Dyk <aidan@highrise.ca>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 24 04:02:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHsMN-000069-1N
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 04:02:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbYAXDB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 22:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752176AbYAXDB4
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 22:01:56 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:18016 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbYAXDBz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 22:01:55 -0500
Received: by rv-out-0910.google.com with SMTP id k20so61891rvb.1
        for <git@vger.kernel.org>; Wed, 23 Jan 2008 19:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        bh=VGXzifOn7omWBnrMAOLg0mnD/SloJ19uu2ZItQ2mRck=;
        b=EikwcoR5U+og2LWxAuZuoeXPqt4kb3Jf8D/yrUxASG1YzOC9JYeLhce5ZLGeGlZbp61LKJ9CPF0nnFalj45S+fsaV6+gx4K4+xi4qFVcfRolMwjIVwB8IMk10Vie0nILqTJ5XQqUMXzQBkPIs/5R6gbjzyMqb6w/gzADvMU++CY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        b=P01j107ICVeLKEjIkOGxj5DRxZu64to5CelrM/63wWAb3ngF4yOSFhLpSyPlLnM7GaGEGBw2LiYLXZLFWepCpedWBi5pt6/hlXFIDZBll77pVLTo5QE3M0sinVtLyv0HTLvYKZX0/T4IGjvQEGc1ktbOVMNnm9SntYE4/FaErcw=
Received: by 10.141.15.19 with SMTP id s19mr93264rvi.161.1201143714261;
        Wed, 23 Jan 2008 19:01:54 -0800 (PST)
Received: from ?192.168.15.20? ( [98.207.63.2])
        by mx.google.com with ESMTPS id k34sm466151rvb.23.2008.01.23.19.01.52
        (version=SSLv3 cipher=OTHER);
        Wed, 23 Jan 2008 19:01:53 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801231846540.2803@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71584>

On Jan 23, 2008, at 6:50 PM, Linus Torvalds wrote:
>
> On Wed, 23 Jan 2008, H. Peter Anvin wrote:
>>
>> That's what va_copy() is for.
>
> Well, anybody who has such an old setup that they have a broken  
> vsnprintf,
> I'd expect they don't have va_copy() either. It's C99, I think  
> (although
> there were obviously implementations of it before that).

I wonder what's the downside of just using a native format  
implementation like the one in Vstr[1] or bstring[2]?

strbuf_addf would be faster and immune to the buggy/outdated host  
*sprintf implementations.

__Luke

[1]: http://www.and.org/vstr/
[2]: http://bstring.sourceforge.net/
