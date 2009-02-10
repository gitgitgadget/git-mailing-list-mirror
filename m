From: Eric Raible <raible@gmail.com>
Subject: Re: RFH: spawning pager takes long time when when unconnected from 
	network
Date: Tue, 10 Feb 2009 03:39:11 -0800
Message-ID: <279b37b20902100339w6e4d215cua41887c65f7c37bc@mail.gmail.com>
References: <loom.20090210T015515-886@post.gmane.org>
	 <4991337B.2010102@viscovery.net>
	 <loom.20090210T085859-630@post.gmane.org>
	 <alpine.DEB.1.00.0902101124160.10279@pacific.mpi-cbg.de>
	 <279b37b20902100253v3cfd8e45kefa6da7de2ea4a4b@mail.gmail.com>
	 <alpine.DEB.1.00.0902101159300.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Raible <raible+git@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 10 12:40:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWqym-0003Bc-6B
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 12:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbZBJLjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 06:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbZBJLjN
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 06:39:13 -0500
Received: from rv-out-0506.google.com ([209.85.198.226]:10650 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbZBJLjM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 06:39:12 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2261835rvb.1
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 03:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jdkjOfoLXePKS+m/7GlLG4eFOaUL5WI6ifXVXCJazC8=;
        b=LubCN2P2+/D0KY1PcPYrtyHNCDs4b1aO+9H/35camUukmehVIf4yYt+wq0EWsdRRTl
         mq8uoi0ELwn6ZAHSMZExisztZJ8Yc5yPWwpd7i4nhOBVSDNKfizwKu8OXa1IjrnqBsf7
         ks87ThvaB/UR3G2OaG/0ygIlv3lP+/4OIprRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=o41EACeDsurJHhpVj3pMZpMcjlr1TI73yL0PoqW9aYRmfUUK1vGod94yMBEucQAyLi
         4IVWPlEhYlpU/MkFkK4RRPN3gNFV+rVNs4Uc1M358LCV/EOYAGPHIvCH62I/2mcguULY
         Mq3KGldqToIYdgannQ7Bv6fo8vTi+BO4hlhDE=
Received: by 10.140.226.14 with SMTP id y14mr4591963rvg.153.1234265951897; 
	Tue, 10 Feb 2009 03:39:11 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902101159300.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109212>

On Tue, Feb 10, 2009 at 3:03 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> You could also try to set it to /bin/false, just so you know if the delay
> is caused by the shell startup.
>
> In my experience, such intermittent delays are often triggered by some
> (mostly unnecessary) calls to either DNS (which might hang for quite some
> time) or domain controllers (same).  These can be triggered by shell
> startup looking for the user or host name.
>
> However, I am just fishing here, as I cannot begin to get an idea what is
> happening on your side.
>
> Also, it does not help that the platform is Windows, an OS I am mostly
> unfamiliar with.  But there have to be profiling tools for that platform
> where you should be able to see what function is blocking (I assume it is
> a blocking call, of course).
>
> Ciao,
> Dscho

Toggling core.pager btwn /bin/false and less is slow the first time,
then quick subsequent times.  Setting core.pager to "echo no pager"
gives the same behavior.

What would be handy is a windows version of strace, but the one
that I found doesn't seem functional.  gdb is useless for this
(so far, anyway).    I think it's time to sleep on this.

Thanks - Eric
