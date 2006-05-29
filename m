From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: irc usage..
Date: Tue, 30 May 2006 10:21:14 +1200
Message-ID: <46a038f90605291521q37f34209wd923608bdebb9084@mail.gmail.com>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>
	 <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com>
	 <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org>
	 <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com>
	 <44720C66.6040304@gentoo.org>
	 <Pine.LNX.4.64.0605221234430.3697@g5.osdl.org>
	 <447215D4.5020403@gentoo.org>
	 <Pine.LNX.4.64.0605221312380.3697@g5.osdl.org>
	 <447231C4.2030508@gentoo.org> <447B6D85.4050601@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Yann Dirson" <ydirson@altern.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Matthias Urlichs" <smurf@smurf.noris.de>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 30 00:21:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkq71-0007es-Ig
	for gcvg-git@gmane.org; Tue, 30 May 2006 00:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWE2WVS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 18:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWE2WVS
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 18:21:18 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:9960 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751430AbWE2WVR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 18:21:17 -0400
Received: by wr-out-0506.google.com with SMTP id i7so971987wra
        for <git@vger.kernel.org>; Mon, 29 May 2006 15:21:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ryv/vMDvg1fZtEIXXiIuklwhzupNtkyJ6IgB6MiRJQSDZxljP+jVWdJEK2afjGueQ5fGwoVIgrsxzoFDxNNgY1XnQHVG6VnICsP+sAFWboRn3Qpbtal//VSKuAEVlT83k0ppRRE/Qe6d6775OxvKomENiC72AxjLWU7JvTd7P2A=
Received: by 10.54.108.19 with SMTP id g19mr2392834wrc;
        Mon, 29 May 2006 15:21:14 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Mon, 29 May 2006 15:21:14 -0700 (PDT)
To: "Donnie Berkholz" <spyderous@gentoo.org>
In-Reply-To: <447B6D85.4050601@gentoo.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20988>

On 5/30/06, Donnie Berkholz <spyderous@gentoo.org> wrote:
> Donnie Berkholz wrote:
> > Linus Torvalds wrote:
> >> The latest stable CVS release is 1.11.21, I think: you seem to be running
> >> the "development" version (1.12.x).
> >
> > Backed down to the 1.11 series, things seem to be going fine so far.
>
> Finally hit an OOM sometime in the past day (yep, a week later) =\. Not
> sure whether it was cvsimport or cvs. Anyone else had more luck?

It seemed like it had finished on the machine I was running it, and I
assumed it was alright in yours too. Looking closer it only made it
till April 2004 -- but it may have been killed by a sysadmin, the
captured log talks about 'signal 9', I have no idea what the OOM
sends.

It had done 285070 of 343822 patchsets.

Have you dropped the -a from the git-repack invocation? That should
help. Try also Linus' patch for git-rev-list. The other thing hurting
us is that the commits are _huge_. I wonder how you guys were managing
this with CVS. Now _this_ explains why cvsimport grows humongous.

I'll try to rework the commit loop so that we don't need to hold all
the filenames in memory. It seems to be choking with the commits after
April 2004. But that will have to wait till tonight.

cheers,



martin
