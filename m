From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Merging commits together into a super-commit
Date: Fri, 11 May 2007 13:54:14 +0200
Message-ID: <81b0412b0705110454w5b18c267x17e82453e736f0b8@mail.gmail.com>
References: <20070510215515.3084.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, kernel-hacker@bennee.com
To: "linux@horizon.com" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri May 11 13:54:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmThV-0000uq-AB
	for gcvg-git@gmane.org; Fri, 11 May 2007 13:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756147AbXEKLyQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 07:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756428AbXEKLyQ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 07:54:16 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:30387 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756147AbXEKLyP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 07:54:15 -0400
Received: by an-out-0708.google.com with SMTP id d18so225959and
        for <git@vger.kernel.org>; Fri, 11 May 2007 04:54:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GKPndBsoUZJZRNn66IbCHv72TNZHs12Zl1HQU2ilePBFhyESA6CqUXIKEKi4GT5y74z4HHq70SxiZjpyyUmsci1aQi1AUeSTnFx6CxuqvhCAawJYocbImsQHoNLJP3Hkr4DKv5N/5syPKCab9vsMuebwsCBse9k4syjxzZtT7Y8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ekPZF5e2b6NVdGr8wO2yEObYLYvbnrudqCwMkI2FvNFADCXWqRkbk4ohX2QMsCJ7KtPBZK6LOTPhyjkBtcYBRgs3UXK1cKkEiIqGXtjWEeQjmj+w7urkmdAa/7oS5I9MO/HKYavxYGPQZ7RA5X8I7jcH6vdp0KAYQcecqH1TIK8=
Received: by 10.100.144.11 with SMTP id r11mr2152157and.1178884454273;
        Fri, 11 May 2007 04:54:14 -0700 (PDT)
Received: by 10.100.225.3 with HTTP; Fri, 11 May 2007 04:54:14 -0700 (PDT)
In-Reply-To: <20070510215515.3084.qmail@science.horizon.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46955>

On 10 May 2007 17:55:15 -0400, linux@horizon.com <linux@horizon.com> wrote:
> Er... why is everyone making this so complex?
>
> git checkout trunk      # Switch to "trunk"
> git checkout branch .   # Overwrite with "branch", but stay on "trunk"
> git commit
>
> Now branch is the same tree object as "branch", but without the history.
>
> Of course, you could be even nastier and di a direct
>
> git-commit-tree branch^{tree} -p HEAD < commit_message
>

And it is not enough. Authorship information is lost. And you
have to be damn sure the "branch" starts directly at HEAD,
otherwise everything HEAD..branch is lost. It is complex
if you want it right.
