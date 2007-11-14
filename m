From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: Git and Scmbug integration
Date: Wed, 14 Nov 2007 11:08:59 +1100
Message-ID: <ee77f5c20711131608n6c0b4df4o7eb8a3839a95cdde@mail.gmail.com>
References: <1194980792.4106.6.camel@localhost>
	 <20071113234722.GK3268@steel.home>
	 <ee77f5c20711131553j587cb566id6d76bd23182dd6@mail.gmail.com>
	 <20071114000457.GM3268@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Kristis Makris" <kristis.makris@asu.edu>, git@vger.kernel.org,
	scmbug-users@lists.mkgnu.net
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 01:09:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is5ov-0003h5-2v
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 01:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758622AbXKNAJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 19:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758081AbXKNAJD
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 19:09:03 -0500
Received: from el-out-1112.google.com ([209.85.162.178]:15251 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505AbXKNAJB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 19:09:01 -0500
Received: by el-out-1112.google.com with SMTP id j27so318elf
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 16:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=JCBLcMEVSRd8S+aWdXNNJLqoMXqtwTuTObjdvXgEiz0=;
        b=W/HDmmvza4BuuBBTloxdPHbdNKMOZinZVWxWKRO9/z980gFWy/uZfWtXANsmnDS0BslIPUgHYz7S6JNGNsGH3/X2ltlhyEezITux1W6BWBExQfsJww5nGkJu6UZ7V2sSoPy8Bd3H3hYjwfRT0OgUPqt091S+R4ac4vFAQibyyHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mvzSiWb4L8n9+jA7fOEaj/MeCUFO529VkGsGsf6XKbRcrqSVtvIu4sGd7+PKbUIO1v5xd9Ucq7bDJyQXqKrlWxLIboa9kd1gGVSr6l7sJiSRoxEJy0wTku0UAaKRjUcZya7CrX7CXOH5YJK1t20eVlqj5MCQYnHPhaflvLQNpno=
Received: by 10.142.187.2 with SMTP id k2mr429151wff.1194998939097;
        Tue, 13 Nov 2007 16:08:59 -0800 (PST)
Received: by 10.142.142.12 with HTTP; Tue, 13 Nov 2007 16:08:59 -0800 (PST)
In-Reply-To: <20071114000457.GM3268@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64924>

On Nov 14, 2007 11:04 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
> David Symonds, Wed, Nov 14, 2007 00:53:43 +0100:
> > On Nov 14, 2007 10:47 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
> > > > http://bugzilla.mkgnu.net/show_bug.cgi?id=992
> > > >
> > > > Git does not offer metadata describing a change on the commit trigger
> > > >
> > > > The commit trigger seems to be "post-commit" but it supplies no arguments.
> > >
> > > HEAD?
> >
> > That wouldn't be particularly safe if you have a very quick succession
> > of commits (say, via a rebase, or automated operations) because HEAD
> > could be moved by the time the post-commit hook reads it.
>
> How's that? git-commit waits for its hooks.

Okay, so if it triggers an asynchronous process it just needs to be
careful enough to pass whatever HEAD resolves to at the time. Cool.


Dave.
