From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: make test failure with latest master
Date: Mon, 03 Dec 2007 18:10:36 -0500
Message-ID: <47548CEC.6010701@gmail.com>
References: <4752A53E.4030000@gmail.com> <20071202163426.GA29781@coredump.intra.peff.net> <47533D75.1090002@gmail.com> <Pine.LNX.4.64.0712022340250.27959@racer.site> <20071203015954.GB8322@coredump.intra.peff.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 04 00:11:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzKRJ-0008Na-Vp
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 00:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbXLCXKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 18:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbXLCXKm
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 18:10:42 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:21007 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbXLCXKl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 18:10:41 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2879496rvb
        for <git@vger.kernel.org>; Mon, 03 Dec 2007 15:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=+mpMvuRervlaZjCzgLTBPqSvHbamAfzbQbks/gm+UGY=;
        b=XJFTL4uRbo4hL2skshE0aIc+rZEPOT2nsctZMimj5TOSBsenbRxHW8hXPrENjC0hno1UqgLIdJEuhab68jH2gfzYekNatFol/Uo/6An0WAMJSkKcNPpfiS35Chg/CiQBG+6fC7+fwFDfKRONLU0fTiLN2tIna3AkA61cPXxryrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=wm4VjUWLgoCUq/yP3jdXjEFVF3VxdoxVeQpG+FFBwkCkIE9dfX1qe7Vuvk3p7pHZ9s0Xw+ZmzMwBirGxO7dCHAqB/BBTlQi1mQT0DJ446AN90y4WbmqH0WSctv4QxSXpik8uuhF+UQSegGgKn2hJ7IyVSoegwja9/tCum0JmLYM=
Received: by 10.141.15.19 with SMTP id s19mr1875373rvi.1196723439885;
        Mon, 03 Dec 2007 15:10:39 -0800 (PST)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id 7sm815552wrl.2007.12.03.15.10.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Dec 2007 15:10:39 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20071203015954.GB8322@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66974>

Jeff King wrote:
> On Sun, Dec 02, 2007 at 11:41:10PM +0000, Johannes Schindelin wrote:
> 
>>> Attached is the output of
>>>
>>> 	./t9600-cvsimport.sh --verbose >/tmp/9600_out.txt 2>&1
>>>
>> Unfortunately you attached the interesting part, so I cannot quote it 
>> here.  Seems that your cvsps does not understand the "-A" option.  So it 
>> looks like it is too old.

[Ignoring gitte's declaration that the core of git is dependent on CVS]

> Yes, the changelog indicates that -A was added in 2.1, and he is running
> 2.0rc1.
> 
> We can do something like this, though it feels a bit hack-ish and will
> need updated for new cvsps versions (a less lazy or more clever shell
> coder than me could do a nice >= version comparator).

The patch "fixes" the issue for me.

> -- >8 --
> t9600: require cvsps 2.1 to perform tests
> 
> git-cvsimport won't run at all with less than cvsps 2.1, because it
> lacks the -A flag. But there's no point in preventing people who have an
> old cvsps from running the full testsuite.
> 
> Signed-off-by: Jeff King <peff@peff.net>

Acked-by: A Large Angry SCM <gitzilla@gmail.com>
