From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: CMake, was Re: [PATCH 09/11] Add MSVC porting header files.
Date: Mon, 17 Aug 2009 22:20:12 +0100
Message-ID: <3f4fd2640908171420j2a359e99ga3d6fc3109547af6@mail.gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-2-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-3-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-4-git-send-email-lznuaa@gmail.com>
	 <alpine.DEB.1.00.0908171902300.4991@intel-tinevez-2-302>
	 <3af572ac0908171231n30864c85ud67454a03ca08fbe@mail.gmail.com>
	 <alpine.DEB.1.00.0908172147240.8306@pacific.mpi-cbg.de>
	 <3af572ac0908171251y355a1e2bjf2d10192bc3eca2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Li <lznuaa@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Mon Aug 17 23:20:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md9ct-0000ec-GC
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 23:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758142AbZHQVUN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 17:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758131AbZHQVUN
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 17:20:13 -0400
Received: from mail-vw0-f172.google.com ([209.85.212.172]:56310 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758126AbZHQVUM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 17:20:12 -0400
Received: by vws2 with SMTP id 2so2716793vws.4
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 14:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YmpjGKcqUAKL7sQ+r9ryfhMk+v4L/4G+SuYegjo6FYo=;
        b=wTHAq/85vtLmWUrm46/ckhSui/WS/EQWgjelkLI+0Tw+pdC2xsN14S7FeIXUgFEruq
         +K6cc0hi/d6IsPFwxRnB3J5Guv9ekTtNeHd2i/DSX0D7IrzcmoX1uZdXfozKiBrvQDdK
         bymgs0sYdYC3dFaoGoMvhdGCHHWbsSg5byAKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RNZc1kGqntWpAa88VKIJFFx4Cx/GPPgf7e3y7qa5KIh48oFvgDXqNJ22lFuKXbmrJS
         fki2ZjUm5rWJez0uq0NuBV9xJAKL/NnxeyYWMc6n/xk0+tb8SYP7QSnAdrw+PYP2DiOR
         wtHWvhVxQj6/hKKGFder7/pXo0tptwmJFRoKU=
Received: by 10.220.42.73 with SMTP id r9mr5428689vce.106.1250544012986; Mon, 
	17 Aug 2009 14:20:12 -0700 (PDT)
In-Reply-To: <3af572ac0908171251y355a1e2bjf2d10192bc3eca2e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126288>

2009/8/17 Pau Garcia i Quiles <pgquiles@elpauer.org>:
> On Mon, Aug 17, 2009 at 9:48 PM, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>
>> On Mon, 17 Aug 2009, Pau Garcia i Quiles wrote:
>>
>>> What about having a CMake build system, which would work on every
>>> platform (including cross-compiling), and would produce an appropri=
ate
>>> config.h and makefiles/vcproj/Eclipse projects/XCode projects/whate=
ver
>>> is fit for each platform? If it's OK to include such a build system
>>> upstream, I'm volunteering to implement it.
>>
>> And reap in another dependency?
>>
>> First Python, then CMake, what tomorrow? =A0Is it the month of addin=
g
>> dependencies?
>
> I'd say it's the month of getting problems solved.
>
> CMake would make git a lot easier to build on Windows, particularly
> with Visual C++. Replace autotools with CMake and suddenly you need t=
o
> maintain a single build system for every platform and compiler git
> supports/will support. That's a sound advantage to me.

Realistically, you'd need CMake for Windows/msvc and autotools for
POSIX systems. I know that CMake is supported on POSIX, but not
everyone has access to it. Poppler, for example, has this dual build
system to support Windows as well as other systems (that, and it has
KDE4 bindings, so CMake is pretty much a given).

=46or CMake to work, it would need to support building all of git
(including the man, html and pdf documents from the asciidoc sources),
the localisation support and the optional packages (OpenSSL, CURL). I
know that KDE uses CMake, so this should all be possible.

- Reece
