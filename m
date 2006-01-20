From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: cygwin-latest: compile errors related to sockaddr_storage, dirent->d_type and dirent->d_ino
Date: Fri, 20 Jan 2006 14:23:14 +0100
Message-ID: <81b0412b0601200523t14e3220fr9365c9e02a981abc@mail.gmail.com>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com>
	 <7vzmlr7lc3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Christopher Faylor <me@cgf.cx>
X-From: git-owner@vger.kernel.org Fri Jan 20 14:23:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzwEb-0000sW-90
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 14:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWATNXS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 08:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWATNXR
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 08:23:17 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:4365 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750949AbWATNXQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 08:23:16 -0500
Received: by uproxy.gmail.com with SMTP id s2so323717uge
        for <git@vger.kernel.org>; Fri, 20 Jan 2006 05:23:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tsOJIxs57zVQmVgB4CtnnDBv42Dm5LLOBnspq/wtG/JHxFrhz34PmKXIoC6vUvNJrBnvbMS6cen4O5mJGisB0TSt6B8NXYh3FZ0RVmQ0KDopJyFdKBvPdDnkoZRvj6hRi/Mkrb9IDuuMVUW/NsNaFAO3qO+Uc4lEedIL+oKn/GI=
Received: by 10.48.127.10 with SMTP id z10mr137734nfc;
        Fri, 20 Jan 2006 05:23:15 -0800 (PST)
Received: by 10.49.14.20 with HTTP; Fri, 20 Jan 2006 05:23:14 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmlr7lc3.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14959>

On 1/20/06, Junio C Hamano <junkio@cox.net> wrote:
> Just removing "-Dsockaddr_storage=sockaddr_in" from ALL_CFLAGS
> seems to solve the problem for new Cygwin.
>
> I doubt that -Dsockaddr_storage=sockaddr_in should be tied to
> NO_IPV6.  Maybe a better approach would be something like the
> attached patch.
>
> Although /usr/include/cygwin/in.h seems to have struct sockaddr_in6,
> getaddrinfo() and friends still do not seem to be there, so
> NO_IPV6 still remains in effect on Cygwin.
>
> Comments?

It compiles, I don't think I can try the daemon though...
