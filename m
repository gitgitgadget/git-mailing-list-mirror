From: "marc zonzon" <marc.zonzon@gmail.com>
Subject: Re: how to filter a pull
Date: Thu, 3 May 2007 21:32:52 +0200
Message-ID: <71295b5a0705031232l3dc6a61dh7c0d7f993536fab7@mail.gmail.com>
References: <20070503131704.GA7036@kernoel.kernoel.fr>
	 <20070503150752.GB6500@xp.machine.xx>
	 <7vwszpzs33.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 03 21:33:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjh2w-0007b3-6a
	for gcvg-git@gmane.org; Thu, 03 May 2007 21:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767815AbXECTcz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 15:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767817AbXECTcz
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 15:32:55 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:55744 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767815AbXECTcy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 15:32:54 -0400
Received: by wr-out-0506.google.com with SMTP id 76so649979wra
        for <git@vger.kernel.org>; Thu, 03 May 2007 12:32:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oaUcrsDFj1yKx0BQQ8qJHO3U5gQhbft/qD+70/7ggGmsR2A91cB8pAc5izvlP2QrLcrwJZAw3UmyNhBJNiCoHmbuLYhsBTMREyY1h2Vg5BTN34X0+EcqYN3EnASqhA8SfHmm6TGknRUyZMG+1qv5QRMLYdsuMGbpksawBznt0I8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QpmZH0x4Uw6Fw5DopCDuuLZ69u/obGmm7xDtsae8bNmArzKbkV5CAdnnFkXYk+FF31JgYBxuMsm94VmlRZuqopZ455xkJYo0Fs3HmnjDnMzB8Se/Y0CdsiT3Tq0ws1et1D7idXWkqiKI6aHceHNybvn3Da/itJmnAYKkwsSsl1I=
Received: by 10.78.160.2 with SMTP id i2mr1116307hue.1178220772899;
        Thu, 03 May 2007 12:32:52 -0700 (PDT)
Received: by 10.78.33.10 with HTTP; Thu, 3 May 2007 12:32:52 -0700 (PDT)
In-Reply-To: <7vwszpzs33.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46100>

On 5/3/07, Junio C Hamano <junkio@cox.net> wrote:

> If I were doing this 6 months from now, I would probably use
> subproject to host the whole tree of other projects somewhere,
> adjust the build procedure of the primary project to borrow the whole of these other
> projects not just subtree -- or have appropriate symlinks in the
> superproject that point into relevant subtrees in the
> subprojects.
>
> If I were doing this today, I would probably use separate
> repositories, next to the primary project, to host the whole
> tree of other projects, adjust the build procedure of the
> primary project to borrow the whole of these other projects not
> just subtree -- and/or have appropriate symlinks in the primary
> project that point into relevant subtrees in the neighbouring
> repositories that host these other projects.
>
Thank you for your explanations, I'm not sure to truly understand what
you propose, (I told you I'm a beginner and not amonq the  clever
ones!)

Do you mean that I have to do the patches I do on the fellow project
in the mirror directory, as to keep it as a link? It could be possible
when the project is managed by git (with the drawback of adding an
extra complexity to dereference the links in the repository when
archiving a release, and a lot of problem to export to a public
repository) but is not a possibility when the other project is managed
by an other scm.

I don't understand neither the first solution 'borrow the whole project'.
To better explain the problem I give a practical case.

I'm working to package software for openwrt arm-mipsel system. The
whole openwrt buildsystem is available under subversion, it is a big
tree (not so huge than the kernel you are accustomed to!)

I need in my packages to produce rc scripts and udev conf, hotplug
scripts. They depends of the base rc functions of openwrt (int etc),
the config system (in lib/config), and the hotplug scripts
(/etc/hotplug.d), and I need to patch some of these scripts.
I would like to stay in sync with the development of openwrt, the
change in the patched files are quite frequent but usualy merge
easily. Of course this is only one part of my dependencies, the main
tree that is imported in my project is the original package that I
modify to tailor it to openwrt.

My problem is how to deal with this neither major nor minor dependency.

Thanks for taking time to answer.

Marc
