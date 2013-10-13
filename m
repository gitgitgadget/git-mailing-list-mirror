From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] http: enable keepalive on TCP sockets
Date: Sun, 13 Oct 2013 11:44:09 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1310131142080.22193@tvnag.unkk.fr>
References: <20131012222939.GA24255@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Oct 13 11:44:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVIE1-0004G7-Hh
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 11:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960Ab3JMJoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 05:44:20 -0400
Received: from giant.haxx.se ([80.67.6.50]:43276 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753862Ab3JMJoS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 05:44:18 -0400
Received: from giant.haxx.se (dast@localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-4.1) with ESMTP id r9D9iAFe021721
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Oct 2013 11:44:10 +0200
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id r9D9i9SX021704;
	Sun, 13 Oct 2013 11:44:09 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20131012222939.GA24255@dcvr.yhbt.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236068>

On Sat, 12 Oct 2013, Eric Wong wrote:

> This is a follow up to commit e47a8583a20256851e7fc882233e3bd5bf33dc6e 
> (enable SO_KEEPALIVE for connected TCP sockets).

Just keep in mind that TCP keep-alive is enabled in awkwardly many different 
ways on different systems and this patch only supports one of them. Feel free 
to take inspiration from libcurl's source code for doing this. See:

   https://github.com/bagder/curl/blob/master/lib/connect.c#L108

-- 

  / daniel.haxx.se
