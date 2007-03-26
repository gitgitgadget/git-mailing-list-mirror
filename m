From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: Question regarding: git pull --no-commit origin
Date: Mon, 26 Mar 2007 11:47:50 +0930
Message-ID: <93c3eada0703251917j3ed8702dvc622bb94a1e5e8af@mail.gmail.com>
References: <93c3eada0703251632s3be48b60na03728ce72b8ab8c@mail.gmail.com>
	 <20070325233823.GA13247@spearce.org>
	 <93c3eada0703251816lc430e03l71ee2ffaa3d8796@mail.gmail.com>
	 <20070326014757.GA28592@coredump.intra.peff.net>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 04:18:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVemg-0004Ud-Ca
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 04:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933291AbXCZCRx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 22:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933387AbXCZCRx
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 22:17:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:14922 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933291AbXCZCRw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 22:17:52 -0400
Received: by nf-out-0910.google.com with SMTP id o25so2752935nfa
        for <git@vger.kernel.org>; Sun, 25 Mar 2007 19:17:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i55FcYjE9fGBWlkgV0pP0scmfpp0VnSSInowijrN9CiwT5BZ7xpG2UVzobaOj9k6XSlhe1WRhRPVZoJCf4vI2wYqbMflPspjHds/NL2rjGZJVtk7EOqOjSnEuNULArHBZZqb5PYr52CLzH1dtVSbYBlN0aBlzi3s8hPpQ4lBWI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aUq4wh5HeNa3jmS6Pbrc1OQh88x8QS7V2K2orvYq9NxHMSOnpAZ7vNm7F4Feuq9huX8/W/qbFaDw2erQSFcnMNQfzp0xiKtXz6GENekfutIk/Yi/OLS2iyEfG4Mob7cwxyCk75Ye9rvhdENUWTQHMmpXe0c5bF03vKSGiYemuV4=
Received: by 10.82.188.15 with SMTP id l15mr12702965buf.1174875470920;
        Sun, 25 Mar 2007 19:17:50 -0700 (PDT)
Received: by 10.82.111.16 with HTTP; Sun, 25 Mar 2007 19:17:50 -0700 (PDT)
In-Reply-To: <20070326014757.GA28592@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43107>

On 3/26/07, Jeff King <peff@peff.net> wrote:
> On Mon, Mar 26, 2007 at 10:46:09AM +0930, Geoff Russell wrote:
>
> > If --no-commit won't let me do this then perhaps I need something like:
> >
> >          git pull origin:testing
> >          git checkout testing
> >           .... test
> >          git checkout master ; git pull . testing
>
> Close.  Remember that a pull is basically a fetch + merge; so your first
> command is just the fetch:
>
>   # fetches everything from origin
>   git fetch
>   # see what they have that we don't
>   git whatchanged HEAD..origin/testing
>   # check out their code in more detail
>   git checkout origin/testing
>   # or even make our own branch in case we have tweaks to make
>   git checkout -b testing origin/testing
>   # and once we're OK, do the merge
>   git checkout master; git merge origin/testing
>
> All of that assumes git 1.5 or greater, which uses the separate remote
> layout and has some interface improvements. For older versions, their
> 'testing' branch will be pulled into your 'testing' branch, and I
> believe you will need to 'git pull . testing' to merge it.
>
> -Peff
>

Ok, that's all nice and clear now. Many thanks.

Geoff.
