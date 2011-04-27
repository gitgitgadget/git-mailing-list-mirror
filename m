From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 18:40:07 +1000
Message-ID: <BANLkTik8+ECdRsq19xUi1HzTnKoayvLOSw@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<7vwrig9ta7.fsf@alter.siamese.dyndns.org>
	<BANLkTinFX24gTR-0PK8Tyi5aOf8rnLk6Cg@mail.gmail.com>
	<7vsjt49stq.fsf@alter.siamese.dyndns.org>
	<BANLkTinRUaGmF5xqmVGWFurGMtO8Cgb9Hg@mail.gmail.com>
	<7vk4eg9rsf.fsf@alter.siamese.dyndns.org>
	<BANLkTi=UafJRc76ePmVXo2gF+CNVnEL41Q@mail.gmail.com>
	<4DB7CC7C.2050508@drmicha.warpmail.net>
	<BANLkTinrU8LhA0RORde0e5a1TM5VB5gVNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 10:40:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF0IE-0000Bn-Dc
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 10:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811Ab1D0IkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 04:40:11 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40629 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754645Ab1D0IkI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 04:40:08 -0400
Received: by vws1 with SMTP id 1so1114785vws.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 01:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=wROYzLPiF4RLHrBUbuXbvATB58Y0/3RtYnycPb1fsSw=;
        b=NV6LwUwOu8UO3WP3Lp3e/BqOM72PKcEnflPjL0N1WtXiDE3T+lWxg+wmn2N9QeLSQY
         brPrZwprwhP5bVvlNWcAgvf6zpAJ8CHbOpDu4iAWdX07mOkHYsFG08Tn0WnJ/kG9v1SE
         d9DKkmq6WWkVNMfCwJ4RAdrHPvVYZodh0yFXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=A+S4sgKJt151C00WDELtqDZZZ2XjwcNqQDDeYC8aMy8X2XAPCauHVZt9ZpoichxxIB
         kMEKUJzOARN/LDE0yD0L9eb8xFe8Fpa/NeNSEu67zgmIDVpCNPYRvS4N9XrNt1T3sVJ6
         VFccYH+U2tVZHBQ+mu/w0ORQN20rc2xXM+nJw=
Received: by 10.52.95.108 with SMTP id dj12mr2834141vdb.39.1303893607595; Wed,
 27 Apr 2011 01:40:07 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Wed, 27 Apr 2011 01:40:07 -0700 (PDT)
In-Reply-To: <BANLkTinrU8LhA0RORde0e5a1TM5VB5gVNQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172200>

On Wed, Apr 27, 2011 at 6:15 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
> On Wed, Apr 27, 2011 at 5:57 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>
> I also want to avoid baking in any too many decisions about things
> like registries and distribution models. That can come later.

Ok, may be some thoughts about a registry, at least to set a direction...

I like the way brew on MAC OSX uses git to manage formulas managed in
a git repo.

The idea would be to maintain a registry of "git package descriptors".
The descriptors would be a copy of the whatever descriptor an
activated package would be described by, but probably simply a git
config text file, since we already have the tools to parse those.

Such a descriptor would have hints about how to use a real package
manager to get the actual package, but would not actually contain any
files from the package itself.

So, for example, the package source might be bundled in git-core
contrib/ directory, fetchable as a git repo, fetchable as a tar ball,
fetchable as an apt-get package, as brew package etc. The idea is that
gpm would know enough about invoking a real package manager to handle
the actual distribution details.

Once the package is installed by gpm, it is then subject to the local
activation process.

jon.
