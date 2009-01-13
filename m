From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: Help! My ISP blocks repo.or.cz. How to push changes?
Date: Tue, 13 Jan 2009 01:59:46 +0100
Message-ID: <200901130159.47271.markus.heidelberg@web.de>
References: <200901120246.28364.jnareb@gmail.com> <20090112122337.GA7262@glandium.org> <200901130043.04772.jnareb@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Mike Hommey <mh@glandium.org>, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 02:01:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMXeV-0002cL-3H
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 02:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbZAMA7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 19:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753365AbZAMA7b
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 19:59:31 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:38916 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324AbZAMA72 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 19:59:28 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 3E552FBA52BE;
	Tue, 13 Jan 2009 01:59:27 +0100 (CET)
Received: from [89.59.65.79] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LMXct-0006mO-00; Tue, 13 Jan 2009 01:59:27 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <200901130043.04772.jnareb@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+jRnDC+4f6qwW/eRbf1QPjyQv2gd73AqLiNqRG
	9sYnxmXZ97Pm2S6bckLdK1Ym1h4cjEXmxS4i7pDKeXLfYIqCOV
	fOH79/hf5aPHRHjfEoew==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105431>

Jakub Narebski, 13.01.2009:
> P.S. What should I put in core.gitProxy to make it possible to fetch
> via git:// protocol from repo.or.cz?

I'm not sure if this is what you need, but I use this at work for
fetching via git protocol:

[core]
	gitProxy = /etc/gitproxy.sh for kernel.org
	gitProxy = /etc/gitproxy.sh for or.cz
	# and several others ...

gitproxy.sh:
#! /bin/sh
(echo "CONNECT $1:$2 HTTP/1.0"; echo; cat ) | socket <company proxy host> <port> | (read a; read a; cat )

Markus
