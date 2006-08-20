From: fork0@t-online.de (Alex Riesen)
Subject: Re: git refuses to switch to older branches
Date: Sun, 20 Aug 2006 09:26:12 +0200
Message-ID: <20060820072612.GA6003@steel.home>
References: <20060819202558.GE30022@admingilde.org> <7vac601hbb.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 20 09:27:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEhi2-0000rx-JT
	for gcvg-git@gmane.org; Sun, 20 Aug 2006 09:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbWHTH0a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 03:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbWHTH03
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 03:26:29 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:50817 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751667AbWHTH02 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Aug 2006 03:26:28 -0400
Received: from fwd31.aul.t-online.de 
	by mailout09.sul.t-online.com with smtp 
	id 1GEhhK-0004tJ-01; Sun, 20 Aug 2006 09:26:18 +0200
Received: from tigra.home (SmbJnaZLQenbcPYIthkA45sZJMMuDxDT4RfM9ETgYZqpFQvdlcrBwb@[84.160.117.144]) by fwd31.sul.t-online.de
	with esmtp id 1GEhhF-1LCwYC0; Sun, 20 Aug 2006 09:26:13 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 7E15A277AF;
	Sun, 20 Aug 2006 09:26:12 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1GEhhE-0001aR-7I; Sun, 20 Aug 2006 09:26:12 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vac601hbb.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-ID: SmbJnaZLQenbcPYIthkA45sZJMMuDxDT4RfM9ETgYZqpFQvdlcrBwb
X-TOI-MSGID: 3a2b150e-a229-49b8-a467-cb94e05800f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25746>

Junio C Hamano, Sun, Aug 20, 2006 00:39:20 +0200:
> Martin Waitz <tali@admingilde.org> writes:
> 
> > This safety measure is quite useful normally, but for files that are
> > explicitly marked as to-be-ignored it should not be neccessary.
> >
> > But all the code that handles .gitignore is only used by ls-files now.
> > Does it make sense to add exclude handling to unpack-trees.c, too?
> 
> In principle, I am not opposed to the idea of making read-tree
> take the ignore information into consideration.
> 
> But I would suggest you to be _extremely_ careful if you want to

It should be optional. And off by default, people already have got
scripts depending on this behaviour (well, I have).

> try this.  I do not have an example offhand, but I would not be
> surprised at all if there is a valid use case where it is useful
> to have a pattern that matches a tracked file in .gitignore
> file.
> 

Ignored directory and but some files/subdirectories in it are tracked,
because this is temporary or externally changed data (I have both
examples).
