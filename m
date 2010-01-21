From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] http/remote-curl: coddle picky servers
Date: Fri, 22 Jan 2010 00:20:26 +0800
Message-ID: <be6fef0d1001210820u638f5262jaa062a20fdfbc18b@mail.gmail.com>
References: <20100121004756.GA18213@onerussian.com>
	 <20100121050850.GA18896@Knoppix>
	 <be6fef0d1001202247l7467a14ap8181eb3ed830167a@mail.gmail.com>
	 <20100121155136.17b59e8f.rctay89@gmail.com>
	 <20100121140054.GH18213@onerussian.com>
	 <20100121224100.624c9c9d.rctay89@gmail.com>
	 <20100121155637.GA19078@spearce.org>
	 <20100121160707.GA31276@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Jan 21 17:20:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXzlt-0003iu-0f
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 17:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289Ab0AUQU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 11:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752926Ab0AUQU2
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 11:20:28 -0500
Received: from mail-iw0-f196.google.com ([209.85.223.196]:40586 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621Ab0AUQU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 11:20:27 -0500
Received: by iwn34 with SMTP id 34so123627iwn.21
        for <git@vger.kernel.org>; Thu, 21 Jan 2010 08:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=llQKWHhh12S2EbMnwH+ENd6xIFJgaWO6T7W5oft0AlE=;
        b=dg3II5dV16gzb3YlFj8ocieP3gNWI5ytSVupCfod5RVsHtdfRlJRdRaufh9oxfoQlc
         1VdT4o7PcjWtzAbk0YcpHh3Kw0ZLPHbnvVcoKCf598IUz0fn01dXaYJSvHxVohBInz+C
         CAFcxKQULJxAAUmjbUUgnH+4ioI49Vozi3wME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=g2Lyh4zztx8GZnNxh7p3bVh+wQOYsT/jxEGL2sqaG4usrIrNoUoL1Ey2aalucAN1cL
         //zi72WpoKloTTl3oEN0PXauO1uG9s4jXt1LKoUPfWvhQayQmPb7Zck9YtSJJvbVsW7G
         HZ5zQaeZZFi93/gHyg+6etpMZnJExSmBipl7E=
Received: by 10.231.148.16 with SMTP id n16mr355067ibv.37.1264090826043; Thu, 
	21 Jan 2010 08:20:26 -0800 (PST)
In-Reply-To: <20100121160707.GA31276@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137665>

Hi,

On Fri, Jan 22, 2010 at 12:07 AM, Mike Hommey <mh@glandium.org> wrote:
> Look closely at the start of the requested URL: /gitweb.cgi...
> It comes from this rule:
>
> RewriteCond %{QUERY_STRING} ^(.+)$
> RewriteRule ^/(.*)$ /gitweb.cgi$1 [L,PT]
>
> which is global to the virtual host.
>
> Anyways, while git.debian.org can certainly be fixed for that, other
> servers may want to do some different things with urls with parameters.

heh, I was suspecting some URL rewriting was going on.

Is this an issue that should be fixed in gitweb?

(added John 'Warthog9' Hawley to the Cc list, perhaps he might know.)

-- 
Cheers,
Ray Chuan
