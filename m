From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 22:58:19 +0100
Organization: Dewire
Message-ID: <200702132258.20278.robin.rosenberg.lists@dewire.com>
References: <45CFA30C.6030202@verizon.net> <200702131816.27705.litvinov2004@gmail.com> <eqt40c$5ov$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 22:57:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH5eO-0001Ob-BK
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 22:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbXBMV5V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 16:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbXBMV5V
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 16:57:21 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11168 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751243AbXBMV5U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 16:57:20 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 80F67803393;
	Tue, 13 Feb 2007 22:52:27 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 28226-06; Tue, 13 Feb 2007 22:52:27 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 1B4B880338F;
	Tue, 13 Feb 2007 22:52:25 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <eqt40c$5ov$1@sea.gmane.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39587>

tisdag 13 februari 2007 20:36 skrev Mark Levedahl:
> Alexander Litvinov wrote:
> 
> > ? ????????? ?? Tuesday 13 February 2007 16:06 Johannes Schindelin
> > ???????(a):
> >> Hi,
> >>
> >> On Tue, 13 Feb 2007, Alexander Litvinov wrote:
> >> > When I have file that was converted from dos to unix format (or from
> >> > unix to dos) git genereta big diff. But anyway, c++ compiler works well
> >> > with both formats and in this case I simply convert file to dos format
> >> > and git shows again nice diff. If unix format was commited to git I
> >> > simply change the format and commit that file again.
> >>
> >> That's awful!
> > If you are tring to build history that looks good - you are right this is
> > a terrible workflow.
> > 
> >> > The only trouble is the rebase, it does not like \r\n ending and othen
> >> > produce unexpected merge conflict. But I don't use rebse to othen to
> >> > realy investigate and try to solve the problem.
> >>
> >> Well, if everybody thinks like you, maybe we do not have to change
> >> anything for Windows after all?
> > I still wish to have working rebase so if git will hanle somehow \r\n it
> > would be nice. But please do not produce the same behavior as cvs does:
> > under cygwin it still use \n !
> 
> Cygwin != Windows, Cygwin is a POSIX emulation layer with the explicit goal
> of providing user tools behaving exactly as they do under Linux, and this
> includes line ending style.

Line ending style is selectable in cygwin, both on a global level and path level (cygwin 
mounts). If you use CVS for windows development using CRLF works well and
is the only option if you want to use the same working are with both native CVS clients
like TortoiseCVS and the cygwin client. I use the CRLF style by default and LF only
for selected directories. The only annoying thing I see is that files transformed by patch end 
up with LF-only line endings.

> So, the Cygwin ports of various Linux tools are not expected to satisfy
> users who want native Win32 behavior. This is where the mingw port of git
> fits in. Yes, under Cygwin git can track files with \r\n endings, but: 
> 1) Those projects are not portable to non-windows platforms, and 
> 2) As you noted, git will have trouble with rebase, merge, etc. as there is
> an assumption of \n endings throughout.

Even if there is a native port, I'm inclined to want to use the cygwin version 
anyway because of the nice shell and scripting capabilities and large selection of packages
that match what I'm used to in Linux. Git under cygwin should do CRLF transformations 
according to the same rules that apply to text files in cygwin.

-- robin
