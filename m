From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: DNS issue when cloning over HTTP and HTTPS
Date: Tue, 18 Jun 2013 00:45:25 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1306180038490.19414@tvnag.unkk.fr>
References: <20130617222356.GA22255@admin.romednet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: LCD 47 <lcd047@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 00:45:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoiB7-0002FI-81
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 00:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645Ab3FQWpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 18:45:32 -0400
Received: from giant.haxx.se ([80.67.6.50]:54978 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525Ab3FQWpb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 18:45:31 -0400
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id r5HMjQda024578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 18 Jun 2013 00:45:26 +0200
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id r5HMjPj5024573;
	Tue, 18 Jun 2013 00:45:25 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20130617222356.GA22255@admin.romednet.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228121>

On Tue, 18 Jun 2013, LCD 47 wrote:

>    Cloning with the git protocol works as expected.
>
> A search on the net shows people having the same problem more than an year 
> ago, and the solution there seems to imply that Git can't cope with async 
> DNS in curl:
>
> http://osdir.com/ml/freebsd-ports-bugs/2012-05/msg00095.html
>
>    Any idea?

It's not a git problem really. When you build libcurl to use c-ares for asynch 
name resolving you unfortunately don't get a really feature complete 
replacement for all stuff the stock synch resolver can do and I believe you 
(and person from that link from last year) experience that.

The solution for you is to:

a) rebuild libcurl with another resolving backend (there's a synch and 
threaded asynch one to choose from)

  or

b) fix c-ares to work "properly" in this scenario as well

-- 

  / daniel.haxx.se
