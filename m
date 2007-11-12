From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] status&commit: Teach them to show submodule commit summary
Date: Mon, 12 Nov 2007 18:47:09 +0100
Message-ID: <8c5c35580711120947s246f192coa3796ac6541a28d7@mail.gmail.com>
References: <1194877277-31777-1-git-send-email-pkufranky@gmail.com>
	 <4738784F.7010106@viscovery.net>
	 <46dff0320711120835h31166370k64e9c92e9cf3432c@mail.gmail.com>
	 <47388344.6010008@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Ping Yin" <pkufranky@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 18:47:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrdNg-0007Ht-4t
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 18:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbXKLRrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 12:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbXKLRrL
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 12:47:11 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:23139 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbXKLRrK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 12:47:10 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1606047wah
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 09:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=taIwq/y767msiu/eT0rmPdF+GUm6gwJF/CeRDWY21EQ=;
        b=RkWtRfo6XA2ihg70ID21807oHpRQOjH1ZIFTR9oZonuLH9JRAtgTLAhqYXkT8W4voODD1osZhqmIAKoPXt1OZxL2d1SitmP3k5+Mw2riSFiy9NEj94t7Fju9GNV+MuZeMWH/k2D+JCMfpPDf+DwWgExnCJi5pDBTtE+4V75mlvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ip4uvUlqOw2ULZWrUP4R3n3RORXn18E3cJUns6YDo8aHSCevZgHD4nrgf7/ZNTlaZR4g75loNe9RAlXh4whBYQOPwHGMeBDJhjLhA8OkyF5jJlWpymc91Po1eKzX+GEt0QTScMkdztKYqUisssfhZu+dvt4hBGL6vSCRPC6snzg=
Received: by 10.114.123.1 with SMTP id v1mr174926wac.1194889629489;
        Mon, 12 Nov 2007 09:47:09 -0800 (PST)
Received: by 10.114.235.4 with HTTP; Mon, 12 Nov 2007 09:47:09 -0800 (PST)
In-Reply-To: <47388344.6010008@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64675>

On Nov 12, 2007 5:45 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Ping Yin schrieb:
> > On Nov 12, 2007 11:59 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> >
> >> But at this time git-commit is about to be made a builtin, and since your
> >> implementation contains a lot of non-portable constructs ($'', >&) and a new
> >> dependency on awk (and, hence, has little chances of being accepted), I
> >> suggest that you stay tuned, and implement this in the forth-coming
> >> builtin-commit.c.
> > Implement this in shell scripts is just a piece of cake, but not so
> > easy in builtin-commit.c.
>
> I'm with you. But git-commit.sh is a dead horse, no matter how hard you beat it.
>
> BTW, maybe you can keep the log generation in a helper script,
> git-status--submodulesummary, and invoke that from builtin-commit.c. This
> way you get both: integration and ease of implementation.

Sorry for repeating myself, but IMVHO this belong in git-submodule.sh:
It can be useful as a standalone command, we get all submodule-related
commands isolated in a single place, and builtin-commit.c can of
course exec git-submodule to get the summary.

--
larsh
