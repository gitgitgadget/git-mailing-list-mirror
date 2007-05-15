From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH] Don't use patches/<branch>/current
Date: Tue, 15 May 2007 21:01:43 +0100
Message-ID: <b0943d9e0705151301r7412109qd73a6008b888f8bc@mail.gmail.com>
References: <20070506150852.8985.98091.stgit@yoghurt>
	 <b0943d9e0705150856n771cb696h6e8225a0bbd5d43d@mail.gmail.com>
	 <20070515182549.GB17851@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue May 15 22:01:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho3DU-00030V-0C
	for gcvg-git@gmane.org; Tue, 15 May 2007 22:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbXEOUBq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 16:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754783AbXEOUBq
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 16:01:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:5568 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401AbXEOUBp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 May 2007 16:01:45 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1658965uga
        for <git@vger.kernel.org>; Tue, 15 May 2007 13:01:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DjvVqm3EUkCpfnZdaA++scl4piWg5Q6uUQO4qcYuJENvqNbuxRd0AftENfZ77p1a2XunPkC9ax2zA2YRLgx2qXEXbzEJg4Ignmw/h3xXSj2mzVDm5Pd7qmzaEzGMozKVUtDM2+5HHxUhpeMDD5nSrZ2BMxXz25Nf6KjnKbAzGLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ucl2ucM/uSdMtAmXWohUniQ8NqXAL870LJ178rAyCKcydSMroSuhRRvnZdqkqL/iGx5DHlYxyNfv5LU3On7/xzY18QvL0DND3q8KrjdXT7mFf9/is5Itm9v0dMJlqGlupeBOXT6JXnvyydiMQ0wo96WwOHxtsOZEAQnx1dro4+8=
Received: by 10.66.222.9 with SMTP id u9mr5908143ugg.1179259303605;
        Tue, 15 May 2007 13:01:43 -0700 (PDT)
Received: by 10.67.27.11 with HTTP; Tue, 15 May 2007 13:01:43 -0700 (PDT)
In-Reply-To: <20070515182549.GB17851@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47371>

On 15/05/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-05-15 16:56:33 +0100, Catalin Marinas wrote:
>
> > On 06/05/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> >
> > > The name of the current patch, if any, is always the last line of
> > > patches/<branch>/applied (and there is no current patch if and
> > > only if the "applied" file is empty). So use that instead, and
> > > stop having to worry about keeping the redundant "current" file
> > > up-to-date.
> >
> > I applied this patch. Could you also send me a patch for the
> > bash-completion script as it uses this file?
>
> I realized this myself yesterday or so, and patched it to not need th=
e
> current, applied, and unapplied files. Are you OK with that patch, or
> would you like one that keeps using {,un}applied?

What is the impact on the bash completion for calling StGIT rather
than reading those files? Is it visible? If I integrate the DAG
patches, there probably isn't other way anyway.

> > I think the self.__current_file (same for the base file removed in =
a
> > different patch) should still be available in the Series object and
> > removed when deleting a branch, otherwise you get a "Series
> > directory ... is not empty" exception.
>
> Ah, very true. I'll whip up a fix.
>
> Same question there: are you OK with a single fix for base, current,
> applied, and unapplied, or do you want them separate?

Whatever is easier for you :-), I don't have any preference.

I'll push the patches I integrated in the next hour or so and you can
base your changes on them.

Thanks.

--=20
Catalin
