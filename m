From: Motiejus =?utf-8?Q?Jak=C5=A1tys?= <desired.mta@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 10:36:27 +0100
Message-ID: <20110427093627.GH2709@jakstys.lt>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
 <7vwrig9ta7.fsf@alter.siamese.dyndns.org>
 <BANLkTinFX24gTR-0PK8Tyi5aOf8rnLk6Cg@mail.gmail.com>
 <7vsjt49stq.fsf@alter.siamese.dyndns.org>
 <BANLkTinRUaGmF5xqmVGWFurGMtO8Cgb9Hg@mail.gmail.com>
 <7vk4eg9rsf.fsf@alter.siamese.dyndns.org>
 <BANLkTi=UafJRc76ePmVXo2gF+CNVnEL41Q@mail.gmail.com>
 <4DB7CC7C.2050508@drmicha.warpmail.net>
 <BANLkTinrU8LhA0RORde0e5a1TM5VB5gVNQ@mail.gmail.com>
 <BANLkTik8+ECdRsq19xUi1HzTnKoayvLOSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 11:36:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF1Al-0003JQ-Cn
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 11:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756548Ab1D0Jgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 05:36:33 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40804 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756453Ab1D0Jgb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 05:36:31 -0400
Received: by wya21 with SMTP id 21so1095883wya.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 02:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=GejXLI9fBhUZ0zNgLRpAAn4FZQaLlL27pxDJ4EqXXDA=;
        b=QWaS+O56f4b7YJb5lwvEUdD5UQnuzdRIg43A2r6Dl0fjiZOdPmTFykjlQhZFjL8CMt
         6H90DmBHAAkocsScAkrD/KZ6HgxmEHhjdNvVBCpfM/qNWX1r3LIMhtuNKbpGJS+Q/3OM
         nWtQgIDj0Tr//k/ClbVD5wn3PVhR4Z9F58wUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=G4kGr9duHX/eiBLaUaTCaGJ9Sov4JZN5NaN/Ikl2mn/O97gKmxSBs/rLxuwLzXyiL2
         FJOJ1hX29fEc4eP6dzjXMAGNrFZobYvjwlsR8PZy6htJ8aX4dubWe71ShOCSPoSCydDy
         YB5FH4GsO7qFNTbtmUSkTcmkg0J2HrGOtx46Q=
Received: by 10.216.68.17 with SMTP id k17mr1977487wed.109.1303896990243;
        Wed, 27 Apr 2011 02:36:30 -0700 (PDT)
Received: from localhost ([109.246.247.245])
        by mx.google.com with ESMTPS id bs4sm339228wbb.1.2011.04.27.02.36.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2011 02:36:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTik8+ECdRsq19xUi1HzTnKoayvLOSw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172207>

On Wed, Apr 27, 2011 at 06:40:07PM +1000, Jon Seymour wrote:
> On Wed, Apr 27, 2011 at 6:15 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
> > On Wed, Apr 27, 2011 at 5:57 PM, Michael J Gruber
> > <git@drmicha.warpmail.net> wrote:
> >
> The idea would be to maintain a registry of "git package descriptors".
> The descriptors would be a copy of the whatever descriptor an
> activated package would be described by, but probably simply a git
> config text file, since we already have the tools to parse those.
> 
> Such a descriptor would have hints about how to use a real package
> manager to get the actual package, but would not actually contain any
> files from the package itself.

> 
> So, for example, the package source might be bundled in git-core
> contrib/ directory, fetchable as a git repo, fetchable as a tar ball,
> fetchable as an apt-get package, as brew package etc. The idea is that
> gpm would know enough about invoking a real package manager to handle
> the actual distribution details.

Let me check If I get this right:
Say I am a maintainer of enchanced git log -- git logx. It is one .c
file, which has to be simply compiled (cc -o git-logx logx.c).

If I want to maintain the package in a way you are suggesting, I have to
prepare deb, rpm, tarball, zipball, brew (what ever it is, sorry for
non-intelligence) and what not. Otherwise, I lose users? *ball is not
an option, since we are supporting different architectures and cannot
distribute compiled files (unless statically compiled for all
architectures we know, which is not good for obvious reasons).

Morevoer, different debs for different debian releases (if package
depends on libc version)?

Although this looks very nice from user point of view, it would be a
pain for the extension maintainer... Though it's only one C file.

I think shipping it in contrib/ and having extension system is a better
option. Though it leaves a hole for dependencies -- if my logx depends
on boost or imagemagick, we don't want make git depend on it...

Motiejus
