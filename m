From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [GSoC update] git-remote-svn: Week 11
Date: Mon, 12 Jul 2010 18:00:20 +0200
Message-ID: <4C3B3C14.8040002@drmicha.warpmail.net>
References: <20100712143546.GA17630@debian> <4C3B2B48.4070408@drmicha.warpmail.net> <20100712152403.GH1931@jack.stsp.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Greg Stein <gstein@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Will Palmer <wmpalmer@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Bert Huijben <rhuijben@collab.net>,
	Sam Vilain <sam@vilain.net>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Stefan Sperling <stsp@elego.de>
X-From: git-owner@vger.kernel.org Mon Jul 12 18:01:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYLRc-00035w-3o
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 18:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755913Ab0GLQBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 12:01:19 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:54346 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752997Ab0GLQBS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jul 2010 12:01:18 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0D8DB16D401;
	Mon, 12 Jul 2010 12:01:18 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 12 Jul 2010 12:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=HxGtS7oJ1xg5HwD1lggccY8zjJY=; b=gqmASFiMFBNW2LXbOFF7rEwx1WhdiW9AkGRlsG41eZl0QENQNC9pz+VRzBE8/c78QeammBQkerUKmxukHlXb9HpjaLBadAyADaSj0ytqIFSPM3BGYeoVIFs2wzvd825xU96mofkOncE4dtbgydHCjf9DRNnQXUyIS+fE4Bohtcs=
X-Sasl-enc: Lg82RuQa+8bIkK0zAUXcqVHtK3hZ7P7Y4Wr7fOqb9Wpx 1278950477
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 000464C161A;
	Mon, 12 Jul 2010 12:01:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8pre) Gecko/20100702 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <20100712152403.GH1931@jack.stsp.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150823>

Stefan Sperling venit, vidit, dixit 12.07.2010 17:24:
> On Mon, Jul 12, 2010 at 04:48:40PM +0200, Michael J Gruber wrote:
>> Ramkumar Ramachandra venit, vidit, dixit 12.07.2010 16:35:
>>> it will be pretty painful for Git developers to compile the SVN trunk
>>
>> While this is certainly true for the "compilation" part, at least
>> getting the source is a snap for us:
>>
>> git://git.apache.org/subversion.git
>> git://github.com/apache/subversion.git
> 
> Regarding compilation, take a look at tools/dev/unix-build/Makefile.svn
> in the Subversion tree. Possibly the most painful thing for git devs is
> that you'll need an svn binary somewhere in PATH, but any version will do.
> Then create an empty directory (say, ~/svn), copy the Makefile in there,
> and run make (requires GNU make). That will download and compile Subversion
> from trunk, including various dependencies.
> If all goes well, binaries (with debug symbols) end up in ~/svn/prefix/
> 
> On Linux, -devel packages for a couple of libaries may be needed
> (most likely openssl, zlib, expat, libproxy).
> 
> Stefan

That Makefile pulls in (and compiles) a lot of stuff which may or may
not be what you want.

In terms of Git development, I prefer a Git checkout (rather than a svn
checkout) of the subversion code where I can bisect happily. Fulfilling
most dependencies using devel packages was not a real problem (Fedora
13), just an iterative process...

The most painful part is that older svns (e.g. 1.4.6) don't seem to like
newer autoconf (2.65) so that compatibility testing gets difficult,
especially because (due to the branch structure of the code) merge bases
of, say, 1.5.0 and trunk go quite a way back (1.5.0~955).

Michael
