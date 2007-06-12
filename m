From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 5/5] Add gitmodules(5)
Date: Tue, 12 Jun 2007 13:12:07 +0200
Message-ID: <8c5c35580706120412o516ec39p71332d23823d7389@mail.gmail.com>
References: <20070611225918.GD4323@planck.djpig.de>
	 <11816319211097-git-send-email-hjemli@gmail.com>
	 <20070612080402.GQ955MdfPADPa@greensroom.kotnet.org>
	 <8c5c35580706120127p649227d8gc706cb8b364d02b9@mail.gmail.com>
	 <466E7A17.CEB0F196@eudaptics.com>
	 <8c5c35580706120352y24e53a10sf339147b22f1286e@mail.gmail.com>
	 <466E7D7E.7BAB2FD@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Frank Lichtenheld" <frank@lichtenheld.de>,
	"Junio C Hamano" <gitster@pobox.com>, skimo@liacs.nl,
	git@vger.kernel.org
To: "Johannes Sixt" <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 13:12:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy4IG-0006Jn-2Q
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 13:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbXFLLMK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 07:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751974AbXFLLMJ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 07:12:09 -0400
Received: from nz-out-0506.google.com ([64.233.162.232]:53927 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbXFLLMI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 07:12:08 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1609673nzf
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 04:12:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rd7djY9hV2Gm0RRES09A2MVbqVqxN9S5+Eu2MJ699D89GmECtpD73PA2JicOpEloqOLq3uGRzrClzCZ67LL6E0Um7bqSctPNtoA9hWlJZ2JzpKvXNkcJNTFn5OFpcTCmIi3FIh3RHDXHtt44bjbNwmt0VUQoOZnNxArutaHH8UY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nVCVoX2GBeEXM8CTju2W/MRrjvjA8h7xC5dU2NXpwFQf4jFQo7AKygdGvkuq7TB/pv6BgpWLs/XRl2Nyg1hvTDkkGlLc0kFXaEuEn4WXE/kh4kCxsx8x1LYBFkwOXEdiGLz/zZRY/1tYdlzrahPydIsyN85A5YhoyZGCjJw9RPQ=
Received: by 10.115.107.1 with SMTP id j1mr6558878wam.1181646727724;
        Tue, 12 Jun 2007 04:12:07 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Tue, 12 Jun 2007 04:12:07 -0700 (PDT)
In-Reply-To: <466E7D7E.7BAB2FD@eudaptics.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49948>

On 6/12/07, Johannes Sixt <J.Sixt@eudaptics.com> wrote:
> Lars Hjemli wrote:
> >
> > (readded the gitlist)
> >
> > On 6/12/07, Johannes Sixt <J.Sixt@eudaptics.com> wrote:
> > > Lars Hjemli wrote:
> > > > Multiple checkout paths for a single submodule will bring havoc on
> > > > this plan, so I need to ask: what is the use-case for multiple
> > > > checkout paths?
> > >
> > > A use-case is the admin directory in the KDE repository. It has:
> > >
> > > KDE (superproject)
> > >  +- kdelibs (subproject)
> > >  |   +- admin (subproject)
> > >  |   +- subdir1
> > >  |   +- ...
> > >  +- kdebase (subproject)
> > >  |   +- admin (subproject)
> > >  |   +- subdir2
> > >  |   +- ...
> > >  +- kdenetwork (subproject)
> > >  |   +- admin (subproject)
> > >  |   +- subdir3
> > >  |   +- ...
> > >  ...
> >
> > But in this case, 'admin' isn't a submodule/subproject contained by
> > KDE, right? It's contained in three different submodules/subprojects:
> > kdelibs, kdebase and kdenetwork.
>
> Notice how kdelibs, kdebase and kdenetwork are both submodule and
> supermodule: They host the submodule admin and are hosted by KDE.
>

Exactly my point ;-)

> (If I missed the point, then it's because I didn't follow the
> discussion; I jumped in because I noticed the symlink proposal by
> chance.)

In this case, I would assume that e.g. kdelibs contain a submodule
entry for path admin in its index, accompanied by a .gitmodules file
saying that the path admin is mapped to this or that submodule. I
would not expect the KDE 'supersuperproject' to know about admin at
all, neither in its index nor .gitmodules.

--
larsh
