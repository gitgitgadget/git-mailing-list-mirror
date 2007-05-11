From: "Marco Costalba" <mcostalba@gmail.com>
Subject: --stdin option for 'git log' [was FFmpeg considering GIT]
Date: Fri, 11 May 2007 13:13:45 +0200
Message-ID: <e5bfff550705110413q28aef3d8k3aeb0d342eeb2016@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Paul Mackerras" <paulus@samba.org>,
	"Brett Schwarz" <brett_schwarz@yahoo.com>,
	"Karl Hasselstr?m" <kha@treskal.com>,
	"Junio C Hamano" <junkio@cox.net>,
	"Carl Worth" <cworth@cworth.org>,
	"Michael Niedermayer" <michaelni@gmx.at>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 11 13:13:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmT4K-0001Yx-BU
	for gcvg-git@gmane.org; Fri, 11 May 2007 13:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756305AbXEKLNr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 07:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755738AbXEKLNr
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 07:13:47 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:28111 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754770AbXEKLNq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 07:13:46 -0400
Received: by nz-out-0506.google.com with SMTP id o1so951010nzf
        for <git@vger.kernel.org>; Fri, 11 May 2007 04:13:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=D8Q9QOQ05rSMUIZx31y2uXAZTsNw/y/VknMEk7sMfl0teq7c/8YLbEHwJIvrdtdUDGAHJ5L0O/1D3MudtiZbbh39CZZP7syq+QrjSgmyZjJPzyRmX2UcAynsY8PnppbtTZpGWKw7/uu7x6SwDGjegpLD9e5xiXLnqYYo9Nv12D4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kYlJebOh9c5Tm1IEn8wQpFsq12ycpWbr8XO3vrW/JsBC/9OHJqlHTAwUXJVCMJRlSCGAFsarRZOJquxQRQOC3ci7nlwBMKZvxotNdlbtT4KEnKsq4BA8dtoQLa+I1HFUKoELs1psGpwPaMiWt4lqR3PaEb/IG1+hgVOsgkzB9U8=
Received: by 10.115.108.1 with SMTP id k1mr952748wam.1178882025348;
        Fri, 11 May 2007 04:13:45 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Fri, 11 May 2007 04:13:45 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46950>

On 5/8/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> Well, we actually do have that. "git log" (or "git-rev-list") really does
> all the heavy lifting. The reason you can do things like "gitk --merge" is
> not because gitk itself has _any_ idea about anything, but because it just
> passes the arguments down to git-rev-list (and hopefully soon git log),
> which really does all the complex stuff.
>

To replace 'git rev-list' with 'git log' an important missing feature,
at least for me, is the support for '--stdin' option of 'git-rev-list'
that currently seems missing in 'git log'

I found this limit while trying to use 'git log' instead of 'git
rev-list'. The problem is that command line arguments could be very
long in some cases, typically when passing a list of sha's values (as
example all the branches sha). This happens of course when 'git log'
is run by script/applications not directly by the user.

Under Linux, command line arguments size limits are _normaly_ enough
(you could have problems for repository with hundreds of
tags/branches), but under *others* OS we are not so lucky.

So with '--stdin' you have an elegant solution to support any kind of
repository under any OS ignoring  the platform limit on command line
length.


 Marco
