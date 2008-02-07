From: "Jay Soffian" <jaysoffian+git@gmail.com>
Subject: Re: [PATCH] allow setting GIT_WORK_TREE to "no work tree"
Date: Thu, 7 Feb 2008 13:06:46 -0500
Message-ID: <76718490802071006j9eaa4bctedc18f4a62e2b91c@mail.gmail.com>
References: <20080206102608.GA1007@coredump.intra.peff.net>
	 <47A98F07.4000402@viscovery.net>
	 <20080206110131.GA4167@coredump.intra.peff.net>
	 <7v4pclvmae.fsf@gitster.siamese.dyndns.org>
	 <7vwsphu7gr.fsf@gitster.siamese.dyndns.org>
	 <20080207051317.GA32296@sigill.intra.peff.net>
	 <76718490802062313jdbd0e84xc9f36d703bb86c44@mail.gmail.com>
	 <alpine.LSU.1.00.0802071231540.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>, git@vger.kernel.org,
	"Lars Hjemli" <hjemli@gmail.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 07 19:09:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNB9h-0008VQ-5u
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 19:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759279AbYBGSGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 13:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758863AbYBGSGv
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 13:06:51 -0500
Received: from wx-out-0506.google.com ([66.249.82.227]:27626 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757997AbYBGSGt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 13:06:49 -0500
Received: by wx-out-0506.google.com with SMTP id h31so3748385wxd.4
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 10:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=osUTzD1gXpUBnollGuZBIErxsryrdXVSPUz8GOleyiE=;
        b=VBWd6UHRyqDd7E9h59JuXdf/30N+8Rwjg5vJZ30/cnqbJV6mS1015MZcT2DtagtfVmsRduVkThCzbs1ob8zw79cMdWErjRrkUCPdIWmaFM0czx/vQ9trs3du4gti6il+vsha/WNC+DHNopYzBV0Hi48dZ2Wf37drUoVDppEZB0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=YK+btsGHhQHVXkh+bD7bYESkLHaoULX2PU0v171bQX2ggbAT8Xs1EgKKC+pCwSSySBi1oCPdfBE89TWgTn2HXe81D/rmIO0U3jZbqMO74+b9jeZT5PpnDNZPbR4bvZVe07ZnH75flUQVtLDeALVJ3mmtLrQ84Rf3tAw/lf5n3XU=
Received: by 10.114.137.2 with SMTP id k2mr5963891wad.104.1202407606405;
        Thu, 07 Feb 2008 10:06:46 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Thu, 7 Feb 2008 10:06:46 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802071231540.8543@racer.site>
Content-Disposition: inline
X-Google-Sender-Auth: 8343e674adbcf9ad
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72981>

On Feb 7, 2008 7:33 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> On Thu, 7 Feb 2008, Jay Soffian wrote:
>
> > Is using something like "__GIT_WORK_TREE_NOT_SET__" that terrible?
>
> Yes.  First: it looks more like a C constant than a proper environment
> variable.  Second: what to do _sanely_, when both GIT_WORK_TREE and
> GIT_WORK_TREE_NOT_SET are true?

Sorry I was unclear. The discussion was about using a special value to
denote "this is not set." So I meant something like:

GIT_WORK_TREE="__GIT_WORK_TREE_NOT_SET"

There may not be precedent in git, but it is not unusual to use a
double-underbar prefix to denote private names and/or values. While in
theory a user could have a directory named as such, it would seem
highly unlikely. This looks a little cleaner to me than using ":", "
", or "/dev/null".

j.
