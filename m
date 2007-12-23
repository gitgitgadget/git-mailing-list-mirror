From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [msysgit] how to detect git.exe directory?
Date: Sun, 23 Dec 2007 21:04:13 +0100
Message-ID: <e5bfff550712231204m6dad571ct8c2f5e2eb4a23de0@mail.gmail.com>
References: <e5bfff550712230825o5e73bd3dm31057847106b8722@mail.gmail.com>
	 <476EBADE.6080805@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, "Git Mailing List" <git@vger.kernel.org>
To: "Abdelrazak Younes" <younes.a@free.fr>
X-From: git-owner@vger.kernel.org Sun Dec 23 21:04:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6X3w-0005B5-TP
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 21:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbXLWUER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2007 15:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754596AbXLWUER
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Dec 2007 15:04:17 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:17435 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbXLWUEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2007 15:04:16 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1204267rvb.1
        for <git@vger.kernel.org>; Sun, 23 Dec 2007 12:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=s4fRArjU3QJ+3eVvwi9w97H/tL3fUIqbIuBOHFGwdik=;
        b=Z40BTrxi3U2GN5g6LZWFFK6sprB5XtRtD1HaVRVpgziBTX35lhg4tH372pULGBudShT6tneYBLFZ4CwvaKNCWTayMd6yfGq01B0bE/wQG0H+1cvWcvo3c6WtOIJFdNapB0ZmFDZuq0YlKWXXTCfGp4/G9rK/73vBqbqU9soDHX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H7A7CwsjPSnNvgrjs1/gEVbeAXmTmTq+TdRT9daNkwSAFqd3cRUX7I9pSQpU4PtWqCEiyGUdCpTNbyrYa6v09BH3m3mZbYJbPBj8w3d4XqQAvBmzfyRthtv++DX0yiD34S6BYg8sMgSDtgn3fQNC17093qeJBs3Yt4Nkpfzm0EE=
Received: by 10.141.171.6 with SMTP id y6mr1958414rvo.174.1198440253684;
        Sun, 23 Dec 2007 12:04:13 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sun, 23 Dec 2007 12:04:13 -0800 (PST)
In-Reply-To: <476EBADE.6080805@free.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69195>

On Dec 23, 2007 8:45 PM, Abdelrazak Younes <younes.a@free.fr> wrote:
> Marco Costalba wrote:
> > Hi all,
> >
> Glad you manage to do it by yourself. Sorry for not going further with
> compilation as I promised but the git repository had only a MSVC2008
> solution file and I have only MSVC2005 here. I tried to adapt our CMake
> files to qgit but failed...
>

Don't worry, I have installed MSVC2008, compiled Qt4 (and everithing
went smooth) and bruefly tested qgit: it really seems to work, now
following steps are:

- Detect git.exe directory at runtime also when is not in PATH (see below)

- Manage to package qgit and others needed files in a windows
installer (I know very little about this)

>
> > So my question is: "What is the preferred way to detect git directory
> > at runtime for msysgit files?"
>
> If you use QProcess to launch git, maybe you could just use
> QProcess::workingDirectory()?
>

It's not the repository that I don't find, but the git binary
directory. I explain better. If I open a console under windows with
cmd.exe and type "git" when I hit enter button I have an error message
that says that "command git is not known"

This is because git.exe directory is _not_ (normally) in PATH
environment variable.

So, or msysgit installation *modifies* the user PATH adding the bin
directory, or I have to found git bin directory myself and manage to
add to the PATH of qgit process environment.

The question is: "How I find git.exe??"

Marco
