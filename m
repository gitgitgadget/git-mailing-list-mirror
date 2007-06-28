From: Josh Triplett <josh@freedesktop.org>
Subject: Re: cloning empty repo
Date: Wed, 27 Jun 2007 18:32:21 -0700
Message-ID: <46830FA5.4020203@freedesktop.org>
References: <467E8808.7030903@gentoo.org> <20070624230157.GM17393@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Marijn Schouten (hkBst)" <hkBst@gentoo.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 28 03:33:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3it8-0002Z2-OG
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 03:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209AbXF1Bdh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 21:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759242AbXF1Bdh
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 21:33:37 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:52038 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759216AbXF1Bdg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 21:33:36 -0400
Received: (qmail 12873 invoked from network); 28 Jun 2007 01:33:35 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail7.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <spearce@spearce.org>; 28 Jun 2007 01:33:35 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.4 (X11/20070622)
In-Reply-To: <20070624230157.GM17393@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51070>

Shawn O. Pearce wrote:
> "Marijn Schouten (hkBst)" <hkBst@gentoo.org> wrote:
>> is there any reason why cloning an empty repository should result in an error
>> instead of a succesfully cloned empty repo?
> 
> There's nothing to clone.  The repository is empty.
> 
> If you create a Git repository using `git init` and then create
> another one also using `git init` then both repositories are empty,
> and an empty repository is identical to every other empty repository.
> 
> So if you want to setup an empty repository and then clone nothing,
> you actually can just setup another empty repository and configure
> the 'origin' remote:
> 
> 	mkdir a; cd a; git init; cd ..
> 
> 	mkdir b; cd b; git init
> 	# now a and b are identical
> 
> 	git remote add origin ../a/.git
> 	# now b is a "clone" of a's nothingness...

You can also simulate a clone of any other repository by using a similar
series of commands; git clone exists so that you don't have to.  Why not allow
cloning an empty repository, which would give you an empty repository with the
correct origin remote?

- Josh Triplett
