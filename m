From: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Tue, 27 Apr 2010 00:46:50 +0100
Message-ID: <m2u86ecb3c71004261646zd17cafdcy85cd2ce522a771d5@mail.gmail.com>
References: <4B7D8358.1080108@gmail.com> <fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com> 
	<4B7E3856.3080609@gmail.com> <20100219135549.GA31796@Knoppix> 
	<4B820B4E.7050405@gmail.com> <20100222105133.GA10577@Knoppix> 
	<4B834989.50502@gmail.com> <20100223124553.GA19153@Knoppix> 
	<p2ka038bef51004261441x7e4857f1mc3f03a4104f8e018@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Gabriel Filion <lelutin@gmail.com>, git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 01:47:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Y1E-0001QI-Ln
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 01:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326Ab0DZXrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 19:47:11 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35204 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042Ab0DZXrK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 19:47:10 -0400
Received: by pvg2 with SMTP id 2so800971pvg.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 16:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=GaTi+G2DvPKpbCd7Ho9yYc8B1HnyW7FlOS+nLKmQogw=;
        b=sM3iMvlrjMoEMIx6TpzYQEv5cow5C0I5MC4wNRrZo0yzMC2fbsIfv+E5BFI35vf5Dy
         B0XggjQCcAzZg6WvXbXYeSoqtzeZYmBYAwAibHdpLNkYP9oFXcDV4wzHABD5RCRzy1jH
         jG+D1o0/9uz6Az5wIw7NW/2Sv4BJtjxBu/giU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=uL6OkEdI3FDXSGR9F7uHDrDhYsa02/eoN7lywCibH2aLI8EidEllv885xVTbYLBzA2
         Q5iyDD4D+O1zBSt8iAgokDBNxaj8nDDG5WQUWeGGrnP9qiONjL1tsIp+sgbkclBYqsAt
         d0ZOecuj43JehU9MukU0E9jLimpDYseTE9sh4=
Received: by 10.143.153.28 with SMTP id f28mr2376539wfo.330.1272325630100; 
	Mon, 26 Apr 2010 16:47:10 -0700 (PDT)
Received: by 10.142.224.13 with HTTP; Mon, 26 Apr 2010 16:46:50 -0700 (PDT)
In-Reply-To: <p2ka038bef51004261441x7e4857f1mc3f03a4104f8e018@mail.gmail.com>
X-Google-Sender-Auth: f5cd1f299b0f5791
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145862>

On 26 April 2010 22:41, Chris Packham <judge.packham@gmail.com> wrote:
> Hi,
>
> How far did git-bzr or git-remote-bzr get?
>

Don't know, never used.

As far as I know bzr-git can fetch, clone, commit and push to/from
bzr/git repos. Not sure why you would want git-bzr

> I've tried git-bzr from the repo and I seem to be stumbling on bzr not
> having the fast-export command after I install the fast-import plugin
> as per [1]. So I think its a bazzar problem not a git-bzr one. Has
> anyone got a fully worked example including the installation of the
> required bits and pieces.
>

fast-export would loose information AFAIK use bzr-git with dalwich.

> Alternatively what I'm really trying to do is update a series of
> patches for an upstream project that is managed with bazzar. We have
> 30 or so patches with our customizations so I'd like to get git (or
> bzr) to do the heavy lifting for me. In git I'd do something like this
>
> git clone <upstream>
bzr branch <upstream>
> git checkout <tag that corresponds to the version of the tarball we use>
bzr checkout -rtag:<tagname> tag-branch
> git checkout -b our-patches
cd tag-branch
> git am <patches>
bzr patch patch1 patch2 patch2
> git rebase <tag that corresponds to the new version we want to use>
bzr rebase ../<upstream>
> git format-patch ...
>
bzr log -p; or bazaar send -p or create bundle depends on what you want.

> Anybody got a similar recipe for bzr? (yes I'll go ask on the bzr list too)
>

Although I think you really want
http://wiki.bazaar.canonical.com/BzrPipeline which helps you import
patches ontop of a branch, update upstream, update (merge) patches,
and export them again. It's something like quilt, topgit but
bzr-styled ;-)

> [1] http://github.com/kfish/git-bzr/blob/master/README

=) hope this helps.

ps. anyone can help with repo.or.cz not reusing objects from parent
when pushing to a fork? reported to admin@repo.or.cz they can
reproduce the bug but something dodgy is going on. Thanks. Me will
shut up about bzr now =)
