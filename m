From: Christopher Faylor <me@cgf.cx>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 2 Mar 2006 19:14:34 -0500
Message-ID: <20060303001434.GA7497@trixie.casa.cgf.cx>
References: <20060302164405.GB7292@trixie.casa.cgf.cx> <20060302165510.GB18929@spearce.org> <20060302220930.GE6183@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Mar 03 01:14:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FExwa-0000kW-Di
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 01:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbWCCAOh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 19:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbWCCAOh
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 19:14:37 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:16857 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1751833AbWCCAOh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 19:14:37 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id 7AA3A4A8168; Thu,  2 Mar 2006 19:14:34 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060302220930.GE6183@steel.home>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17124>

On Thu, Mar 02, 2006 at 11:09:30PM +0100, Alex Riesen wrote:
>Shawn Pearce, Thu, Mar 02, 2006 17:55:10 +0100:
>>Maybe I missed this but why are people using the native Windows
>>ActiveState Perl with GIT+Cygwin when Cygwin has a Cygwin-ized Perl
>>installation available?
>
>because the people _can't_ use cygwin's perl.  There are a lot of
>reasons mainly: administrative, perl script incompatibilities and
>cygwin.dll incompatibilities (if you use perl from cygwin, it'll need
>the correct cygwin.dll.  And if a build process uses cygwin tools from,
>for example, QNX Momentics it often comes to clashes).

(Hmm.  I wonder if QNX Momentics is YA GPL violator)

If you have multiple versions of the Cygwin DLL on your system and try
to use them all jumbled up together then, yes, you will have problems.
This isn't a perl-specific issue.  The solution is to put the latest
version of your Cygwin DLL in your path (presumably in /bin) and delete
all of the older ones.

The newest version is undoubtedly going to be the one downloaded from
the Cygwin web site (http://cygwin.com/) but you can get version
information from the cygwin DLL by using grep:

  grep -a "^%%% Cygwin" WHEREEVER/cygwin1.dll

if you are not inclined to install the newest version of Cygwin.

I'm sure that there are incompatibilities between ActiveState perl and
Cygwin's perl which make it hard to use the same scripts in each so I am
not doubting that some people might want to use only ActiveState perl.
I don't see how the multiple Cygwin DLL issue can be a problem only for
Cygwin perl vs. ActiveState perl.

cgf
(who sees a new full-time job looming in the git list)
