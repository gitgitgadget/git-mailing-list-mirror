From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch,
 not .txt
Date: Thu, 18 Jan 2007 20:57:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701182053090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com> 
 <7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net> 
 <81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com> 
 <7v64b4ohcj.fsf@assigned-by-dhcp.cox.net>  <81b0412b0701180135r505a75a5j172c70792d6569c0@mail.gmail.com>
  <625fc13d0701180352m151cceb3lf9c00b6cf0ae937b@mail.gmail.com> 
 <81b0412b0701180540x15d20453s3dbc0c061fd06d50@mail.gmail.com> 
 <45AF7FE8.5060003@op5.se>  <81b0412b0701180641v55987657t331d6a1868dabee0@mail.gmail.com>
  <20070118152620.GB15428@spearce.org> <81b0412b0701180752x1664f661o17ce78a7024590f3@mail.gmail.com>
 <45AFCAB1.8010903@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <ae@op5.se>, Josh Boyer <jwboyer@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	davidk@lysator.liu.se
X-From: git-owner@vger.kernel.org Thu Jan 18 20:57:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7dOH-0006MP-D1
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 20:57:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbXART5j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 14:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbXART5j
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 14:57:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:60365 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932463AbXART5i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 14:57:38 -0500
Received: (qmail invoked by alias); 18 Jan 2007 19:57:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 18 Jan 2007 20:57:33 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Steven Grimm <koreth@midwinter.com>
In-Reply-To: <45AFCAB1.8010903@midwinter.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37134>

Hi,

On Thu, 18 Jan 2007, Steven Grimm wrote:

> I looked at that briefly a while ago -- at the prompting of a Windows 
> developer friend of mine who has some interest in git -- and it seemed 
> like the best thing for portability to non-fork()ing systems would 
> probably be a refactor. It looked to me like it'd be possible to 
> reorganize the code such that it'd work all in one process with no 
> threads or forking or anything. Not *trivial*, mind you, but possible. 
> There's nothing in the code path that I saw (I didn't analyze it 
> super-thoroughly) that looked like it actually needed to run in 
> parallel.

ssh transport comes to mind, as well as paging functionality. Sometimes we 
fork() to catch out-of-memory errors more gracefully.

> Of course, the bigger hurdle for a native Windows port is all the shell 
> scripts. Mercurial solves that by using Python for all its scripts, 
> which at least has a native Windows version that can be installed. I 
> wonder if git will/should eventually move its remaining shell scripts to 
> Perl for that reason, Perl being git's de facto non-shell scripting 
> language of choice.

Yeah, sure. We had no problems with Perl ;-)

Seriously, IMHO bash is a smaller dependency: here you can at least rely 
on which extensions are present (none), and which path-name munging is 
present on Windows (/c/windows).

No, the best is not to migrate shell scripts to Perl, but to C.

Ciao,
Dscho
