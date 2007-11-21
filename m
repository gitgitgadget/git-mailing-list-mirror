From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Wed, 21 Nov 2007 17:15:35 +0100
Message-ID: <8aa486160711210815g5a1973c2see28a6263fc56030@mail.gmail.com>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com>
	 <Pine.LNX.4.64.0711211554370.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 21 17:17:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IusF2-0001bb-RK
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 17:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757092AbXKUQPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 11:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756959AbXKUQPh
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 11:15:37 -0500
Received: from el-out-1112.google.com ([209.85.162.176]:36255 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756584AbXKUQPg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 11:15:36 -0500
Received: by el-out-1112.google.com with SMTP id v27so936788ele
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 08:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=VnuyoyqTYqx6StnflPXNfDtK6xxBuTRy4s8OXOMHxJU=;
        b=Zv3vzy7prbm/Ecfoi3pP6BkTfmTyXi7sEbtDPbwitEVYhNXn8bPufls8DU2w3/Auck25CzD1tn+T8fmyFS/n/uXLeobdAd/BqimvQGTLG8ONFSaXukD3E40IzFCtrOjq1XAtOtvSlL8Duuqp2BXMUKmL4UQK3EZIYMitn910vJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L/aq+XF6sdQF+ltfN8/8tuYhcMjK44Ktw7u946EfZrVaFLy3Lzj3i4LEbpZqVbsAu6CF2udSX6MaqUr9u7sCHkJFiHkA4OY9HpN1gGgXmK5AL8ClhBMHe/gWdncPCw4pusyH3Ks8GrNzAPdA1N181kkEzhwSCgibYEZ5tIYUFpg=
Received: by 10.151.6.2 with SMTP id j2mr1333845ybi.1195661735143;
        Wed, 21 Nov 2007 08:15:35 -0800 (PST)
Received: by 10.150.199.9 with HTTP; Wed, 21 Nov 2007 08:15:35 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711211554370.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65673>

On Nov 21, 2007 4:59 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 21 Nov 2007, Santi B?jar wrote:
>
> > 1) git-clone does not accept a bundle file, even if git-fetch does. I've
> > made a patch to use git-fetch in git-clone for this.
>
> This, along with rewriting git-clone as a very thin wrapper over git-init,
> -remote and -fetch, is a really low hanging fruit.

For the basic/normal mode it can be a very thin wrapper but you have
to support --local, --shared, --reference...

> > 2) The bundles created with "git bundle" does not record the HEAD, they
> > resolve the symbolic name to a branch name.
>
> It imitates ls-remote output.

No, it does not.

With a newly created project with one commit:

$ git ls-remote git.git
b71992713c17c3a29f9566e1b50e8cf402375faf        HEAD
b71992713c17c3a29f9566e1b50e8cf402375faf        refs/heads/master

$ git bundle create git.bdl HEAD master

$ git bundle list-heads git.bdl
b71992713c17c3a29f9566e1b50e8cf402375faf refs/heads/master
b71992713c17c3a29f9566e1b50e8cf402375faf refs/heads/master

Santi
