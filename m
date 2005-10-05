From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: First cut at git port to Cygwin
Date: Wed, 5 Oct 2005 13:24:40 +0200
Message-ID: <81b0412b0510050424h21fc06bav7677911f52b38426@mail.gmail.com>
References: <433B3B10.5050407@zytor.com>
	 <81b0412b0510040531m441ca759k6d1f3fbf0cd248ce@mail.gmail.com>
	 <434299DB.7020805@zytor.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 05 13:26:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EN7OZ-0004aj-4a
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 13:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbVJELYs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 07:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbVJELYr
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 07:24:47 -0400
Received: from nproxy.gmail.com ([64.233.182.196]:26016 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932624AbVJELYp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 07:24:45 -0400
Received: by nproxy.gmail.com with SMTP id a4so51826nfc
        for <git@vger.kernel.org>; Wed, 05 Oct 2005 04:24:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YfeAT10nWtK/o0zQT1RY2BAHgeXGWvS/nSPZx8ZsBTUyM/RtkYvn9yjTPa53fsh4BnXSUZMtx3UZ3pchtvTHtEOmLYKXsS9Sw+nxPkWe9iOIVss/YTgOs1EM/dKZvnK3ke+LhRe3iU2y3r5Hacx7oa8q6DU+PnlbrOfgFjagSW0=
Received: by 10.49.5.11 with SMTP id h11mr33672nfi;
        Wed, 05 Oct 2005 04:24:40 -0700 (PDT)
Received: by 10.48.247.10 with HTTP; Wed, 5 Oct 2005 04:24:40 -0700 (PDT)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <434299DB.7020805@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9704>

On 10/4/05, H. Peter Anvin <hpa@zytor.com> wrote:
> > I noticed that rename(2) in my copy of cygwin (1.5.18-1) does not remove the
> > target and returns an error (probably EPERM, but I have reasons not to trust
> > strerror on that thing).
> > The repository was on FAT.
> > Taking "rename(2)" from cygwin's libiberty solved this (they unlink if link(2)
> > returns EEXIST).
> >
> > PS: Does broken rename(2) qualify a system "not worthy to support"?
>
> I just tried this with Cygwin 1.5.18-1 and didn't have any such
> problems.  I tried it on NTFS, FAT and Samba, using WinXP.

It's on Win2k, there was multiple cygwin installations in path, the other one
supposedly is 1.5.5 (it's from QNX Momentics installation).
I had that old "cygwin1.dll" renamed into "cygwin1.dll-disabled" long
ago, though...
I can't reproduce this out of GIT context, and the error is not
reproducable after
I removed the other cygwin installation out of PATH.
Anyway, sorry, I should have tried this before posting.
