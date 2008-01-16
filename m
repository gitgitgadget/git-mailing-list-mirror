From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 05:53:13 -0800 (PST)
Message-ID: <m37ii9nagt.fsf@roke.D-201>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com>
	<alpine.LSU.1.00.0801161113170.17650@racer.site>
	<alpine.DEB.1.00.0801161521500.5260@bender.nucleusys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Petko Manolov <petkan@nucleusys.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 14:53:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF8iC-0007SS-Bj
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 14:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbYAPNxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 08:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753458AbYAPNxT
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 08:53:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:36589 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455AbYAPNxS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 08:53:18 -0500
Received: by ug-out-1314.google.com with SMTP id z38so213559ugc.16
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 05:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=7ukqtwdJNcJSgWM7M1pi6Y/R7xOIWxGdDunjEw7kW20=;
        b=rh4cFFsvZWqHH666C8JNFfWqEiNq8tYAmAwjpA9i5mk4WGli4hkLZXo0CaJF+Xi97X8p2k35vMEuV7bv90avKObCR1MKTZbY2QJlb5dwuhPT37HqeSuBOC0UHIJ1+xlth+nr7JlEycnms8d3GgCnyJGsDAqKuEFxVuTiYsf+XCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=WeIb+MUF/XqBwYr6o+t0xOcIHI17HTZW+6CZckKbK0fYbTTg74JvZn2vFPRC5XUhLPh04RkzOYo97aPtTrjgXgRTkP5MhMRRHF07H1rx8jQ1LP//YJDO/9znNWrSRsj9DLw+9nRbqhWR3q6RmOz4eZPfEOy7sEuA8rrMG2dBUxo=
Received: by 10.66.251.20 with SMTP id y20mr2096503ugh.67.1200491594549;
        Wed, 16 Jan 2008 05:53:14 -0800 (PST)
Received: from roke.D-201 ( [83.8.213.34])
        by mx.google.com with ESMTPS id m4sm1839674ugc.73.2008.01.16.05.53.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Jan 2008 05:53:13 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id m0GDr7dF019285;
	Wed, 16 Jan 2008 14:53:08 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0GDr6pS019282;
	Wed, 16 Jan 2008 14:53:06 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <alpine.DEB.1.00.0801161521500.5260@bender.nucleusys.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70671>

Petko Manolov <petkan@nucleusys.com> writes:

> On Wed, 16 Jan 2008, Johannes Schindelin wrote:
> 
> > The answer is no.  You cannot ask git to have the newest version of
> > something, but not the old ones.  It contradicts the distributedness
> > of git, too.
> 
> I don't agree here.  Assume that whatever you're working on require
> firmware for a device that won't change during the lifetime of the
> software project.  The newest version of the said firmware is mostly
> bugfixes and you basically don't want to revert to the older
> ones. Consider the microcode for modern Pentiums, Core 2, etc.
> 
> What i am trying to suggest is that there might be cases when you need
> something in the repository, but you don't want GIT to keep it's
> history nor it's predecessors.  Leaving it out breaks the atomicity of
> such repository and makes the project management more complex.
> 
> There's a few examples out there that shows how to solve this, but it
> seems inconvenient and involves branching, cloning, etc.  Isn't it
> possible to add something like:
> 
>  	"git nohistory firmware.bin"
> 
> or
>  	"git nohistory -i-understand-this-might-be-dangerous firmware.bin"

You can always tag a blob (like junio-gpg-pub tag in git.git repository),
but it wouldn't be in a working directory. But it would get distributed
on clone.

BTW. if those large binary files doesn't differ much between version,
they should get well compressed even if you would store them normally,
all revisions.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
