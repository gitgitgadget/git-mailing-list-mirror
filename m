From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git-fast-import
Date: Tue, 6 Feb 2007 19:02:40 +0100
Message-ID: <81b0412b0702061002q2a6359cdwa1369ba8eab6b492@mail.gmail.com>
References: <20070206023111.GB9222@spearce.org>
	 <81b0412b0702060550u3d4064dal43e37593b013f82e@mail.gmail.com>
	 <20070206174336.GB5135@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 06 19:04:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEUeX-0008DK-08
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 19:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbXBFSCp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 13:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933159AbXBFSCp
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 13:02:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:23567 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933150AbXBFSCo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 13:02:44 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1679916uga
        for <git@vger.kernel.org>; Tue, 06 Feb 2007 10:02:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D1ZDmaS8/Lb8yrLCnCvd9kw7Z9Y0LZlDNLANxJMYiZOAWhv4/9qrh5nLPvpkysCvAGNhjvNRnyu+7+jKUx7qGZBuutJ/uXvB3NtPgpa1AcDLrhzb+8HY6h2Gius5vk+GDTQBLo/9pG1RZSvJfTHEfK8uRqLShkBLSTdlMy38WcM=
Received: by 10.78.118.19 with SMTP id q19mr1790588huc.1170784961003;
        Tue, 06 Feb 2007 10:02:41 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Tue, 6 Feb 2007 10:02:40 -0800 (PST)
In-Reply-To: <20070206174336.GB5135@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38866>

On 2/6/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Alex Riesen <raa.lkml@gmail.com> wrote:
> > On 2/6/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > >I'm mainly worried about breaking compliation on odd architectures.
> > >gfi builds, runs and has been used for production level imports
> > >on Mac OS X, Linux and Dragonfly BSD, using both 32 bit and 64 bit
> > >architectures, but some of Git's other targets (e.g. AIX) haven't
> > >seen any testing.
> >
> > Compilation errors are the simplest to fix, just send it in.
>
> True.
>
> But it really is annoying when you download the latest-and-greatest
> release of a package only to find out it doesn't compile on your
> OS of choice, and even worse when you find out it is because of
> new code that you will never use which was added in just before
> the release went final!

Than send it now! :)

> > I have to import lots of data from perforce spaghetti, so I'm very
> > likely to try it out.
>
> I can't help you with spaghetti, but the Qt folks did make their
> Perforce importer available.  Chris Lee put it in the fast-export
> project on repo.or.cz.  Its a relatively short Python program.
> Might help you get started.

Yes, I saw their code. That's how I started thinking of using gfi
in my p4 imports.

> They created annotated tags (with no message) for every p4 changeset.
> I think its just because they didn't realize you can use (abuse?) the
> `reset` command in gfi to create lightweight tags instead.

I found it's useless to do anything with p4 changes. They lack
the most important part of history: parent. The comments get
useless too, because they refer to the most recent change,
with no practical way to extract anything in between. Not much
of a problem, nobody writes anything sensible in perforce
comments anyway.
