From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 03:05:05 +0700
Message-ID: <fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>
	 <Pine.LNX.4.64.0711271617350.27959@racer.site>
	 <20071128000731.GD9174@efreet.light.src>
	 <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
	 <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
	 <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
	 <20071129150849.GA32296@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jan Hudec" <bulb@ucw.cz>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 29 21:05:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixpdq-0001mI-Dm
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 21:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760134AbXK2UFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 15:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759914AbXK2UFL
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 15:05:11 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:37197 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759174AbXK2UFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 15:05:09 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1975132nfb
        for <git@vger.kernel.org>; Thu, 29 Nov 2007 12:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rZGMmcWfLg7X5/STamcLbrRj5AMHEGzRNayWytLcrFU=;
        b=j1yEBnQDBHKyyIe/vfSWiDYk6PCA/0eb1534cK/9zxpLZJBpxrqezLwarmbI6MqfwK5uvIcZuZfHCCYPu9ykrdtncNbRgjd1l47nLKgAaJ8gKly72Sf07UMok61p0PyCorZca/KIXeBtbPzeFlGA8gbH8YCl5DA8H0jkWXF6sIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PI2vbRQJAdWsN3Aj+a1XOAHrAaIMvm+2rXRLLNbPZ9r1hgjZBWLBVeEjjmiu+S0GpA1Pg82f0PNCpIF+SEnTpOXUoo6cdGvzrfavSf9VLBH3sHx8CLP3x1ULPEbd3sMufKtll9kh+AIBOnruhCmpj/VDUpoC0J/AOFSR4W41maI=
Received: by 10.86.49.13 with SMTP id w13mr6439990fgw.1196366705757;
        Thu, 29 Nov 2007 12:05:05 -0800 (PST)
Received: by 10.86.83.6 with HTTP; Thu, 29 Nov 2007 12:05:05 -0800 (PST)
In-Reply-To: <20071129150849.GA32296@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66557>

On Nov 29, 2007 10:08 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 28, 2007 at 03:14:56PM -0800, Junio C Hamano wrote:
>
> >  - Post v1.5.5, start cooking the change that does not install hardlinks
> >    for built-in commands, aiming for inclusion in v1.6.0, by the end of
> >    2008.
>
> I am against this, unless it is configurable. I think the goal of
> reducing user-visible commands is fine, and moving things to
> $(libexecdir) is a good way of doing that.
>
> However, I personally still think the 'git-foo' forms are valuable
> (because fingers have already been trained, and because
> non-bash-programmable completions understand them). And I don't mind
> putting $(libexecdir)/git-core in my PATH to retain this behavior; it's
> a one-time configuration tweak, and it helps new users with the
> overwhelming command set.
>
> But I don't see a point to removing the links entirely. The annoyance
> factor for people who want git-* is much higher, and I don't see that it
> actually buys us any help for new users (who will no longer care after
> everything is hidden in $(libexecdir) anyway).

Maybe only not install hardlinks on systems that do not support it
like Windows? git.exe duplication takes a lot of space.
-- 
Duy
