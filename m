From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] Reencode committer info to utf-8 before formatting mail header
Date: Sun, 14 Jan 2007 20:25:57 +0100
Message-ID: <20070114192557.GA2378@steel.home>
References: <20070113110238.GA2795@steel.home> <200701140042.l0E0gvMT005024@laptop13.inf.utfsm.cl>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	David =?iso-8859-15?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 20:11:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6W2B-0000IP-D8
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:54:15 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V7w-0003eK-Ut
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbXANT0N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 14:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbXANT0N
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 14:26:13 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:57945 "EHLO
	mailout08.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751617AbXANT0N (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jan 2007 14:26:13 -0500
Received: from fwd34.aul.t-online.de 
	by mailout08.sul.t-online.com with smtp 
	id 1H6AzQ-00066A-04; Sun, 14 Jan 2007 20:26:00 +0100
Received: from tigra.home (S+bU5iZYoeCOl7GizECgGY3uTh9GAqReCWNHVzjknRj3ztxwrQk7cR@[84.163.118.52]) by fwd34.sul.t-online.de
	with esmtp id 1H6AzN-2I5bqS0; Sun, 14 Jan 2007 20:25:57 +0100
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id DE900277B6;
	Sun, 14 Jan 2007 20:25:56 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 93C92C79D; Sun, 14 Jan 2007 20:25:57 +0100 (CET)
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200701140042.l0E0gvMT005024@laptop13.inf.utfsm.cl>
User-Agent: Mutt/1.5.12-2006-07-14
X-ID: S+bU5iZYoeCOl7GizECgGY3uTh9GAqReCWNHVzjknRj3ztxwrQk7cR
X-TOI-MSGID: 37eb3b20-69e8-41da-a182-43a905466c36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36867>

Horst H. von Brand, Sun, Jan 14, 2007 01:42:57 +0100:
> Alex Riesen <fork0@t-online.de> wrote:
> > Junio C Hamano, Sat, Jan 13, 2007 02:31:35 +0100:
> > > +/* High bit set, or ISO-2022-INT */
> > > +static int non_ascii(int ch)
> > > +{
> > > +	ch = (ch & 0xff);
> > > +	return ((ch & 0x80) || (ch == 0x1b));
> > > +}
> > > +
> > 
> > "return (ch & 0x0x80) || (ch & 0xff) == 0x1b;" :)
>                 ^^

Oops :)

> Is the same, if ch == 0x9b, it will match the first part anyway.

So it should. 0x9b isn't ASCII.

> The outer parentesis can (should?) go.

It's "question of style", I'm afraid :)
