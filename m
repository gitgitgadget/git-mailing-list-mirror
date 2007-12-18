From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Explain what 'ginstall' is
Date: Tue, 18 Dec 2007 09:20:38 +0100
Message-ID: <200712180920.39633.jnareb@gmail.com>
References: <Pine.LNX.4.64.0712171641370.24957@fractal.phys.lafayette.edu> <m3tzmgpzlu.fsf@roke.D-201> <20071218083843.42d7a15e@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andy Dougherty <doughera@lafayette.edu>, git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Dec 18 09:21:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4XhQ-0006E3-Iw
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 09:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbXLRIUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 03:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbXLRIUu
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 03:20:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:62086 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbXLRIUt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 03:20:49 -0500
Received: by ug-out-1314.google.com with SMTP id z38so63949ugc.16
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 00:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=0ut+TXzdjmF4b0eaByvXHOyAejl0cfGcT4I7AG9fdMs=;
        b=k/piQMORdjneLXd+tsNXTGy4BRtMsgAyZK6vngwVzZipbwvjLkUE8YOC4RnzwcjRUFiYyapHxS2guwOSB2QXyk6Z07H6KfqfNEk3vh1ZEcYIeZQDjja52v4J6funV1FgN5C2ScMs2RPdgOEns98mmVAktAkan0osr0QAPBPZ0NQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=K9t+UHxv59AQLT4oLrgz/gwzvcbM+anD9I0jLqhS+4WXSICRqUt/SyOe0PDCgjBRfXE20Abx7MRx1N71vthNTIJR+Wl/3ZQUzUjhAHMCI6UcJvKQs6Zg9lRYDg3LK9z0QMFvbnZAsg2m+XcmpfShHusKPin3+HkXz6Ub2/6aJ74=
Received: by 10.67.25.6 with SMTP id c6mr523541ugj.65.1197966047825;
        Tue, 18 Dec 2007 00:20:47 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.255.201])
        by mx.google.com with ESMTPS id k28sm1099149ugd.77.2007.12.18.00.20.44
        (version=SSLv3 cipher=OTHER);
        Tue, 18 Dec 2007 00:20:45 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20071218083843.42d7a15e@pc09.procura.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68708>

On Tue, 18 Dec 2007, H.Merijn Brand wrote:
> On Mon, 17 Dec 2007 17:21:08 -0800 (PST), Jakub Narebski wrote:
> 
>> Andy Dougherty <doughera@lafayette.edu> writes:
>> 
>>> [...].  Perhaps configure
>>> should just go looking for a suitable install program instead of
>>> assuming everyone has one.
>> 
>> First, configure is, and (I think) consensus is that it should remain
>> optional.  This means that Makefile "guess" section should have good
>> defaults for your operating system.
> 
> And what if you OS *does* have an install, but one that is completely
> useless^Wdifferent from the GNU install? Like the utterly useless
> install on HP-UX.

Then "guess" section should have INSTALL=ginstall, or something.
Or just install with

  INSTALL=/opt/bin/ginstall make install

or something like that.

>> Second, the default autoconf macro AC_PROG_INSTALL *requires* that
>> there is BSD-compatible `install' program (as 'install-sh' or
>> 'install.sh') in the sources.  Adding such script is (I think) not a
>> problem;
> 
> Yeah!
> 
>> finding minimal portable[*1*] script is.  So if you know one...
>> 
>> Footnotes:
>> ----------
>> [*1*] By "portable" I mean here 'git portable', i.e. requiring only
>> those shell constructs/features that git require, not necessary
>> insanelt portable the way ./configure script is.
> 
> Something like this? (gui part still missing). This is what I now
> use
> 
> --8<--- make-install

Errr... please read more carefully. There is need for BSD-compatibile
`install` program as 'install-sh', not 'make-install' script. The idea
is to use system-provided 'install' if it exists and is compatibile,
because it should be faster than script version, and fallback to 
provided install-sh only if system install is not found.

install-sh has to understand '-d' and '-m <mode>' switches for git 
install purposes, and probably implement all three (src dest, src dir, 
dir) formats.
-- 
Jakub Narebski
Poland
