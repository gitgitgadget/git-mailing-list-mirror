From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Move couple of ifdefs after "include config.mk"
Date: Thu, 1 Dec 2005 10:40:30 +0100
Message-ID: <81b0412b0512010140m1b96db84x70c7d92f8f644a2a@mail.gmail.com>
References: <20051201012333.44bd81f2.tihirvon@gmail.com>
	 <Pine.LNX.4.63.0512010144050.11941@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20051201033201.02b47071.tihirvon@gmail.com>
	 <7vhd9tmw1g.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0512010906400.22709@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vmzjlkx2f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 10:41:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehkva-0003qa-V5
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 10:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbVLAJkc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 04:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbVLAJkc
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 04:40:32 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:64694 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932117AbVLAJkb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 04:40:31 -0500
Received: by nproxy.gmail.com with SMTP id x4so65850nfb
        for <git@vger.kernel.org>; Thu, 01 Dec 2005 01:40:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=crn/7ep3QAqH/cspdSwGfTwKA4490iDR0AU40TzqG1A2JMJ6C848R/vot0umpNZtgUHh+TGv+m4zs1ufh17EmA1axrixRKlqhIKtj8T6A5aQb/Yc/A2skOwJF4XPQLIN2Heqb1HLVw93xXi4f8sHhkjqCUtABz8WWQ9Ifg2Wuns=
Received: by 10.48.221.20 with SMTP id t20mr202085nfg;
        Thu, 01 Dec 2005 01:40:30 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Thu, 1 Dec 2005 01:40:30 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzjlkx2f.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13045>

On 12/1/05, Junio C Hamano <junkio@cox.net> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > But it is only one line, heck only 20 bytes!
>
> Hey, don't get so piped up.  Timo's patch has already been
> merged (thanks, Timo).
>
> But think about it a bit.
>
> If you need an override, you have to write down and maintain
> those YesPlease _somewhere_ yourself anyway, outside what I
> ship.  Either "config.mak" or "Make" script.
>
> If we have '-include' in the Makefile, we need to make a
> decision if what we are adding to the Makefile should be
> overridable by that config.mak every time, exactly because
> whatever is included becomes part of the Makefile.  IOW, that
> "only 20 bytes" adds work for the Makefile maintainer.
>
> "Make" script method is a command line override to the "make"
> program, which takes precedence and does not have that problem.
>

I have even my specific targets in the config.mak (and would actually
like to have the default target put before including config.mak, so
default call to make is always the same).
