From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Tue, 29 Apr 2008 11:02:02 +0200
Message-ID: <4816E40A.4020700@gnu.org>
References: <cover.1209391614.git.bonzini@gnu.org> <55a4068681841e6c3579f4183b469fc7aa4de266.1209391615.git.bonzini@gnu.org> <20080428181012.GB6710@steel.home> <48161544.90500@gnu.org> <20080428213339.GC10600@steel.home> <4816A989.2010204@gnu.org> <20080429053814.GA3332@steel.home> <4816C527.4000406@gnu.org> <4816CB46.1050100@op5.se> <4816D505.1000208@gnu.org> <4816E0F6.3030302@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	spearce@spearce.org, gitster@pobox.com, peff@peff.net,
	johannes.schindelin@gmx.de, srb@cuci.nl
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Apr 29 11:03:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqljl-00060p-Qe
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 11:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754208AbYD2JCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 05:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753355AbYD2JCG
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 05:02:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:58270 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbYD2JCE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 05:02:04 -0400
Received: by nf-out-0910.google.com with SMTP id g13so2154305nfb.21
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 02:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=OaillPSkNpKZz7+yP3FZfFQcWYVzXZUdHQF+OqbvRWM=;
        b=QrIk5wsvueU53DXKoJT/KXIkUolzhYuP4xHrSfeTJ2HxH5gIPQg7q7tkUBEgKmiJcgMQB3ex6zjtbsL+D/GuyyK5zSgkLQ8apcaPvKxR50IbQ6GZBWrk5jMYBLb+2VWcBaytbXldC7UWLe85qdp09kpsFHPwrr8WqIcWPbm0feM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=Z5etS14zYt2D6p0BoAQg56T0iqB+S4EB25rOmdO6BB0OOL6P7XhnoxIvdF7VSBsCIpO810+/PCcZpK6XedUX7gvkNRtg1Wqs/v93slOwDYqTN6bSjgvhq7h+U0Yeq9WX1mQdkB4tBUvQWrMNxR3TwTyT5qMkzf9dU2YvwmVLikk=
Received: by 10.210.51.10 with SMTP id y10mr7059599eby.57.1209459723658;
        Tue, 29 Apr 2008 02:02:03 -0700 (PDT)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id i5sm28665244mue.7.2008.04.29.02.02.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Apr 2008 02:02:02 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <4816E0F6.3030302@op5.se>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80672>


>> Sorry, how does the patch make you lose some of your work (as opposed 
>> to some of your time, which is possible as is the case for every 
>> backwards incompatible change)?
> 
> Because I will lose some of the refs and then have to dig them up in the
> reflog.
> 
> I'm not comfortable with the reflog. I appreciate its usefulness, but I'm
> thoroughly unhappy when I'm forced to use it.

So am I, but still it would lose time (to dig refs up in the reflog), 
not work (e.g. having to rewrite code).  I think we're in agreement on 
this part.

> Yes, I understand the rationale, and I do have an alternative idea, which
> is to make it configurable.

Then sorry, but I think you don't understand the rationale.  The cover 
letter has excerpts from other git hackers' e-mails that explain it 
better than I can.  But shortly speaking, the point of the patch is to 
remove the "magic" operation of "git fetch" as "git fetch origin". 
Removing is quite the opposite of "add a configuration option that 
disables it, but leave the old behavior as default".

> Now that I think about it, it's probably useful to have it
> togglable via command-line switch as well. Something along the
> lines of "git fetch --all-remotes", perhaps.

Making it accessible via a command-line switch is pointless, as we 
already have "git remote update" for that.

Paolo
