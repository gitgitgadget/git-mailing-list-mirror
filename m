From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] transport.c: call dash-less form of receive-pack and
 upload-pack on remote
Date: Sat, 1 Dec 2007 10:17:03 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712010959180.27959@racer.site>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>
 <Pine.LNX.4.64.0711271617350.27959@racer.site> <20071128000731.GD9174@efreet.light.src>
 <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
 <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0711281917p56cc4228m6c401286439e2a34@mail.gmail.com>
 <alpine.LFD.0.99999.0711290905510.9605@xanadu.home> <7vd4tsvfvk.fsf@gitster.siamese.dyndns.org>
 <DB613F3E-85CC-4AF0-928C-4F4E4C8E9FB8@orakel.ntnu.no>
 <Pine.LNX.4.64.0711301207020.27959@racer.site> <7vlk8f9m52.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eyvind Bernhardsen <eyvind-git-list@orakel.ntnu.no>,
	Nicolas Pitre <nico@cam.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 11:18:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyPQ7-0001WZ-4p
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 11:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbXLAKRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 05:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbXLAKRf
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 05:17:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:49538 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751145AbXLAKRe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 05:17:34 -0500
Received: (qmail invoked by alias); 01 Dec 2007 10:17:31 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp004) with SMTP; 01 Dec 2007 11:17:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1925Wh0FsR29VvWIwGyxtK0GZIkye/bt+ZofZiNvy
	Gd0LwY8S6aXhfP
X-X-Sender: gene099@racer.site
In-Reply-To: <7vlk8f9m52.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66709>

Hi,

On Fri, 30 Nov 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Since we plan to move the dash-form (git-<whatever>) into an execdir, it
> > make sense to prepare our git protocol users for it.
> >
> > Noticed by Eyvind Bernhardsen.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >
> > 	On Fri, 30 Nov 2007, Eyvind Bernhardsen wrote:
> >
> > 	> - When pushing to my system over ssh, git-receive-pack and
> > 	> git-upload-pack are expected to be in $PATH.  I resolved the 
> > 	> problem by putting symlinks in /usr/local/bin.
> >
> > 	How about this?  (I only compile-tested it...)
> 
> I only eyeball-tested it and looks Okay, but that does not assure us
> much ;-).  Is this change easy to test using local transport?

Seems like it breaks down with git-shell.  But then, I think that we just 
have to fix execv_git_cmd() to call builtins via "git" instead.

Ciao,
Dscho
