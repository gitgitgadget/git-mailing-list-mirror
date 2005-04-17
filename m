From: Paul Jackson <pj@sgi.com>
Subject: Re: fix mktemp (remove mktemp ;)
Date: Sat, 16 Apr 2005 19:46:16 -0700
Organization: SGI
Message-ID: <20050416194616.27e23f89.pj@sgi.com>
References: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com>
	<20050416233724.GP19099@pasky.ji.cz>
	<20050416170221.38b3e66c.pj@sgi.com>
	<20050417003325.GA15608@redhat.com>
	<20050416174409.59f94c26.pj@sgi.com>
	<4261CC35.4070108@khandalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: omb@khandalf.com, davej@redhat.com, pasky@ucw.cz,
	git@vger.kernel.org, mj@ucw.cz
X-From: git-owner@vger.kernel.org Sun Apr 17 04:43:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMzkZ-0007oK-7b
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 04:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVDQCqr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 22:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVDQCqr
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 22:46:47 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:49343 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261241AbVDQCqp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 22:46:45 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3H3A2a7016023;
	Sat, 16 Apr 2005 20:10:02 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3H2kLlU15271436;
	Sat, 16 Apr 2005 19:46:23 -0700 (PDT)
To: omb@bluewin.ch
In-Reply-To: <4261CC35.4070108@khandalf.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> No, you have to:

How does this compare with the one I posted about 1 hour 30
minuts ago:

	tmp=${TMPDIR-/tmp}
	tmp=$tmp/gitdiff-do.$RANDOM.$RANDOM.$RANDOM.$$
	(umask 077 && mkdir $tmp) || {
		echo "Could not create temporary directory! Exiting." 1>&2 
		exit 1
	}
	t=$tmp/tmp
	trap 'rm -fr $tmp; trap 0; exit 0' 0 1 2 3 15

derived from the reference that Dave Jones provided?

> create it in O_EXCL mode,

What can one do that and hold that O_EXCL from within bash?

> There are thousands of examples of how to do this with bash.

Care to provide one?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
