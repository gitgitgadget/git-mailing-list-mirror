From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH v2] Add a "fast stat" mode for Cygwin
Date: Sat, 27 Sep 2008 14:39:11 +0400
Message-ID: <20080927103911.GD21650@dpotapov.dyndns.org>
References: <20080923140144.GN21650@dpotapov.dyndns.org> <1222498926-30635-1-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Sat Sep 27 12:40:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjXE7-0007GZ-Uy
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 12:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbYI0KjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 06:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbYI0KjS
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 06:39:18 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:29909 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbYI0KjR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 06:39:17 -0400
Received: by ey-out-2122.google.com with SMTP id 6so403673eyi.37
        for <git@vger.kernel.org>; Sat, 27 Sep 2008 03:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MlVBWzjnn8J/oDaMiANN6VMSiq+wjR1mguDmXjyeOFc=;
        b=mg4AnSTcfuJABTgWg5Xtw6DKba0tT8Vm54njL9a6x8wSshX9l03aD9RTnkS2uj8Lbl
         blOYHQbpN/ijHhgrQi6HYwGugd7YeVXtSwMp32RnCSyeBXY6zTKFw/2Bj/p35s0AwwrX
         R5z9NSVqDTZksl9XDic9zbuWvT3xct6XG5kz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NfMk7wjrWhVq64NaKOGrj37mrRPEXul0FlOI/9d5C7OKc9jgqoqSdfFW6SL5aeX62k
         OWrgMIUdhPD2T4ZIajkrrbuHsybx4Ske5eH4yfnBh9Rpj7CLZ47LtkqJbgagOen267tz
         3fm8Crvh1/f0ud3Ntti8weo51AEXqn2VqtWng=
Received: by 10.210.16.16 with SMTP id 16mr2902404ebp.35.1222511955037;
        Sat, 27 Sep 2008 03:39:15 -0700 (PDT)
Received: from localhost ( [85.141.151.122])
        by mx.google.com with ESMTPS id 7sm5574286eyg.0.2008.09.27.03.39.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Sep 2008 03:39:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1222498926-30635-1-git-send-email-marcus@griep.us>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96910>

Hi Marcus,

On Sat, Sep 27, 2008 at 03:02:06AM -0400, Marcus Griep wrote:
> 
>  This is a substitute patch that takes care of many of the concerns already
>  posted to this thread regarding the patch.  Sorry if it steps on your toes,
>  Dmitry.  You began scratching my itch, so I wanted to jump in and scratch
>  some more.

I am sorry I was not able to send my patches earlier. I had them ready
by the end of the day when we had the discussion, but I have not had an
opportunity to test it on Windows till today.

I have only skimmed over your patch, but there are a few changes that
I really dislike about your patch. You changed the semantic of _choice
functions. While I use it as stubs to choose what implementation to use,
you make them part of implementation, which is always called. So I do
not understand why you left the comment saying that they are only stubs
and then why you need function pointers at all then.

Also, you made some changes to MinGW (I don't know if you tested it),
but any change like removing _getdrive() from MinGW version is better
to move into separately patch (or, at least, clearly state them in the
commit comment).

Anyway, thanks for your efforts, but if you want to go ahead with some
other match of mine (especially Windows related), please, let me know,
so we can avoid stepping on each other toes.

Dmitry
