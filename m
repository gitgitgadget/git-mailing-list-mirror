From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git-submodule getting submodules from the parent repository
Date: Mon, 31 Mar 2008 17:24:13 -0400
Message-ID: <32541b130803311424h339a30e6g4328ea27045c681d@mail.gmail.com>
References: <32541b130803291535m317e84e6p321ebccd5dedaab3@mail.gmail.com>
	 <47F08343.20209@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Mar 31 23:25:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgRUy-0006RN-9O
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 23:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756186AbYCaVYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 17:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756178AbYCaVYP
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 17:24:15 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:4690 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756151AbYCaVYP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 17:24:15 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2040132fgb.17
        for <git@vger.kernel.org>; Mon, 31 Mar 2008 14:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=T5vyh+Gxkl+0XVEF63QBMaSdXJA8wKCpZJsRXx3IRgM=;
        b=hKCPxiHvgYshJOhoYfQm2ab9TqeB4o3g4lBMjVbKnmue9aCQZ0z5Um9Iqydg/j93RpOrz614fSyVsaOI2MpFOCf4/yYf38mQ31sXdrN2DfVP+cZ/8RDrzNRqAJ+V/2bogNkyoOWH3xM7U1stUtPO+GuvMcxR3RHVLXlCFJvw5Jw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M2pRPZQByuoZOVELl5d2LUcfiGho1vufEVw5agGns1rVEkoym0gJP/Eqwqxfb1qZmix2DwxZRkIuQf9USqgxI4j7iNui34gcjti6+BhXGGOoAdcYTFj3WgEPpmpXlS/VBuZIWJglPA44pyvMMK1N+MC0XPsCGOo/aNQNqBIExzU=
Received: by 10.82.171.16 with SMTP id t16mr18093997bue.25.1206998653405;
        Mon, 31 Mar 2008 14:24:13 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Mon, 31 Mar 2008 14:24:13 -0700 (PDT)
In-Reply-To: <47F08343.20209@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78604>

On Mon, Mar 31, 2008 at 2:22 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Avery Pennarun schrieb:
> > It's a  pain to check out / mirror / check in / push.  git-submodule
>  > doesn't even init automatically when you check out A, so you have to
>  > run it yourself.  The relative paths of A, B, and C on your mirror
>  > have to be the same as upstream.  You can't make a local mirror of A
>  > without mirroring B and C.  B and C start out with a disconnected
>  > HEAD, so if you check in, it goes nowhere, and then when you push,
>  > nothing happens, and if you're unlucky enough to pull someone else's
>  > update to A and then "git-submodule update", it forgets your changes
>  > entirely.  When you check in to C, you then have to check in to B, and
>  > then to A, all by hand; and when you git-pull, you'd better to C, then
>  > B, then A, or risk having A try to check out a revision from B that
>  > you haven't pulled, etc.
>
>  Would a "recurse" sub-command help your workflow?
>
>  http://thread.gmane.org/gmane.comp.version-control.git/69834

Well, typing "git submodule recurse push" or something would allow me
to lose the same data without typing quite as much, so strictly
speaking I guess it would be an improvement :)

I'd like it even more if "git push" actually somehow refused to push
at all if I forgot to push in the submodules.

Have fun,

Avery
