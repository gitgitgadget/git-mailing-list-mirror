From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a custom merge strategy
Date: Tue, 29 Jul 2008 10:36:32 +0100
Message-ID: <e2b179460807290236k214b41f2wee25c213d7c95ae3@mail.gmail.com>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com>
	 <20080728185604.GA26322@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0807282008470.8986@racer>
	 <20080728192651.GA26677@sigill.intra.peff.net>
	 <7vsktto78y.fsf@gitster.siamese.dyndns.org>
	 <20080729050218.GD26997@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	sverre@rabbelier.nl, "Git Mailinglist" <git@vger.kernel.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 29 11:37:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNle9-0001j3-Ky
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 11:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618AbYG2Jge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 05:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754610AbYG2Jgd
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 05:36:33 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:44967 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559AbYG2Jgd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 05:36:33 -0400
Received: by rv-out-0506.google.com with SMTP id k40so4928307rvb.1
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 02:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Okx9Xlr78CApXGyxZKC8lFTDpR781ptBVFkkEajq+rQ=;
        b=kr4t/5x/5j3bGUmlP5iXOfXRxByKWaZymI6dVV39VCYMVTgNv3ntkI1WHpIQKgjFUW
         99DHjtkQpPneLmWq32UvIBb2OETFe6iUv3aAw40wVHNfnkE/sD8GS03S8piQZJQGOfxE
         qouBNELSt3U4NMdQp3hXWnXiH9Z7k4f7j7RQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=UyDgE9yzOlq0m3qhE8oC2UxsrdNDXx92b9KgocTKx/5u0kL7JvNCkqth7DGn1F6436
         GfxSqz2d7pca3VIcQUiDkZZEdxX9sXyEX9q8++Kdsb4jJEHbGF38Up2hOlNySeg0pDRo
         mkoDfrE5ejDAsdHOE88D9M7Qu2LsPbS5S/0wY=
Received: by 10.140.193.16 with SMTP id q16mr2887037rvf.109.1217324192267;
        Tue, 29 Jul 2008 02:36:32 -0700 (PDT)
Received: by 10.140.136.12 with HTTP; Tue, 29 Jul 2008 02:36:32 -0700 (PDT)
In-Reply-To: <20080729050218.GD26997@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90609>

2008/7/29 Jeff King <peff@peff.net>:
> On Mon, Jul 28, 2008 at 05:37:33PM -0700, Junio C Hamano wrote:
>
> I just didn't want history thrown away for two reasons:
>
>  - historical interest; some of the commits had counterparts in devel
>    that were done differently (because the two branches had diverged),
>    but it might later be interesting to see how and why the stable
>    changes were done (e.g., if a similar situation arose)
>
>  - this project did not rebase, favoring the simplicity of "git pull"
>    over clean history.
>
> Bear in mind that this project was not very big. I think devel had ~20
> commits, and stable had about ~5. So it was easy to get such confidence.

Is there any reason you couldn't have reverted the stable commits in
preparation for the merge from devel?

I.e. these commits were necessary to fix problems in production, they
now need to be reverted in order to cleanly apply the changes for the
next stable version, which includes fixes for all of these problems.

I can see you'd be preserving twice as much history instead of
throwing any away, but if scalability became an issue, you could
always squash all the reverts into one pre-merge commit.

git-merge-theirs-revert anyone?

Mike
