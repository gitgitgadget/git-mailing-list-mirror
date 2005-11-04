From: David Brown <git@davidb.org>
Subject: Re: CFLAGS usage
Date: Fri, 4 Nov 2005 08:59:03 -0800
Message-ID: <20051104165903.GA13125@old.davidb.org>
References: <118833cc0511040721w7f3990fbw631feaa6a4bda936@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 04 17:59:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY4uD-0001kX-BL
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 17:59:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVKDQ7F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 11:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVKDQ7F
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 11:59:05 -0500
Received: from adsl-64-172-240-129.dsl.sndg02.pacbell.net ([64.172.240.129]:65481
	"EHLO mail.davidb.org") by vger.kernel.org with ESMTP
	id S1750714AbVKDQ7D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 11:59:03 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.54 #1 (Debian))
	id 1EY4u7-0003Tt-Ar; Fri, 04 Nov 2005 08:59:03 -0800
To: Morten Welinder <mwelinder@gmail.com>
Content-Disposition: inline
In-Reply-To: <118833cc0511040721w7f3990fbw631feaa6a4bda936@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11144>

On Fri, Nov 04, 2005 at 10:21:55AM -0500, Morten Welinder wrote:

> Various stuff is being added to CFLAGS, but CFLAGS is not being used
> after being composed in CFLAGS_ALL.

> CFLAGS = -g -O2 -Wall
> ALL_CFLAGS = $(CFLAGS) $(PLATFORM_DEFINES) $(DEFINES)
>                 CFLAGS += -I$(CURLDIR)/include

Make expands variable lazily, so the ALL_CFLAGS expansion only happens at
the point of use, where all of the CFLAGS definitions have been made.

Dave
