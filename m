From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 1/9 v4] bisect: add "git bisect replace" subcommand
Date: Fri, 14 Nov 2008 11:03:46 +0100
Message-ID: <491D4D02.6080004@gnu.org>
References: <20081111063904.7da4df94.chriscool@tuxfamily.org> <200811121515.48277.chriscool@tuxfamily.org> <491C58A3.2000609@gnu.org> <200811141034.06282.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 11:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0vY4-0000Ds-7Y
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 11:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbYKNKDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 05:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbYKNKDw
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 05:03:52 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:63473 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbYKNKDv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 05:03:51 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1078339fgg.17
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 02:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=qAuCpdlduo6TD9MFlxRsrDvWX7z1J7/Pff7IYA9J7B8=;
        b=eTzLWkpXiYqkI07WIXXH58HFppiLnHXOPrU7No/+eb+wNgYEXQJTKkvvPagdbWrxrn
         njVDXlYzPNihHMw49UqRB9/SNseLke8OZN1iYI9z3TzssJunGV2QQzegBxNkbziN5ZMT
         rD0PmVeMfhP5+/JY+KEJvCvAsihjnCkYarJzA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=jPZisYXHWVAacoBCzhfvw4KXL778tlR+gYfDIi3Jcow/vdmI3yQIQuayBOMEcnwpf5
         utDJZnYNFGM30+xuI6JG9N1B5cr8AryYIrzttyLTkhZAw2dvSemfvKbOe8efk4YPyxhT
         fhRTEDEVwa4EcWNjifUxJDfko8fxHi1+iDOUY=
Received: by 10.86.60.14 with SMTP id i14mr473627fga.70.1226657029300;
        Fri, 14 Nov 2008 02:03:49 -0800 (PST)
Received: from scientist-2.mobile.usilu.net ([195.176.179.202])
        by mx.google.com with ESMTPS id e20sm1811558fga.1.2008.11.14.02.03.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Nov 2008 02:03:48 -0800 (PST)
User-Agent: Thunderbird 2.0.0.17 (Macintosh/20080914)
In-Reply-To: <200811141034.06282.chriscool@tuxfamily.org>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100963>


>> users could also set up a few 
>> special bisect/set-debug-to-1, bisect/remove-cflags-o2 and so on patches
>> that you could use for purposes other than ensuring known bugs are fixed.
> 
> In this case it is similar to Junio's proposal. But I think that for changes 
> like set-debug-to-1 and remove-cflags-o2, using the right make command 
> should be enough.

Yeah, I couldn't think of a better usecase, but you got the idea.

>> Finally, you could have a [bisect] configuration section with entries
>> like "cherry-pick = BROKEN-SHA1 FIX-SHA1" and "git bisect" would apply
>> FIX-SHA1 automatically if the bisect tip were in BROKEN-SHA1..FIX-SHA1.
> 
> Yes, but how do you share this between members of a team?

That's a common problem with stuff that goes in .gitconfig.  It does not
belong in the repository, though...

Paolo
