From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Why Git is so fast
Date: Fri, 1 May 2009 14:46:55 +0400
Message-ID: <20090501104655.GC4863@dpotapov.dyndns.org>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com> <m3fxfqnxn5.fsf_-_@localhost.localdomain> <b4087cc50904300556s359c91dfu444fa40ea85bd66e@mail.gmail.com> <200904301728.06989.jnareb@gmail.com> <20090430185244.GR23604@spearce.org> <86iqkllw0c.fsf@broadpark.no> <20090501052434.GA4750@dpotapov.dyndns.org> <20090501094221.GB13264@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kjetil Barvik <barvik@broadpark.no>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri May 01 12:47:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzqHL-0007r8-B8
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 12:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451AbZEAKrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 06:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753180AbZEAKra
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 06:47:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:40084 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbZEAKr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 06:47:29 -0400
Received: by fg-out-1718.google.com with SMTP id d23so42531fga.17
        for <git@vger.kernel.org>; Fri, 01 May 2009 03:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=eNfiyferH6Vrs83D9du5EDM0yCcQd5mjaulsXsjmPJo=;
        b=rK6xch+fUSa3/et7L1wpy2lgrimDPeM47mWvdmGd3zXBKLW9NumrZiQskxgg8bxnbf
         PMhMjbtzU0Co7WUiifdg56JqzcJ+aRyGvKoRpYlQHG3koYxtY6TL3A5xDEmP35lF3zn9
         B9vlOV1Im21c0OzrH8uWEW9iaJeaTvb0Ca/EM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=O9Zin86/MMAjV5IsnQG0O3GBXGIMWtc6ZvrqS1AdM4rXlJTi8i74FBI8BZQ/uSfV90
         8adh+uX56kD4al61BP3Zfah7VXft7KUuoSF6JJwFahxsgjvTbibPunp/82I4oLLUy3GP
         K/r3zbWA1biMF3qz7V8aJ9c0vHK+0TkDgKkZ0=
Received: by 10.86.29.8 with SMTP id c8mr2766732fgc.7.1241174847998;
        Fri, 01 May 2009 03:47:27 -0700 (PDT)
Received: from localhost (ppp91-77-226-31.pppoe.mtu-net.ru [91.77.226.31])
        by mx.google.com with ESMTPS id 4sm578015fge.8.2009.05.01.03.47.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 May 2009 03:47:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090501094221.GB13264@glandium.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118075>

On Fri, May 01, 2009 at 11:42:21AM +0200, Mike Hommey wrote:
> On Fri, May 01, 2009 at 09:24:34AM +0400, Dmitry Potapov wrote:
> > 
> > Good compilers can inline memcpy and should produce more efficient code
> > for the target architecture, which can be faster than manually written.
> > On x86_64, memcpy() requires only 3 load/store operations to copy SHA-1
> > while the above code requires 5 operations.
> 
> I guess, though, that some enforced alignment could help produce
> slightly more efficient code on some architectures (most notably sparc,
> which really doesn't like to deal with unaligned words).

Agreed. Enforcing good alignment may be useful. My point was that avoiding
memcpy with modern compilers is rather pointless or even harmful because the
compiler know more about the target architecture than the author of the code.

Dmitry
