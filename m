From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Qt/mac, 10.5, qgit
Date: Thu, 30 Aug 2007 13:54:10 +0200
Message-ID: <e5bfff550708300454m438d876ck7de6d1e9508d96af@mail.gmail.com>
References: <65E7CC32-8B78-4037-9BC2-9129D79F377E@loci.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: info@trolltech.com, "Git Mailing List" <git@vger.kernel.org>
To: "Rob Arnold" <rob@loci.net>
X-From: git-owner@vger.kernel.org Thu Aug 30 13:54:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQibJ-00082d-7M
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 13:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958AbXH3LyM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 07:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754891AbXH3LyM
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 07:54:12 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:23533 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689AbXH3LyL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 07:54:11 -0400
Received: by rv-out-0910.google.com with SMTP id k20so132862rvb
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 04:54:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ecsSb5AJhVXVgQhMAhV8oZQTPkqOf/tXsrvjWbhMih/iGvZMR6eRxwGkwa+DdfTCjUh1zMKtRzQkZPgxIU30VBvBOVSCkoPqe0+nCI4xnP//E+OjN7D2AiK6oNCpRL1a0Xo9o1j94gsnpLKWp2/PMEf61ltLyFYEnNFz7gTTQ4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tOHyma/7yn5PWsXy8Y9ITFr1HUxYogVd6m7nVgQLIAuS8+ZgnkrMP/NJBdI4wHr4bcDIa87vwwRlepRAJ/FiuoFvFeCHre7IVfpwrldmDDmV+TtcsSiSr1Z7qlG0XAgCCn9G/AXnnYMoWLRJoDKdvNQcVsBHKhWvaJHPmxeLE8A=
Received: by 10.141.162.16 with SMTP id p16mr202613rvo.1188474850802;
        Thu, 30 Aug 2007 04:54:10 -0700 (PDT)
Received: by 10.140.185.19 with HTTP; Thu, 30 Aug 2007 04:54:10 -0700 (PDT)
In-Reply-To: <65E7CC32-8B78-4037-9BC2-9129D79F377E@loci.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57027>

On 8/30/07, Rob Arnold <rob@loci.net> wrote:
> Wasn't sure where to send this to.  I'm writing to report an issue you
> may want to take a look at, if you don't already know about it.
>

Thanks for your report. Normally would be more convenient to send the
qgit related issues to git mailing list where there are a number of
experienced users.

 Unfortunately I don't have a mac so I cannot reproduce the bug.

If would be great if someone on the list with experience on
installation of qgit on a mac could give us some hints.


Thanks
Marco

Following the original e-mail:

Wasn't sure where to send this to.  I'm writing to report an issue you
may want to take a look at, if you don't already know about it.

I'm far from an expert Qt person, but am a developer and do use git
for revision control on a daily basis.  I thought I'd give compiling
qgit on a seed version of 10.5 a shot, since I liked the idea of a
nicer looking, native interface for a viewer.

I had some issues that looked like they were based on interaction
between qmake and the new xcode 3.  Thought you guys should know, just
in case you somehow don't already.

QGit can be found at:  http://digilander.libero.it/mcostalba/
I was using the Qt 4 version, cloned from:  git://git.kernel.org/pub/
scm/qgit/qgit4.git

The installation procedure in the README doesn't work as written for a
mac.  Qmake doesn't seem to make an xcode project that does anything
useful if you run it in the base project directory, unless you use --
recursive as an option.  However, if you run it from the src
directory, or use --recursive, you do get a seemingly ok
qgit.xcodeproj project.  I don't know if there's a way to generate
Makefiles instead, but my problem lies in the Xcode project.  The
problem comes when you try to build it from XCode.  You get 5 errors
during checking dependencies:

Build setting $(TARGET_BUILD_DIR) undefined
Build setting $(BUILT_PRODUCTS_DIR) undefined
Build setting $(TARGET_TEMP_DIR) undefined
Build setting $(TEMP_DIR) undefined
Build setting $(DERIVED_FILE_DIR) undefined


Not sure why these standard vars are undefined - maybe it's a change
is the way XCode 3 works, but I don't get those errors opening other
projects, and I don't see where those references are in any of the Qt
generated files, so really not sure what's going on with it, or how to
fix it.

I did install the full Qt 4.3.1 .dmg file rather than building Qt
itself from source; not sure if that could be an issue.

In any event, thought I'd let you guys know, not to try to get help or
anyone to fix anything, but just to give you the information, in case
you didn't have it and might find it useful.

Thanks, and I'll continue to use Qt and qgit where I can :)
