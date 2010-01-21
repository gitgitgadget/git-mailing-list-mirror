From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] http/remote-curl: coddle picky servers
Date: Thu, 21 Jan 2010 08:24:02 -0800
Message-ID: <20100121162402.GD19078@spearce.org>
References: <20100121004756.GA18213@onerussian.com> <20100121050850.GA18896@Knoppix> <be6fef0d1001202247l7467a14ap8181eb3ed830167a@mail.gmail.com> <20100121155136.17b59e8f.rctay89@gmail.com> <20100121140054.GH18213@onerussian.com> <20100121224100.624c9c9d.rctay89@gmail.com> <20100121155637.GA19078@spearce.org> <20100121160707.GA31276@glandium.org> <be6fef0d1001210820u638f5262jaa062a20fdfbc18b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 17:24:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXzpQ-0005YB-TG
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 17:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818Ab0AUQYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 11:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753652Ab0AUQYN
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 11:24:13 -0500
Received: from mail-iw0-f196.google.com ([209.85.223.196]:50625 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240Ab0AUQYI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 11:24:08 -0500
Received: by iwn34 with SMTP id 34so127083iwn.21
        for <git@vger.kernel.org>; Thu, 21 Jan 2010 08:24:06 -0800 (PST)
Received: by 10.231.59.136 with SMTP id l8mr2629296ibh.51.1264091045782;
        Thu, 21 Jan 2010 08:24:05 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm958893iwn.3.2010.01.21.08.24.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Jan 2010 08:24:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <be6fef0d1001210820u638f5262jaa062a20fdfbc18b@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137666>

Tay Ray Chuan <rctay89@gmail.com> wrote:
> On Fri, Jan 22, 2010 at 12:07 AM, Mike Hommey <mh@glandium.org> wrote:
> > Look closely at the start of the requested URL: /gitweb.cgi...
> > It comes from this rule:
> >
> > RewriteCond %{QUERY_STRING} ^(.+)$
> > RewriteRule ^/(.*)$ /gitweb.cgi$1 [L,PT]
> >
> > which is global to the virtual host.
> >
> > Anyways, while git.debian.org can certainly be fixed for that, other
> > servers may want to do some different things with urls with parameters.
> 
> heh, I was suspecting some URL rewriting was going on.
> 
> Is this an issue that should be fixed in gitweb?

I don't see why it should be.  gitweb isn't a service CGI.  I find
it odd that someone would configure their website to route anything
with a query string into gitweb.  WTF?

-- 
Shawn.
