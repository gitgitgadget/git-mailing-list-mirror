From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Tue, 27 Nov 2007 12:16:47 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711271214230.27959@racer.site>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site> 
 <fcaeb9bf0711230431x1b0432f6uc9472b2f67514463@mail.gmail.com> 
 <Pine.LNX.4.64.0711231428350.27959@racer.site>
 <fcaeb9bf0711240608w2e5e0812me0e56c1f1a2f8c85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 13:17:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwzNQ-0006Xm-8A
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 13:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754229AbXK0MQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 07:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754178AbXK0MQx
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 07:16:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:59592 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754214AbXK0MQw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 07:16:52 -0500
Received: (qmail invoked by alias); 27 Nov 2007 12:16:50 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp024) with SMTP; 27 Nov 2007 13:16:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+MfORkuW+MIJKHZkkqoT0etWtV/kBlA2a7lx5zab
	JiI4OmSjVsLWX4
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0711240608w2e5e0812me0e56c1f1a2f8c85@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66198>

Hi,

On Sat, 24 Nov 2007, Nguyen Thai Ngoc Duy wrote:

> On Nov 23, 2007 9:31 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > On Fri, 23 Nov 2007, Nguyen Thai Ngoc Duy wrote:
> >
> > > Bundle is very handy for transferring a bunch of commits, but it 
> > > does not (cannot?) hold tags and branches.
> >
> > But they can!  Nothing prevents you from calling
> >
> >         git bundle create a1.bundle refs/tags/v1.0.0 refs/heads/next
> >
> > (At least this is the idea, haven't tested yet).
> 
> It can store commits and heavy tags, but it won't restore tags to 
> refs/tags or advance branches.

The idea is that you fetch them from the bundle.  So something like this 
should do what you want:

	git fetch a1.bundle v1.0.0:refs/tags/v1.0.0

Note that the automatic tag handling of git fetch kicks in with bundles 
just like with other fetch URLs (Unassuming Repository Locators).

Ciao,
Dscho
