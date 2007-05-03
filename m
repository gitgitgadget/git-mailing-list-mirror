From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Thu, 3 May 2007 22:48:40 +1200
Message-ID: <46a038f90705030348o260fbe6cwc92d07778269c937@mail.gmail.com>
References: <200705012346.14997.jnareb@gmail.com>
	 <87lkg61j99.fsf@mid.deneb.enyo.de>
	 <Pine.LNX.4.64.0705031131410.4015@racer.site>
	 <200705031216.19817.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Florian Weimer" <fw@deneb.enyo.de>, git@vger.kernel.org
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu May 03 12:48:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjYrf-0007BL-2F
	for gcvg-git@gmane.org; Thu, 03 May 2007 12:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161819AbXECKsm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 06:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161831AbXECKsl
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 06:48:41 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:60480 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161819AbXECKsk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 06:48:40 -0400
Received: by wx-out-0506.google.com with SMTP id h31so397199wxd
        for <git@vger.kernel.org>; Thu, 03 May 2007 03:48:40 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tt/4K6/v2z7muLF9mH9soBFe33Wh2XOinrSkXd1RHs/Pkph/cGrbp498aAyZ9wQH7U6C4gC3bXbE3zNYQzDOGcRzL+8JUiPmkrTpx78Avt4E55lIDXHYZW7uyZSTxZQaTPF/8pyC+ej2Z3boSIgpz6fcHBzcq9kDvI3GVt+87wM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PJKit+Gs8q6r8QDX54HXPP0RJtlyF37BE/b9pGcIxhO8sXMgpkyUeFOZSxe7322M5EoMFlS4cXlBLYa/NccbSY11pGZo1nuuq2AEJXAq91IWpv/nVGLQiWLbIFfiD8tpsaXQ3oHSjIV1FkNhyJX/IzJXyv5GVIbt2nXZvkx1AH0=
Received: by 10.90.30.20 with SMTP id d20mr1506660agd.1178189320153;
        Thu, 03 May 2007 03:48:40 -0700 (PDT)
Received: by 10.90.75.15 with HTTP; Thu, 3 May 2007 03:48:40 -0700 (PDT)
In-Reply-To: <200705031216.19817.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46079>

[resend - correcting a couple of typos and addressing git@vger
correctly - apologies]

On 5/3/07, Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> The reason is simple. I have a lousy one gigabyte RAM only, while
> git wants 1.7GB virtual to do the diff-stat.  and 800 MB resident. The swap is having a party,

That is true, unfortunately. git will fly if it can fit its working
set plus the kernel stat cache for your working tree in memory. And
the underlying assumption is that for large trees you'll have gobs of
RAM. If things don't fit, it does get rather slow...

But... just to put things in perspective, how long does it take to
*compile* that checkout on that same laptop. I remember reading
instructions to the tune of "don't even try to compile this with less
than 4GB RAM, a couple of CPUs and 12hs". Those were for the OSX build
IIRC.

Ah - it's moved to the general instructions: "Building OOo takes some
time (approx 10-12 hours on standard desktop PC) ":
http://wiki.services.openoffice.org/wiki/Building_OpenOffice.org#Starting_the_real_build

So I don't think anyone working on projects the size of the kernel or
OO.org is going to be happy with 1GB RAM.

cheers


m
